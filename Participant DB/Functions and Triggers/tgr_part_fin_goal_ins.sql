-- Author: Daniel Grammer
-- Date Created: 1/28/2025
-- Date Last Edited: 1/28/2025

-- ---------------------------- --
# Script for Creating Financial Goal Table Insert Logging Trigger
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TRIGGER IF EXISTS `tgr_part_fin_goal_ins`;
DELIMITER //
CREATE TRIGGER `tgr_part_fin_goal_ins`
AFTER INSERT ON `t_part_fin_goal`
FOR EACH ROW
BEGIN
	INSERT INTO `t_part_fin_goal_hist` (`instance_id`, `data_action`, `ref_id`, `goal_id`, `goal_nm`, `goal_strt_dt`, `goal_avg_cash_flow`, `goal_avg_periodicity`, `goal_est_dur`, `ins_ts`)
    VALUES (UUID(), 'I', new.ref_id, new.goal_id, new.goal_nm, new.goal_strt_dt, new.goal_avg_cash_flow, new.goal_avg_periodicity, new.goal_est_dur, now());
END//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;