-- Author: Daniel Grammer
-- Date Created: 2/4/2025
-- Date Last Edited: 2/10/2025

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
                                OUT `p_email` VARCHAR(100),
                                OUT `p_ref_id` VARCHAR(36))
	COMMENT "Participant authentication procedure"
auth: BEGIN
	/* Standard Proc Logging Variables */
	DECLARE beg_ts DATETIME DEFAULT NOW();
	DECLARE proc_name VARCHAR(100) DEFAULT "p_part_auth";
	DECLARE params TEXT DEFAULT CONCAT("[",COALESCE(p_username, "NULL"),",","REDACTED",",",COALESCE(p_user, "NULL"),"]");
	DECLARE msg TEXT DEFAULT "";
	DECLARE rows_modified INT DEFAULT 0;
	 
	/* Custom Variables */
	DECLARE auth_c VARCHAR(1);
	 
	/* Error 1 - Null Params */
	IF p_username IS NULL OR p_username = "" 
	OR p_password IS NULL OR p_password = ""
	OR p_user IS NULL OR p_user = ""
	THEN 
		SET msg = "Error 1 - One or more parameters were null";
        SET p_stat_c = NULL;
        SET p_email = NULL;
        CALL p_proc_logging(proc_name, params, msg, rows_modified, "E", p_user, beg_ts, now());
        LEAVE auth;
	END IF;

	/* Participant Credential Verification */
    SELECT email_otp, ref_id FROM t_part_auth WHERE username = p_username AND `password` = p_password INTO @email, @ref_id;
    SET p_email = @email;
    SET p_ref_id = @ref_id;
    IF @email IS NULL
    THEN
		SET p_stat_c = "F";
	ELSE
		SET p_stat_c = "S";
	END IF;
	
    /* Standard Proc Logging */
    CALL p_proc_logging (proc_name, params,  msg, rows_modified, "S", p_user, beg_ts, now());
     

END //
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



