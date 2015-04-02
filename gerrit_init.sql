-- MySQL dump 10.14  Distrib 5.5.41-MariaDB, for Linux (x86_64)
--
-- Host: gfw154.aus.stglabs.ibm.com    Database: reviewdb
-- ------------------------------------------------------
-- Server version	5.5.41-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `reviewdb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `reviewdb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `reviewdb`;

--
-- Table structure for table `account_diff_preferences`
--

DROP TABLE IF EXISTS `account_diff_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_diff_preferences` (
  `context` smallint(6) NOT NULL DEFAULT '0',
  `expand_all_comments` char(1) NOT NULL DEFAULT 'N',
  `ignore_whitespace` char(1) NOT NULL DEFAULT '',
  `intraline_difference` char(1) NOT NULL DEFAULT 'N',
  `line_length` int(11) NOT NULL DEFAULT '0',
  `manual_review` char(1) NOT NULL DEFAULT 'N',
  `retain_header` char(1) NOT NULL DEFAULT 'N',
  `show_line_endings` char(1) NOT NULL DEFAULT 'N',
  `show_tabs` char(1) NOT NULL DEFAULT 'N',
  `show_whitespace_errors` char(1) NOT NULL DEFAULT 'N',
  `skip_deleted` char(1) NOT NULL DEFAULT 'N',
  `skip_uncommented` char(1) NOT NULL DEFAULT 'N',
  `syntax_highlighting` char(1) NOT NULL DEFAULT 'N',
  `tab_size` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_diff_preferences`
--

LOCK TABLES `account_diff_preferences` WRITE;
/*!40000 ALTER TABLE `account_diff_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_diff_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_external_ids`
--

DROP TABLE IF EXISTS `account_external_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_external_ids` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `email_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `external_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`external_id`),
  KEY `account_external_ids_byAccount` (`account_id`),
  KEY `account_external_ids_byEmail` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_external_ids`
--

LOCK TABLES `account_external_ids` WRITE;
/*!40000 ALTER TABLE `account_external_ids` DISABLE KEYS */;
INSERT INTO `account_external_ids` VALUES (1,NULL,NULL,'gerrit:smcprek');
/*!40000 ALTER TABLE `account_external_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_group_by_id`
--

DROP TABLE IF EXISTS `account_group_by_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_group_by_id` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `include_uuid` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`,`include_uuid`),
  KEY `account_group_id_byInclude` (`include_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_group_by_id`
--

LOCK TABLES `account_group_by_id` WRITE;
/*!40000 ALTER TABLE `account_group_by_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_group_by_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_group_by_id_aud`
--

DROP TABLE IF EXISTS `account_group_by_id_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_group_by_id_aud` (
  `added_by` int(11) NOT NULL DEFAULT '0',
  `removed_by` int(11) DEFAULT NULL,
  `removed_on` timestamp NULL DEFAULT NULL,
  `added_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `group_id` int(11) NOT NULL DEFAULT '0',
  `include_uuid` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`added_on`,`group_id`,`include_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_group_by_id_aud`
--

LOCK TABLES `account_group_by_id_aud` WRITE;
/*!40000 ALTER TABLE `account_group_by_id_aud` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_group_by_id_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_group_id`
--

DROP TABLE IF EXISTS `account_group_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_group_id` (
  `s` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  UNIQUE KEY `s` (`s`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_group_id`
--

LOCK TABLES `account_group_id` WRITE;
/*!40000 ALTER TABLE `account_group_id` DISABLE KEYS */;
INSERT INTO `account_group_id` VALUES (1),(2),(3),(4),(5);
/*!40000 ALTER TABLE `account_group_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_group_members`
--

DROP TABLE IF EXISTS `account_group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_group_members` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`,`group_id`),
  KEY `account_group_members_byGroup` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_group_members`
--

LOCK TABLES `account_group_members` WRITE;
/*!40000 ALTER TABLE `account_group_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_group_members_audit`
--

DROP TABLE IF EXISTS `account_group_members_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_group_members_audit` (
  `added_by` int(11) NOT NULL DEFAULT '0',
  `removed_by` int(11) DEFAULT NULL,
  `removed_on` timestamp NULL DEFAULT NULL,
  `account_id` int(11) NOT NULL DEFAULT '0',
  `added_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`,`added_on`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_group_members_audit`
--

LOCK TABLES `account_group_members_audit` WRITE;
/*!40000 ALTER TABLE `account_group_members_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_group_members_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_group_names`
--

DROP TABLE IF EXISTS `account_group_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_group_names` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_group_names`
--

LOCK TABLES `account_group_names` WRITE;
/*!40000 ALTER TABLE `account_group_names` DISABLE KEYS */;
INSERT INTO `account_group_names` VALUES (1,'Administrators'),(2,'Anonymous Users'),(4,'Non-Interactive Users'),(5,'Project Owners'),(3,'Registered Users');
/*!40000 ALTER TABLE `account_group_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_groups`
--

DROP TABLE IF EXISTS `account_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_groups` (
  `description` text,
  `group_type` varchar(8) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `group_uuid` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `owner_group_uuid` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `visible_to_all` char(1) NOT NULL DEFAULT 'N',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_groups`
--

LOCK TABLES `account_groups` WRITE;
/*!40000 ALTER TABLE `account_groups` DISABLE KEYS */;
INSERT INTO `account_groups` VALUES ('Gerrit Site Administrators','INTERNAL','1307ef9556a73a89d3e07485c15b36426237023a','Administrators','1307ef9556a73a89d3e07485c15b36426237023a','N',1),('Any user, signed-in or not','SYSTEM','global:Anonymous-Users','Anonymous Users','1307ef9556a73a89d3e07485c15b36426237023a','N',2),('Any signed-in user','SYSTEM','global:Registered-Users','Registered Users','1307ef9556a73a89d3e07485c15b36426237023a','N',3),('Users who perform batch actions on Gerrit','INTERNAL','e9fe81e692c3bc7c485e8b86781c0def3e6f91db','Non-Interactive Users','1307ef9556a73a89d3e07485c15b36426237023a','N',4),('Any owner of the project','SYSTEM','global:Project-Owners','Project Owners','1307ef9556a73a89d3e07485c15b36426237023a','N',5);
/*!40000 ALTER TABLE `account_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_id`
--

DROP TABLE IF EXISTS `account_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_id` (
  `s` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  UNIQUE KEY `s` (`s`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_id`
--

LOCK TABLES `account_id` WRITE;
/*!40000 ALTER TABLE `account_id` DISABLE KEYS */;
INSERT INTO `account_id` VALUES (1);
/*!40000 ALTER TABLE `account_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_patch_reviews`
--

DROP TABLE IF EXISTS `account_patch_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_patch_reviews` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `file_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `change_id` int(11) NOT NULL DEFAULT '0',
  `patch_set_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`,`file_name`,`change_id`,`patch_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_patch_reviews`
--

LOCK TABLES `account_patch_reviews` WRITE;
/*!40000 ALTER TABLE `account_patch_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_patch_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_project_watches`
--

DROP TABLE IF EXISTS `account_project_watches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_project_watches` (
  `notify_abandoned_changes` char(1) NOT NULL DEFAULT 'N',
  `notify_all_comments` char(1) NOT NULL DEFAULT 'N',
  `notify_new_changes` char(1) NOT NULL DEFAULT 'N',
  `notify_new_patch_sets` char(1) NOT NULL DEFAULT 'N',
  `notify_submitted_changes` char(1) NOT NULL DEFAULT 'N',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `filter` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `project_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`,`filter`,`project_name`),
  KEY `account_project_watches_byP` (`project_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_project_watches`
--

LOCK TABLES `account_project_watches` WRITE;
/*!40000 ALTER TABLE `account_project_watches` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_project_watches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_ssh_keys`
--

DROP TABLE IF EXISTS `account_ssh_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_ssh_keys` (
  `ssh_public_key` text NOT NULL,
  `valid` char(1) NOT NULL DEFAULT 'N',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `seq` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`,`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_ssh_keys`
--

LOCK TABLES `account_ssh_keys` WRITE;
/*!40000 ALTER TABLE `account_ssh_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_ssh_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `contact_filed_on` timestamp NULL DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `change_screen` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `comment_visibility_strategy` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `copy_self_on_email` char(1) NOT NULL DEFAULT 'N',
  `date_format` varchar(10) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `diff_view` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `download_command` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `download_url` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `maximum_page_size` smallint(6) NOT NULL DEFAULT '0',
  `relative_date_in_change_table` char(1) NOT NULL DEFAULT 'N',
  `reverse_patch_set_order` char(1) NOT NULL DEFAULT 'N',
  `show_site_header` char(1) NOT NULL DEFAULT 'N',
  `show_user_in_review` char(1) NOT NULL DEFAULT 'N',
  `time_format` varchar(10) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `use_flash_clipboard` char(1) NOT NULL DEFAULT 'N',
  `inactive` char(1) NOT NULL DEFAULT 'N',
  `preferred_email` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `registered_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `account_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`),
  KEY `accounts_byPreferredEmail` (`preferred_email`),
  KEY `accounts_byFullName` (`full_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (NULL,'STEPHEN M. CPREK',NULL,NULL,'N',NULL,NULL,NULL,NULL,25,'N','N','Y','N',NULL,'Y','N',NULL,'2015-03-25 16:52:47',1);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_id`
--

DROP TABLE IF EXISTS `change_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_id` (
  `s` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  UNIQUE KEY `s` (`s`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_id`
--

LOCK TABLES `change_id` WRITE;
/*!40000 ALTER TABLE `change_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_message_id`
--

DROP TABLE IF EXISTS `change_message_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_message_id` (
  `s` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  UNIQUE KEY `s` (`s`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_message_id`
--

LOCK TABLES `change_message_id` WRITE;
/*!40000 ALTER TABLE `change_message_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_message_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_messages`
--

DROP TABLE IF EXISTS `change_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_messages` (
  `author_id` int(11) DEFAULT NULL,
  `message` text,
  `patchset_change_id` int(11) DEFAULT NULL,
  `patchset_patch_set_id` int(11) DEFAULT NULL,
  `written_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `change_id` int(11) NOT NULL DEFAULT '0',
  `uuid` varchar(40) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`change_id`,`uuid`),
  KEY `change_messages_byPatchset` (`patchset_change_id`,`patchset_patch_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_messages`
--

LOCK TABLES `change_messages` WRITE;
/*!40000 ALTER TABLE `change_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changes`
--

DROP TABLE IF EXISTS `changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changes` (
  `change_key` varchar(60) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `current_patch_set_id` int(11) NOT NULL DEFAULT '0',
  `dest_branch_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `dest_project_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `last_sha1_merge_tested` varchar(40) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `last_updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mergeable` char(1) NOT NULL DEFAULT 'N',
  `open` char(1) NOT NULL DEFAULT 'N',
  `owner_account_id` int(11) NOT NULL DEFAULT '0',
  `sort_key` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `status` char(1) NOT NULL DEFAULT '',
  `subject` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `topic` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `row_version` int(11) NOT NULL DEFAULT '0',
  `change_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`change_id`),
  KEY `changes_byOwnerOpen` (`open`,`owner_account_id`,`created_on`,`change_id`),
  KEY `changes_byOwnerClosed` (`open`,`owner_account_id`,`last_updated_on`),
  KEY `changes_submitted` (`status`,`dest_project_name`,`dest_branch_name`,`last_updated_on`),
  KEY `changes_allOpen` (`open`,`sort_key`),
  KEY `changes_byProjectOpen` (`open`,`dest_project_name`,`sort_key`),
  KEY `changes_byProject` (`dest_project_name`),
  KEY `changes_allClosed` (`open`,`status`,`sort_key`),
  KEY `changes_byBranchClosed` (`status`,`dest_project_name`,`dest_branch_name`,`sort_key`),
  KEY `changes_key` (`change_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changes`
--

LOCK TABLES `changes` WRITE;
/*!40000 ALTER TABLE `changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patch_comments`
--

DROP TABLE IF EXISTS `patch_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patch_comments` (
  `author_id` int(11) NOT NULL DEFAULT '0',
  `line_nbr` int(11) NOT NULL DEFAULT '0',
  `message` text,
  `parent_uuid` varchar(40) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `range_end_character` int(11) DEFAULT NULL,
  `range_end_line` int(11) DEFAULT NULL,
  `range_start_character` int(11) DEFAULT NULL,
  `range_start_line` int(11) DEFAULT NULL,
  `side` smallint(6) NOT NULL DEFAULT '0',
  `status` char(1) NOT NULL DEFAULT '',
  `written_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `file_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `change_id` int(11) NOT NULL DEFAULT '0',
  `patch_set_id` int(11) NOT NULL DEFAULT '0',
  `uuid` varchar(40) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`file_name`,`change_id`,`patch_set_id`,`uuid`),
  KEY `patch_comment_drafts` (`status`,`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patch_comments`
--

LOCK TABLES `patch_comments` WRITE;
/*!40000 ALTER TABLE `patch_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `patch_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patch_set_ancestors`
--

DROP TABLE IF EXISTS `patch_set_ancestors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patch_set_ancestors` (
  `ancestor_revision` varchar(40) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `change_id` int(11) NOT NULL DEFAULT '0',
  `patch_set_id` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`change_id`,`patch_set_id`,`position`),
  KEY `patch_set_ancestors_desc` (`ancestor_revision`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patch_set_ancestors`
--

LOCK TABLES `patch_set_ancestors` WRITE;
/*!40000 ALTER TABLE `patch_set_ancestors` DISABLE KEYS */;
/*!40000 ALTER TABLE `patch_set_ancestors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patch_set_approvals`
--

DROP TABLE IF EXISTS `patch_set_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patch_set_approvals` (
  `change_open` char(1) NOT NULL DEFAULT 'N',
  `change_sort_key` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `granted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `value` smallint(6) NOT NULL DEFAULT '0',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `category_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `change_id` int(11) NOT NULL DEFAULT '0',
  `patch_set_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`,`category_id`,`change_id`,`patch_set_id`),
  KEY `patch_set_approvals_openByUser` (`change_open`,`account_id`),
  KEY `patch_set_approvals_closedByU` (`change_open`,`account_id`,`change_sort_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patch_set_approvals`
--

LOCK TABLES `patch_set_approvals` WRITE;
/*!40000 ALTER TABLE `patch_set_approvals` DISABLE KEYS */;
/*!40000 ALTER TABLE `patch_set_approvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patch_sets`
--

DROP TABLE IF EXISTS `patch_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patch_sets` (
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `draft` char(1) NOT NULL DEFAULT 'N',
  `revision` varchar(40) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `uploader_account_id` int(11) NOT NULL DEFAULT '0',
  `change_id` int(11) NOT NULL DEFAULT '0',
  `patch_set_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`change_id`,`patch_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patch_sets`
--

LOCK TABLES `patch_sets` WRITE;
/*!40000 ALTER TABLE `patch_sets` DISABLE KEYS */;
/*!40000 ALTER TABLE `patch_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_version` (
  `version_nbr` int(11) NOT NULL DEFAULT '0',
  `singleton` varchar(1) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`singleton`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_version`
--

LOCK TABLES `schema_version` WRITE;
/*!40000 ALTER TABLE `schema_version` DISABLE KEYS */;
INSERT INTO `schema_version` VALUES (84,'X');
/*!40000 ALTER TABLE `schema_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `starred_changes`
--

DROP TABLE IF EXISTS `starred_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `starred_changes` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `change_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`,`change_id`),
  KEY `starred_changes_byChange` (`change_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `starred_changes`
--

LOCK TABLES `starred_changes` WRITE;
/*!40000 ALTER TABLE `starred_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `starred_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submodule_subscriptions`
--

DROP TABLE IF EXISTS `submodule_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submodule_subscriptions` (
  `submodule_branch_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `submodule_project_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `submodule_path` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `super_project_branch_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `super_project_project_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`submodule_path`,`super_project_branch_name`,`super_project_project_name`),
  KEY `submodule_subscr_acc_byS` (`submodule_project_name`,`submodule_branch_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submodule_subscriptions`
--

LOCK TABLES `submodule_subscriptions` WRITE;
/*!40000 ALTER TABLE `submodule_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `submodule_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_config`
--

DROP TABLE IF EXISTS `system_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_config` (
  `admin_group_id` int(11) DEFAULT NULL,
  `admin_group_uuid` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `anonymous_group_id` int(11) DEFAULT NULL,
  `batch_users_group_id` int(11) DEFAULT NULL,
  `batch_users_group_uuid` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `owner_group_id` int(11) DEFAULT NULL,
  `register_email_private_key` varchar(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `registered_group_id` int(11) DEFAULT NULL,
  `site_path` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `wild_project_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `singleton` varchar(1) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`singleton`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_config`
--

LOCK TABLES `system_config` WRITE;
/*!40000 ALTER TABLE `system_config` DISABLE KEYS */;
INSERT INTO `system_config` VALUES (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'/gsa/ausgsa-h3/02/smcprek/gerrit/gerrit-server',NULL,'X');
/*!40000 ALTER TABLE `system_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracking_ids`
--

DROP TABLE IF EXISTS `tracking_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracking_ids` (
  `change_id` int(11) NOT NULL DEFAULT '0',
  `tracking_key` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `tracking_system` varchar(10) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`change_id`,`tracking_key`,`tracking_system`),
  KEY `tracking_ids_byTrkKey` (`tracking_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracking_ids`
--

LOCK TABLES `tracking_ids` WRITE;
/*!40000 ALTER TABLE `tracking_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `tracking_ids` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-25 17:27:01
