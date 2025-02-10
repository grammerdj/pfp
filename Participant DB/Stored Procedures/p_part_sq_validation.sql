-- Author: Daniel Grammer
-- Date Created: 2/9/2025
-- Date Last Edited: 2/9/2025

-- ---------------------------- --
# Script for Creating User Credential Security Question Validation Proc
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP PROCEDURE IF EXISTS `p_part_sq_validation`;
DELIMITER //
CREATE
    PROCEDURE `p_part_sq_validation` (IN `p_email_otp` VARCHAR(100),
								IN `p_sq_1_ans` VARCHAR(100), 
								IN `p_sq_2_ans` VARCHAR(100),
                                IN `p_user` VARCHAR(100),
                                OUT `p_stat_c` VARCHAR(1))
	COMMENT "Participant security question answer validation"
sq: BEGIN
	/* Standard Proc Logging Variables */
	DECLARE beg_ts DATETIME DEFAULT NOW();
	DECLARE proc_name VARCHAR(20) DEFAULT "p_part_sq_validation";
	DECLARE params TEXT DEFAULT CONCAT("[",COALESCE(p_email_otp, "NULL"),",",COALESCE(p_sq_1_ans, "NULL"),",",COALESCE(p_sq_2_ans, "NULL"),",",COALESCE(p_user, "NULL"),"]");
	DECLARE msg TEXT DEFAULT "";
	DECLARE rows_modified INT DEFAULT 0;
	 
	/* Custom Variables */
	DECLARE auth_c VARCHAR(1);
	 
	/* Error 1 - Null Params */
	IF p_sq_1_ans IS NULL OR p_sq_1_ans = "" 
	OR p_sq_2_ans IS NULL OR p_sq_2_ans = ""
	OR p_user IS NULL OR p_user = ""
	THEN 
		SET msg = "Error 1 - One or more parameters were null";
        SET p_stat_c = NULL;
        CALL p_proc_logging(proc_name, params, msg, rows_modified, "E", p_user, beg_ts, now());
        LEAVE sq;
	END IF;

	/* Participant Credential Verification */
    SELECT @sq_1_ans:=sq_1_ans, @sq_2_ans:=sq_2_ans FROM t_part_auth WHERE email_otp = p_email_otp;
    IF @sq_1_ans <> p_sq_1_ans OR @sq_2_ans <> p_sq_2_ans
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


