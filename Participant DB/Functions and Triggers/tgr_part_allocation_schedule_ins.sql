-- Author: Daniel Grammer
-- Date Created: 1/28/2025
-- Date Last Edited: 1/28/2025

-- ---------------------------- --
# Script for Creating Generated Allocation Schedule Table Insert Logging Trigger
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TRIGGER IF EXISTS `tgr_part_allocation_schedule_ins`;
DELIMITER //
CREATE TRIGGER `tgr_part_allocation_schedule_ins`
AFTER INSERT ON `t_part_allocation_schedule`
FOR EACH ROW
BEGIN
	INSERT INTO `t_part_allocation_schedule_hist` (`instance_id`, `data_action`, `ref_id`, `risk_type`, `gen_allocation_schedule`, `selected`, `gen_ts`, `ins_ts`)
    VALUES (UUID(), 'I', new.ref_id, new.risk_type, new.gen_allocation_schedule, new.selected, new.gen_ts, now());
END//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;