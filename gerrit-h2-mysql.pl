#!/usr/bin/perl
use strict;
use Data::Dumper;
# Limit output displayed otherwise flip to 1
my $debug = 2;

# Config options to set
my %config = (
                "gerrit" =>
                {
                    "host" => "<host in .ssh/config e.g. gerrit-server>"
                },
                "mysql" =>
                {
                    "host" => "<hostname for mysql>",
                    "config" => "<path to config file default my.cnf>",
                    "port" => "<mysql port>",
                    "password" => "<password>"
                },
                "general" =>
                {
                    "h2_csv_dir" => "<path to csv directory>",
                    "mysql_infile_dir" => "<path to mysql infile directory>"
                }
            );

# All tables in H2 reviewdb, this does not include every table in mysql reviewdb
my @h2TablesToMigrate = (
                    "ACCOUNTS",
                    "ACCOUNT_DIFF_PREFERENCES",
                    "ACCOUNT_EXTERNAL_IDS",
                    "ACCOUNT_GROUPS",
                    "ACCOUNT_GROUP_BY_ID",
                    "ACCOUNT_GROUP_BY_ID_AUD",
                    "ACCOUNT_GROUP_MEMBERS",
                    "ACCOUNT_GROUP_MEMBERS_AUDIT",
                    "ACCOUNT_GROUP_NAMES",
                    "ACCOUNT_PATCH_REVIEWS",
                    "ACCOUNT_PROJECT_WATCHES",
                    "ACCOUNT_SSH_KEYS",
                    "CHANGES",
                    "CHANGE_MESSAGES",
                    "PATCH_COMMENTS",
                    "PATCH_SETS",
                    "PATCH_SET_ANCESTORS",
                    "PATCH_SET_APPROVALS",
                    "SCHEMA_VERSION",
                    "STARRED_CHANGES",
                    "SUBMODULE_SUBSCRIPTIONS",
                    "SYSTEM_CONFIG",
                    "TRACKING_IDS"
                );

# These are tables that "gerrit.war init" inserted rows into. In order to have
# a successful migration these tables must be cleared
my @mysqlTablesToClear = (
                        "ACCOUNT_EXTERNAL_IDS",
                        "ACCOUNT_GROUP_ID",
                        "ACCOUNT_GROUP_NAMES",
                        "ACCOUNT_GROUPS",
                        "ACCOUNT_ID",
                        "ACCOUNTS",
                        "SCHEMA_VERSION",
                        "SYSTEM_CONFIG",
                        "CHANGE_ID",
                        "CHANGE_MESSAGE_ID"
                    );

# These are the tables that do not exist in H2 but require updating because they
# handle auto increments.
# Format:
# Table To Upgrade => [Table to get value from, Command to get next increment]
my %mysqlTablesToUpdate = (
                        "ACCOUNT_GROUP_ID" => ["ACCOUNT_GROUPS",
                                               "MAX(GROUP_ID)"],
                        "ACCOUNT_ID" => ["ACCOUNTS",
                                         "MAX(ACCOUNT_ID)"],
                        "CHANGE_ID" => ["CHANGES",
                                        "MAX(CHANGE_ID)"],
                        "CHANGE_MESSAGE_ID" => ["CHANGE_MESSAGES",
                                                "COUNT(*)"]
                    );

my $h2_csv_dir = $config{general}{h2_csv_dir};
my $mysql_infile_dir = $config{general}{mysql_infile_dir};
my $mysqlQueryBase = "mysql -u root --password=$config{mysql}{password} -h $config{mysql}{host} --port=$config{mysql}{port} reviewdb";
my $uniqueSepartor = "@#!!#@";
my $rowSeparator = "#%#";
my $fieldDelimiter = "^";

# Clear rows that are inserted into reviewdb from running "gerrit.war init"
sub mysql_clear_tables
{
    print "Clearing MYSQL Tables...\n";
    foreach my $table (@mysqlTablesToClear)
    {
        print "\t$table\n";
        system("$mysqlQueryBase -e \"truncate $table\"") == 0 or die "mysql query failed: $?";
    }
}

# Dump a csv file for each table in the gerrit H2 database
sub h2_dump_csv
{
    my ($table,$csvFile) = @_;

    # Specify a unique string to avoid conflict with user entered data avoid
    # double and single quotes
    my $query = "ssh $config{gerrit}{host} gerrit gsql -c \\\"call CSVWRITE \\(\\\'$csvFile\\\', \\\'SELECT \\* from $table\\',";
    $query .= "STRINGDECODE\\(\\\'charset=UTF-8 fieldDelimiter=$fieldDelimiter fieldSeparator=$uniqueSepartor rowSeparator=$rowSeparator\\\'\\) \\)\\\"";

    print "\nH2 QUERY>>\n$query\n\n";
    system($query) == 0 or die "h2 query failed: $?";;
    print "<<H2 QUERY Complete\n";
}

