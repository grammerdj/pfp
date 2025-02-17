-- Author: Daniel Grammer
-- Date Created: 2/17/2025
-- Date Last Edited: 2/17/2025

-- ---------------------------- --
# Script for Creating User Credential Get Proc
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP PROCEDURE IF EXISTS `p_part_auth_get`;
DELIMITER //
CREATE
    PROCEDURE `p_part_auth_get` (IN `p_ref_id` VARCHAR(36),
                                IN `p_password` VARCHAR(100),
                                IN `p_user` VARCHAR(100))
	COMMENT "Participant auth credentials get proc"
get_auth: BEGIN
	/* Standard Proc Logging Variables */
	DECLARE beg_ts DATETIME DEFAULT NOW();
	DECLARE proc_name VARCHAR(100) DEFAULT "p_part_auth_get";
	DECLARE params TEXT DEFAULT CONCAT("[",COALESCE(p_ref_id, "NULL"),"REDACTED",",",COALESCE(p_user, "NULL"),"]");
	DECLARE msg TEXT DEFAULT "";
	DECLARE rows_modified INT DEFAULT 0;
	 
	/* Error 1 - Null Params */
    IF p_ref_id IS NULL OR p_ref_id = ""
	OR p_password IS NULL OR p_password = ""
	OR p_user IS NULL OR p_user = ""
	THEN 
		SET msg = "Error 1 - One or more required parameters were null";
        CALL p_proc_logging(proc_name, params, msg, rows_modified, "E", p_user, beg_ts, now());
        LEAVE get_auth;
	END IF;
    
    /* Error 2 - Incorrect Password */
    SELECT `password` FROM t_part_auth WHERE ref_id = p_ref_id INTO @pwd;
    IF @pwd IS NULL
	THEN 
		SET msg = "Error 2 - Password Incorrect";
		CALL p_proc_logging(proc_name, params, msg, rows_modified, "E", p_user, beg_ts, now());
		LEAVE get_auth;
	END IF;
    
	/* RETURNING AUTH FIELDS */
    SELECT * FROM t_part_auth WHERE ref_id = p_ref_id;
		
    /* Standard Proc Logging */
    CALL p_proc_logging(proc_name, params,  msg, rows_modified, "S", p_user, beg_ts, now());
     

END //
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
