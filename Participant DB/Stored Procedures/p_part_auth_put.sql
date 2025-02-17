-- Author: Daniel Grammer
-- Date Created: 2/10/2025
-- Date Last Edited: 2/17/2025

-- ---------------------------- --
# Script for Creating User Credential Put Proc
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP PROCEDURE IF EXISTS `p_part_auth_put`;
DELIMITER //
CREATE
    PROCEDURE `p_part_auth_put` (IN `p_ref_id` VARCHAR(36),
								IN `p_username` VARCHAR(20),
                                IN `p_password` VARCHAR(100),
								IN `p_email_otp` VARCHAR(100),
								IN `p_sq_1` VARCHAR(1000),
                                IN `p_sq_1_ans` VARCHAR(100),
                                IN `p_sq_2` VARCHAR(1000),
                                IN `p_sq_2_ans` VARCHAR(100),
                                IN `p_user` VARCHAR(100))
	COMMENT "Participant auth credentials put proc"
put_auth: BEGIN
	/* Standard Proc Logging Variables */
	DECLARE beg_ts DATETIME DEFAULT NOW();
	DECLARE proc_name VARCHAR(100) DEFAULT "p_part_auth_put";
	DECLARE params TEXT DEFAULT CONCAT("[",COALESCE(p_ref_id, "NULL"),",",COALESCE(p_username, "NULL"),",","REDACTED",",",COALESCE(p_email_otp, "NULL"),COALESCE(p_sq_1, "NULL"),",",COALESCE(p_sq_1_ans, "NULL"),",",COALESCE(p_sq_2, "NULL"),",",COALESCE(p_sq_2_ans, "NULL"),",",COALESCE(p_user, "NULL"),"]");
	DECLARE msg TEXT DEFAULT "";
	DECLARE rows_modified INT DEFAULT 0;
	 
	/* Error 1 - Null Params */
    IF p_username IS NULL OR p_username = ""
	OR p_password IS NULL OR p_password = ""
    OR p_email_otp IS NULL OR p_email_otp = ""
	OR p_user IS NULL OR p_user = ""
	THEN 
		SET msg = "Error 1 - One or more required parameters were null";
        CALL p_proc_logging(proc_name, params, msg, rows_modified, "E", p_user, beg_ts, now());
        LEAVE put_auth;
	END IF;
    
	/* INSERT OR UPDATE LOGIC */
    IF p_ref_id IS NULL OR p_ref_id = ""
    THEN
		SELECT `password` FROM t_part_auth WHERE email_otp = p_email_otp INTO @pwd;
        
		/* Error 2 - Password Reset Email_OTP DNE */
        IF @pwd IS NULL
        THEN 
			SET msg = "Error 2 - Password reset email address DNE";
			CALL p_proc_logging(proc_name, params, msg, rows_modified, "E", p_user, beg_ts, now());
			LEAVE put_auth;
		END IF;
        
		UPDATE t_part_auth
        SET username = p_username, `password` = p_password, previous_pwds = JSON_INSERT(previous_pwds, CONCAT("$.", DATE_FORMAT(NOW(), '%m/%d/%Y')), @pwd), ins_ts = now()
        WHERE email_otp = p_email_otp;
        SET rows_modified = ROW_COUNT();
	ELSE
		SELECT email_otp FROM t_part_auth WHERE ref_id = p_ref_id AND `password` = p_password INTO @email_otp;
        IF @email_otp IS NULL
        THEN 
			INSERT INTO t_part_auth 
            VALUES (p_ref_id, p_username, p_password, '{}', p_email_otp, p_sq_1, p_sq_1_ans, p_sq_2, p_sq_2_ans, now());
			SET rows_modified = ROW_COUNT();
		ELSE
			UPDATE t_part_auth 
            SET username = p_username, email_otp = p_email_otp, sq_1 = p_sq_1, sq_1_ans = p_sq_1_ans, sq_2 = p_sq_2, sq_2_ans = p_sq_2_ans, ins_ts = now()
            WHERE ref_id = p_ref_id;
			SET rows_modified = ROW_COUNT();
		END IF;
	END IF;
		
    /* Standard Proc Logging */
    CALL p_proc_logging(proc_name, params,  msg, rows_modified, "S", p_user, beg_ts, now());
     

END //
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
