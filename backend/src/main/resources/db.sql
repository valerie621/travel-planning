CREATE DATABASE  IF NOT EXISTS `cmpe295`;
USE `cmpe295`;
--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
INSERT INTO `role` VALUES (1,'ROLE_USER');
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_user_role_roleid_idx` (`role_id`),
  CONSTRAINT `fk_user_role_roleid` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `markers`;
CREATE TABLE `markers` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `name` VARCHAR( 60 ) NOT NULL ,
  `address` VARCHAR( 80 ) NOT NULL ,
  `lat` FLOAT( 10, 6 ) NOT NULL ,
  `lng` FLOAT( 10, 6 ) NOT NULL ,
  `type` VARCHAR( 30 ) NOT NULL
) ENGINE = MYISAM ;

INSERT INTO `markers` (`name`, `address`, `lat`, `lng`, `type`) VALUES ('Pan Africa Market', '1521 1st Ave, Seattle, WA', '47.608941', '-122.340145', 'restaurant');
INSERT INTO `markers` (`name`, `address`, `lat`, `lng`, `type`) VALUES ('Buddha Thai & Bar', '2222 2nd Ave, Seattle, WA', '47.613591', '-122.344394', 'bar');
INSERT INTO `markers` (`name`, `address`, `lat`, `lng`, `type`) VALUES ('The Melting Pot', '14 Mercer St, Seattle, WA', '47.624562', '-122.356442', 'restaurant');
INSERT INTO `markers` (`name`, `address`, `lat`, `lng`, `type`) VALUES ('Ipanema Grill', '1225 1st Ave, Seattle, WA', '47.606366', '-122.337656', 'restaurant');
INSERT INTO `markers` (`name`, `address`, `lat`, `lng`, `type`) VALUES ('Sake House', '2230 1st Ave, Seattle, WA', '47.612825', '-122.34567', 'bar');
INSERT INTO `markers` (`name`, `address`, `lat`, `lng`, `type`) VALUES ('Crab Pot', '1301 Alaskan Way, Seattle, WA', '47.605961', '-122.34036', 'restaurant');
INSERT INTO `markers` (`name`, `address`, `lat`, `lng`, `type`) VALUES ('Mama\'s Mexican Kitchen', '2234 2nd Ave, Seattle, WA', '47.613975', '-122.345467', 'bar');
INSERT INTO `markers` (`name`, `address`, `lat`, `lng`, `type`) VALUES ('Wingdome', '1416 E Olive Way, Seattle, WA', '47.617215', '-122.326584', 'bar');
INSERT INTO `markers` (`name`, `address`, `lat`, `lng`, `type`) VALUES ('Piroshky Piroshky', '1908 Pike pl, Seattle, WA', '47.610127', '-122.342838', 'restaurant');
