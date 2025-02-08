-- Author: Daniel Grammer
-- Date Created: 2/4/2025
-- Date Last Edited: 2/4/2025

-- ---------------------------- --
# Script for Creating User Credential Authentication Proc
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP PROCEDURE IF EXISTS `p_part_auth`;
DELIMITER //
CREATE
    PROCEDURE `p_part_auth` (IN `p_username` VARCHAR(20), 
								IN `p_password` VARCHAR(100),
                                IN `p_user` VARCHAR(100),
                                OUT `p_stat_c` VARCHAR(1),
                                OUT `p_email` VARCHAR(100))
	COMMENT "Participant authentication procedure"
BEGIN
	 /* Standard Proc Logging Variables */
     DECLARE beg_ts DATETIME DEFAULT NOW();
     DECLARE end_ts DATETIME;
     DECLARE proc_name VARCHAR(20) DEFAULT "p_part_auth";
     DECLARE params TEXT DEFAULT CONCAT("[", COALESCE(p_username, "NULL"),",",
     "REDACTED",
     COALESCE(p_user, "NULL"), 
     COALESCE(p_stat_c, "NULL"),
     
     ;
     DECLARE msg TEXT;
     DECLARE rows_modified INT DEFAULT 0;
     DECLARE stat_c VARCHAR(1);
     
     /* Custom Variables */
     
     /*Standard Pro*/

END //
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



