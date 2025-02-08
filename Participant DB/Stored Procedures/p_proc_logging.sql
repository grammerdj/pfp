-- Author: Daniel Grammer
-- Date Created: 2/4/2025
-- Date Last Edited: 2/4/2025

-- ---------------------------- --
# Script for Creating Stored Procedure Logging Proc
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP PROCEDURE IF EXISTS `p_proc_logging`;
DELIMITER //
CREATE
    PROCEDURE `p_proc_logging` (IN `p_proc_name` varchar(36),
								IN `p_params` text,
                                IN `p_msg` text,
								IN `p_rows_modified` int,
                                IN `p_stat_c` varchar(1),
                                IN `p_usr` varchar(100),
                                IN `p_beg_ts` datetime,
                                IN `p_end_ts` datetime)
	COMMENT "Internal stored procedure logging procedure"
BEGIN
	INSERT INTO `t_proc_log`(run_id, proc_name, params, msg, rows_modified, stat_c, usr, beg_ts, end_ts) 
    VALUES (p_proc_name, p_params, p_msg, p_rows_modified, p_stat_c, p_usr, p_beg_ts, p_end_ts);
END //
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;