sub csv_cleaner
{
    my ($table,$csvFile) = @_;

    # Clean csv files, unfortunately I couldn't figure out a way for H2 csvwrite
    # to directly escape '\' so take care of it here
    print "\nCSV Cleaner>>\n";
    open(CSV, $csvFile) or die ("Cannot open: $csvFile: $!");
    open(CSVTEMP, ">", "$csvFile.tmp") or die("Cannot open: $csvFile.tmp: $!");

    # Get/remove header line of csv to get correct order of columns being inserted
    my $header = <CSV>;
    print CSVTEMP $header;

    # Start at line 2 because we already grabbed header
    my $i=2;
    while (my $line = <CSV>)
    {
        if ($line =~ m/[^\\]\\[^\\]/)
        {
            print "Issue found with '\\' \@line:$i in $csvFile\n" if $debug;
            $line =~ s/\\/\\\\/g;
        }
        # Fix double quotes escaped with another double quote (H2's method)
        # to escaping with '\'  for mysql
        if ($line =~ m/\"\"/)
        {
            print "Issue found with '\"' \@line:$i in $csvFile\n" if $debug > 1;
            $line =~ s/\"\"/\\\"/g;
        }
        $i++;
        print CSVTEMP $line;
    }
    close(CSV);
    close(CSVTEMP);
    system("cp $csvFile.tmp $csvFile");
    system("rm $csvFile.tmp");
    print "<<CSV Cleaner Complete\n";
}

sub get_header_line
{
    my ($table,$csvFile) = @_;

    open(CSV, $csvFile) or die ("Cannot open: $csvFile: $!");
    my $header = <CSV>;

    # Remove $uniqueSepartor and $rowSeparator from header
    chomp($header);
    my $endingLen = length($rowSeparator);
    # Skip the first character (fieldDelimiter) and last character + rowSeparator
    $header = substr($header, 1, (-1*$endingLen)-1);
    $header =~ s/\^$uniqueSepartor\^/,/g;
    print "\nHeader line for $table:\n" if $debug;
    print $header."\n" if $debug;
    close(CSV);

    return $header;
}

sub mysql_load_csv
{
    my ($table,$csvFile,$mysqlFile,$header) = @_;

    # Create mysql file to load csv file, done this way to both simplify mysql
    # query later on and have an easy way to check if each step of this process
    # occurred correctly
    open(MYSQL, ">", $mysqlFile) or die("Cannot open: $mysqlFile: $!");
    print MYSQL "LOAD DATA INFILE \'$csvFile\'\n";
    print MYSQL "INTO TABLE $table\n";
    print MYSQL "FIELDS TERMINATED BY \'$uniqueSepartor\' ENCLOSED BY \'$fieldDelimiter\' LINES TERMINATED BY \'$rowSeparator\\n\'\n";
    print MYSQL "IGNORE 1 ROWS\n($header);\n";
    close(MYSQL);

    # Import csv file into mysql
    my $query = "$mysqlQueryBase < $mysqlFile";
    print "\nMYSQL QUERY>>\n$query\n";
    system($query) == 0 or die "mysql query failed: $?";
    print "<<MYSQL QUERY Complete\n";
}

sub mysql_update_tables
{
    print "Updating MYSQL Tables...\n";
    foreach my $table (keys %mysqlTablesToUpdate)
    {
        print "\t$table\n";
        my $baseTable = $mysqlTablesToUpdate{$table}[0];
        my $cmd = $mysqlTablesToUpdate{$table}[1];
        my $query = "$mysqlQueryBase -e \"INSERT INTO $table SELECT $cmd + 1 FROM $baseTable\"";
        system($query) == 0 or die "mysql query failed: $?";
    }
}

############################### MAIN ###########################################

print "Config:\n" if $debug;
print Dumper \%config if $debug;

# User for gsql will create csv dir but need to create mysql infile dir
system("mkdir -p $mysql_infile_dir");

# Step 1: Purge system generated rows
mysql_clear_tables();

foreach my $table (@h2TablesToMigrate)
{
    print "\n###################### $table ######################\n";
    my $csvFile = "$h2_csv_dir/$table.csv";
    my $mysqlFile = "$mysql_infile_dir/$table.sql";

    # Step 2: H2 QUERY
    h2_dump_csv($table,$csvFile);

    # Step 3: CSV CLEANER
    csv_cleaner($table,$csvFile);

    # Step 4: HEADER LINE
    my $header = get_header_line($table,$csvFile);

    # Step 5: MYSQL QUERY
    mysql_load_csv($table,$csvFile,$mysqlFile,$header);

    print "\n#############################################################\n\n";
}

# Step 6: Update auto-increment tables
mysql_update_tables();
