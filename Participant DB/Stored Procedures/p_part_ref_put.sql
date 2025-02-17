-- Author: Daniel Grammer
-- Date Created: 2/17/2025
-- Date Last Edited: 2/17/2025

-- ---------------------------- --
# Script for Creating User Reference ID Put Proc
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP PROCEDURE IF EXISTS `p_part_ref_put`;
DELIMITER //
CREATE
    PROCEDURE `p_part_ref_put` (IN `p_first_nm` VARCHAR(100),
								IN `p_last_nm` VARCHAR(100),
                                IN `p_pin` INT,
                                IN `p_user` VARCHAR(100),
                                OUT `p_ref_id` VARCHAR(36))
	COMMENT "Participant reference ID generation put proc"
put_ref: BEGIN
	/* Standard Proc Logging Variables */
	DECLARE beg_ts DATETIME DEFAULT NOW();
	DECLARE proc_name VARCHAR(100) DEFAULT "p_part_ref_put";
	DECLARE params TEXT DEFAULT CONCAT("[",COALESCE(p_first_nm, "NULL"),",",COALESCE(p_last_nm, "NULL"),",","REDACTED",",",COALESCE(p_user, "NULL"),"]");
	DECLARE msg TEXT DEFAULT "";
	DECLARE rows_modified INT DEFAULT 0;
    
    /* Custom Variables */
    DECLARE v_ref_id VARCHAR(36);
	 
	/* Error 1 - Null Params */
	IF p_first_nm IS NULL OR p_first_nm = ""
    OR p_last_nm IS NULL OR p_last_nm = ""
    OR p_pin IS NULL 
	OR p_user IS NULL OR p_user = ""
	THEN 
		SET msg = "Error 1 - One or more required parameters were null";
        CALL p_proc_logging(proc_name, params, msg, rows_modified, "E", p_user, beg_ts, now());
        LEAVE put_ref;
	END IF;
    
    /* Error 2 - Participant Already Exists */
    IF (SELECT COUNT(*) FROM t_part_ref WHERE first_nm = p_first_nm AND last_nm = p_last_nm AND pin = p_pin) > 0
    THEN
		SET msg = "Error 2 - Participant with Credentials Already Exists";
        CALL p_proc_logging(proc_name, params, msg, rows_modified, "E", p_user, beg_ts, now());
        LEAVE put_ref;
	END IF;

	/* INSERT LOGIC */
    SET v_ref_id = UUID();
	SET p_ref_id = v_ref_id;
    INSERT INTO t_part_ref 
    VALUES (v_ref_id, p_first_nm, p_last_nm, p_pin, now());
    SET rows_modified = ROW_COUNT();

    /* Standard Proc Logging */
    CALL p_proc_logging(proc_name, params,  msg, rows_modified, "S", p_user, beg_ts, now());
     

END //
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
