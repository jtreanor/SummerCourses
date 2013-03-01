-- MySQL dump 10.13  Distrib 5.5.29, for osx10.8 (i386)
--
-- Host: localhost    Database: SummerCourses_development
-- ------------------------------------------------------
-- Server version	5.5.29

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
-- Table structure for table `administrators`
--

DROP TABLE IF EXISTS `administrators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forename` varchar(35) NOT NULL,
  `surname` varchar(35) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(60) DEFAULT NULL,
  `isSuper` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `adminID_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrators`
--

LOCK TABLES `administrators` WRITE;
/*!40000 ALTER TABLE `administrators` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `countryCode` char(2) NOT NULL,
  `country_name` varchar(45) NOT NULL,
  PRIMARY KEY (`countryCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES ('AD','ANDORRA'),('AE','UNITED ARAB EMIRATES'),('AF','AFGHANISTAN'),('AG','ANTIGUA AND BARBUDA'),('AI','ANGUILLA'),('AL','ALBANIA'),('AM','ARMENIA'),('AO','ANGOLA'),('AQ','ANTARCTICA'),('AR','ARGENTINA'),('AS','AMERICAN SAMOA'),('AT','AUSTRIA'),('AU','AUSTRALIA'),('AW','ARUBA'),('AX','ÅLAND ISLANDS'),('AZ','AZERBAIJAN'),('BA','BOSNIA AND HERZEGOVINA'),('BB','BARBADOS'),('BD','BANGLADESH'),('BE','BELGIUM'),('BF','BURKINA FASO'),('BG','BULGARIA'),('BH','BAHRAIN'),('BI','BURUNDI'),('BJ','BENIN'),('BL','SAINT BARTHÉLEMY'),('BM','BERMUDA'),('BN','BRUNEI DARUSSALAM'),('BO','BOLIVIA, PLURINATIONAL STATE OF'),('BQ','BONAIRE, SINT EUSTATIUS AND SABA'),('BR','BRAZIL'),('BS','BAHAMAS'),('BT','BHUTAN'),('BV','BOUVET ISLAND'),('BW','BOTSWANA'),('BY','BELARUS'),('BZ','BELIZE'),('CA','CANADA'),('CC','COCOS (KEELING) ISLANDS'),('CD','CONGO, THE DEMOCRATIC REPUBLIC OF THE'),('CF','CENTRAL AFRICAN REPUBLIC'),('CG','CONGO'),('CH','SWITZERLAND'),('CI','CÔTE D\'IVOIRE'),('CK','COOK ISLANDS'),('CL','CHILE'),('CM','CAMEROON'),('CN','CHINA'),('CO','COLOMBIA'),('CR','COSTA RICA'),('CU','CUBA'),('CV','CAPE VERDE'),('CW','CURAÇAO'),('CX','CHRISTMAS ISLAND'),('CY','CYPRUS'),('CZ','CZECH REPUBLIC'),('DE','GERMANY'),('DJ','DJIBOUTI'),('DK','DENMARK'),('DM','DOMINICA'),('DO','DOMINICAN REPUBLIC'),('DZ','ALGERIA'),('EC','ECUADOR'),('EE','ESTONIA'),('EG','EGYPT'),('EH','WESTERN SAHARA'),('ER','ERITREA'),('ES','SPAIN'),('ET','ETHIOPIA'),('FI','FINLAND'),('FJ','FIJI'),('FK','FALKLAND ISLANDS (MALVINAS)'),('FM','MICRONESIA, FEDERATED STATES OF'),('FO','FAROE ISLANDS'),('FR','FRANCE'),('GA','GABON'),('GB','UNITED KINGDOM'),('GD','GRENADA'),('GE','GEORGIA'),('GF','FRENCH GUIANA'),('GG','GUERNSEY'),('GH','GHANA'),('GI','GIBRALTAR'),('GL','GREENLAND'),('GM','GAMBIA'),('GN','GUINEA'),('GP','GUADELOUPE'),('GQ','EQUATORIAL GUINEA'),('GR','GREECE'),('GS','SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS'),('GT','GUATEMALA'),('GU','GUAM'),('GW','GUINEA-BISSAU'),('GY','GUYANA'),('HK','HONG KONG'),('HM','HEARD ISLAND AND MCDONALD ISLANDS'),('HN','HONDURAS'),('HR','CROATIA'),('HT','HAITI'),('HU','HUNGARY'),('ID','INDONESIA'),('IE','IRELAND'),('IL','ISRAEL'),('IM','ISLE OF MAN'),('IN','INDIA'),('IO','BRITISH INDIAN OCEAN TERRITORY'),('IQ','IRAQ'),('IR','IRAN, ISLAMIC REPUBLIC OF'),('IS','ICELAND'),('IT','ITALY'),('JE','JERSEY'),('JM','JAMAICA'),('JO','JORDAN'),('JP','JAPAN'),('KE','KENYA'),('KG','KYRGYZSTAN'),('KH','CAMBODIA'),('KI','KIRIBATI'),('KM','COMOROS'),('KN','SAINT KITTS AND NEVIS'),('KP','KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF'),('KR','KOREA, REPUBLIC OF'),('KW','KUWAIT'),('KY','CAYMAN ISLANDS'),('KZ','KAZAKHSTAN'),('LA','LAO PEOPLE\'S DEMOCRATIC REPUBLIC'),('LB','LEBANON'),('LC','SAINT LUCIA'),('LI','LIECHTENSTEIN'),('LK','SRI LANKA'),('LR','LIBERIA'),('LS','LESOTHO'),('LT','LITHUANIA'),('LU','LUXEMBOURG'),('LV','LATVIA'),('LY','LIBYA'),('MA','MOROCCO'),('MC','MONACO'),('MD','MOLDOVA, REPUBLIC OF'),('ME','MONTENEGRO'),('MF','SAINT MARTIN (FRENCH PART)'),('MG','MADAGASCAR'),('MH','MARSHALL ISLANDS'),('MK','MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF'),('ML','MALI'),('MM','MYANMAR'),('MN','MONGOLIA'),('MO','MACAO'),('MP','NORTHERN MARIANA ISLANDS'),('MQ','MARTINIQUE'),('MR','MAURITANIA'),('MS','MONTSERRAT'),('MT','MALTA'),('MU','MAURITIUS'),('MV','MALDIVES'),('MW','MALAWI'),('MX','MEXICO'),('MY','MALAYSIA'),('MZ','MOZAMBIQUE'),('NA','NAMIBIA'),('NC','NEW CALEDONIA'),('NE','NIGER'),('NF','NORFOLK ISLAND'),('NG','NIGERIA'),('NI','NICARAGUA'),('NL','NETHERLANDS'),('NO','NORWAY'),('NP','NEPAL'),('NR','NAURU'),('NU','NIUE'),('NZ','NEW ZEALAND'),('OM','OMAN'),('PA','PANAMA'),('PE','PERU'),('PF','FRENCH POLYNESIA'),('PG','PAPUA NEW GUINEA'),('PH','PHILIPPINES'),('PK','PAKISTAN'),('PL','POLAND'),('PM','SAINT PIERRE AND MIQUELON'),('PN','PITCAIRN'),('PR','PUERTO RICO'),('PS','PALESTINE, STATE OF'),('PT','PORTUGAL'),('PW','PALAU'),('PY','PARAGUAY'),('QA','QATAR'),('RE','RÉUNION'),('RO','ROMANIA'),('RS','SERBIA'),('RU','RUSSIAN FEDERATION'),('RW','RWANDA'),('SA','SAUDI ARABIA'),('SB','SOLOMON ISLANDS'),('SC','SEYCHELLES'),('SD','SUDAN'),('SE','SWEDEN'),('SG','SINGAPORE'),('SH','SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA'),('SI','SLOVENIA'),('SJ','SVALBARD AND JAN MAYEN'),('SK','SLOVAKIA'),('SL','SIERRA LEONE'),('SM','SAN MARINO'),('SN','SENEGAL'),('SO','SOMALIA'),('SR','SURINAME'),('SS','SOUTH SUDAN'),('ST','SAO TOME AND PRINCIPE'),('SV','EL SALVADOR'),('SX','SINT MAARTEN (DUTCH PART)'),('SY','SYRIAN ARAB REPUBLIC'),('SZ','SWAZILAND'),('TC','TURKS AND CAICOS ISLANDS'),('TD','CHAD'),('TF','FRENCH SOUTHERN TERRITORIES'),('TG','TOGO'),('TH','THAILAND'),('TJ','TAJIKISTAN'),('TK','TOKELAU'),('TL','TIMOR-LESTE'),('TM','TURKMENISTAN'),('TN','TUNISIA'),('TO','TONGA'),('TR','TURKEY'),('TT','TRINIDAD AND TOBAGO'),('TV','TUVALU'),('TW','TAIWAN, PROVINCE OF CHINA'),('TZ','TANZANIA, UNITED REPUBLIC OF'),('UA','UKRAINE'),('UG','UGANDA'),('UM','UNITED STATES MINOR OUTLYING ISLANDS'),('US','UNITED STATES'),('UY','URUGUAY'),('UZ','UZBEKISTAN'),('VA','HOLY SEE (VATICAN CITY STATE)'),('VC','SAINT VINCENT AND THE GRENADINES'),('VE','VENEZUELA, BOLIVARIAN REPUBLIC OF'),('VG','VIRGIN ISLANDS, BRITISH'),('VI','VIRGIN ISLANDS, U.S.'),('VN','VIET NAM'),('VU','VANUATU'),('WF','WALLIS AND FUTUNA'),('WS','SAMOA'),('YE','YEMEN'),('YT','MAYOTTE'),('ZA','SOUTH AFRICA'),('ZM','ZAMBIA'),('ZW','ZIMBABWE');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_media`
--

DROP TABLE IF EXISTS `course_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_media` (
  `course_id` int(11) NOT NULL,
  `mediaID` int(11) NOT NULL,
  PRIMARY KEY (`course_id`,`mediaID`),
  KEY `mediaID_idx` (`mediaID`),
  KEY `course_id_idx` (`course_id`),
  CONSTRAINT `courseMedia.mediaID` FOREIGN KEY (`mediaID`) REFERENCES `media` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `courseMedia.course_id` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_media`
--

LOCK TABLES `course_media` WRITE;
/*!40000 ALTER TABLE `course_media` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `briefDescription` tinytext NOT NULL,
  `teacherID` int(11) NOT NULL,
  `numberOfPlaces` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `deposit` decimal(10,2) NOT NULL,
  `categoryID` int(11) NOT NULL,
  `hits` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categoryID_idx` (`categoryID`),
  KEY `teacherID_idx` (`teacherID`),
  CONSTRAINT `course.categoryID` FOREIGN KEY (`categoryID`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `course.teacherID` FOREIGN KEY (`teacherID`) REFERENCES `teachers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `is_Cancelled` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `student_id_idx` (`student_id`),
  KEY `course_id_idx` (`course_id`),
  CONSTRAINT `enrol.student_id` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `enrol.course_id` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(45) NOT NULL,
  `extension` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `threadID` varchar(80) NOT NULL,
  `timestamp` datetime NOT NULL,
  `subject` tinytext NOT NULL,
  `isResponse` bit(1) NOT NULL DEFAULT b'0',
  `messageText` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `threadID_idx` (`threadID`),
  CONSTRAINT `message.threadID` FOREIGN KEY (`threadID`) REFERENCES `threads` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` varchar(45) NOT NULL,
  `enrollment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enrollment_id_idx` (`enrollment_id`),
  CONSTRAINT `pay.transactionID` FOREIGN KEY (`id`) REFERENCES `transactions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pay.enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refunds`
--

DROP TABLE IF EXISTS `refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refunds` (
  `refundTransactionID` varchar(45) NOT NULL,
  `originalTransactionID` varchar(45) NOT NULL,
  PRIMARY KEY (`refundTransactionID`,`originalTransactionID`),
  KEY `transactionID_idx` (`refundTransactionID`),
  KEY `transactionID_idx1` (`originalTransactionID`),
  CONSTRAINT `refund.rfTransactionID` FOREIGN KEY (`refundTransactionID`) REFERENCES `transactions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `refund.orignalTransactionID` FOREIGN KEY (`originalTransactionID`) REFERENCES `transactions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refunds`
--

LOCK TABLES `refunds` WRITE;
/*!40000 ALTER TABLE `refunds` DISABLE KEYS */;
/*!40000 ALTER TABLE `refunds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20130224141929');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sexes`
--

DROP TABLE IF EXISTS `sexes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sexes` (
  `id` tinyint(4) NOT NULL,
  `sexName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sexes`
--

LOCK TABLES `sexes` WRITE;
/*!40000 ALTER TABLE `sexes` DISABLE KEYS */;
INSERT INTO `sexes` VALUES (0,'not known'),(1,'male'),(2,'female'),(9,'not applicable');
/*!40000 ALTER TABLE `sexes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forename` varchar(35) NOT NULL,
  `surname` varchar(35) NOT NULL,
  `countryCode` char(2) NOT NULL,
  `sexID` tinyint(4) NOT NULL,
  `yearOfBirth` year(4) NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_students_on_email` (`email`),
  UNIQUE KEY `index_students_on_reset_password_token` (`reset_password_token`),
  KEY `sexID_idx` (`sexID`),
  KEY `countryCode_idx` (`countryCode`),
  CONSTRAINT `student.countryCode` FOREIGN KEY (`countryCode`) REFERENCES `countries` (`countryCode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `student.sexID` FOREIGN KEY (`sexID`) REFERENCES `sexes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (2,'James','Treanor','IE',1,1991,'jtreanor3@gmail.com','$2a$10$UNNdBUJOuVzGKP/yGHG2QuEVPlw1LUDvsw2zi66tBtOw2tT6xaGMa',NULL,NULL,NULL,4,'2013-02-24 16:50:55','2013-02-24 14:55:45','127.0.0.1','127.0.0.1');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photoUrl` varchar(255) DEFAULT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `description` text NOT NULL,
  `forename` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teacherID_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `threads`
--

DROP TABLE IF EXISTS `threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `threads` (
  `id` varchar(80) NOT NULL,
  `userEmail` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `threads`
--

LOCK TABLES `threads` WRITE;
/*!40000 ALTER TABLE `threads` DISABLE KEYS */;
/*!40000 ALTER TABLE `threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_table_items`
--

DROP TABLE IF EXISTS `time_table_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_table_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `locationID` int(11) NOT NULL,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `room` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `locationID_idx` (`locationID`),
  KEY `course_id_idx` (`course_id`),
  CONSTRAINT `timetable.course_id` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `timetable.locationID` FOREIGN KEY (`locationID`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_table_items`
--

LOCK TABLES `time_table_items` WRITE;
/*!40000 ALTER TABLE `time_table_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_table_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` varchar(45) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionID_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-02-24 17:26:05
