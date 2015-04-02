# gerrit-h2-mysql #
Tutorial and tool to help those migrating a gerrit instance with an embedded H2 database to one with mysql (mariadb as well)<br>
I kept this very basic to limit the amount of packages and libraries need to run the perl script

Inspired by original support I found:<br>
https://groups.google.com/forum/#!searchin/repo-discuss/Convert$20Gerrit$20database/repo-discuss/KiDVyDJg5u4/2-wKVb0eNkUJ

##### Assumptions #####

- This tool assumes you have a current Gerrit instance with H2 running and knowledge of gerrit
- In order to migrate to a mysql based database, some gerrit settings will need to be changed after the migration
- If you would like to go back to the h2 database, you can use your original settings. However be aware you will lose data if you do so after restarting gerrit and data is published to it.

##### Disclaimer/Issues #####
"Just watch out for the CSV dump-load process to make sure<br>
they are using the same escaping rules for data values, same table<br>
column orderings, and that you got every table in the schema."(from google group forum)

1. The CSVWRITE function for H2 had a few mistmatches with MYSQL. My attempt to fix all the issues<br>
is done in the CSV Cleaner portion of each table dump. Change $debug to > 2 in the script to see issues found
2. There may also be issues with the user running this migration and the user that the gerrit server is running under.<br> I was able to make this work running as a different user than the owner of the gerrit server.

##### Step 1: Download/Install/Update Database (mysql or mariadb) #####

Create reviewdb database

##### Step 2: Initialize a new MySQL database for Gerrit using a temporary site #####
"*MAKE SURE YOU USE THE SAME VERSION OF YOUR CURRENT GERRIT INSTANCE*<br>
Just run the standard installation procedure to setup a MySQL instance of Gerrit Code Review in a temporary site path.<br>
You'll wind up with a clean database schema in your MySQL server, and this dummy site directory directory you can clean up later." (from google group forum)<br>

Make sure the gerrit server has the following /etc/gerrit.config<br>
*Note type is mysql even for mariadb
```
[database]
    type = mysql
    hostname = <hostname>
    port = <port>
    database = reviewd
    username = root
```

Shutdown your mysql based temporary gerrit server

##### Step 3: Setup ssh hostname for permanent gerrit #####

Create .ssh/config file in home (~/) and add the following to the config file
```
  Host gerrit-server
      Hostname <hostname of permanent gerrit server>
      Port <port default is 29418>
      AFSTokenPassing no [possibly needed]
```

##### Step 4: Fill in config hash in gerrit-h2-mysql.pl #####

Currently not using a config file due to libraries needed
```perl
my %config = (
                "gerrit" =>
                {
                    "host" => "<host in .ssh/config e.g. gerrit-server>"
                },
                "mysql" =>
                {
                    "host" => "<hostname for mysql>",
                    "config" => "<path to config file default my.cnf>",
                    "port" => "<mysql port>"
                },
                "general" =>
                {
                    "h2_csv_dir" => "<path to csv directory>",
                    "mysql_infile_dir" => "<path to mysql infile directory>"
                }
            );
```

##### Step 5: Dump initialized reviewdb for easy restart #####

This init dump file already exists in gerrit-h2-mysql as gerrit_init.sql, but if you want to manually generate
```bash
mysqldump -u root -p -h <hostname> --port=<port> reviewdb > <dump file path>
```

##### Step 6: Migration #####

Takes variable length, and due to the CSV Cleaner steps files are processed line by line.<br>
This was a quick and dirty solution to fix the issues I found and didn't add too much time in my case
```bash
cd gerrit-h2-mysql
./gerrit-h2-mysql.pl
```

If you run into issues here are some settings to mess around with.<br>
I tried to separate fields and lines differently from the traditional method ("col1","col2","col3")<br>

Current values in the script that can be modified
```
my $uniqueSepartor = "@#!!#@";
my $rowSeparator = "#%#";
my $fieldDelimiter = "^";
```
The variables mean the following:
```
$fieldDelimiterCOLUMN1$fieldDelimiter$uniqueSepartor$fieldDelimiterCOLUMN2$fieldDelimiter$rowSeparator
```
Example with the current settings:
```
^column1^@#!!#@^column2^@#!!#@^column3^#%#
^column1b^@#!!#@^column2b^@#!!#@^column3b^#%#
```

If there are issues remember to use gerrit_init.sql to reload the base reviewdb state, and most likely this is due<br>
to the csv format not being parsed correctly.

##### Step 7: Update permanent gerrit server's gerrit.config and secure.config #####

See step 2 for gerrit.config options, but do for permanent gerrit instance<br>
As for secure.config add the following
```
[database]
    password = <password>
```

##### Step 8: Restart permanent gerrit server #####

##### Step 9: Clean up #####

You can remove the temporary gerrit site, it was only used to initialize the mysql database

