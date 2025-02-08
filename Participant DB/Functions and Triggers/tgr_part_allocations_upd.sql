-- Author: Daniel Grammer
-- Date Created: 1/28/2025
-- Date Last Edited: 1/28/2025

-- ---------------------------- --
# Script for Creating Participant Allocations Table Update Logging Trigger
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TRIGGER IF EXISTS `tgr_part_allocations_upd`;
DELIMITER //
CREATE TRIGGER `tgr_part_allocations_upd`
AFTER UPDATE ON `t_part_allocations`
FOR EACH ROW
BEGIN
	INSERT INTO `t_part_allocations_hist` (`instance_id`, `data_action`, `ref_id`, `fund_id`, `amnt`, `strt_dt`, `strt_price`, `snapshot_ts`, `ins_ts`)
    VALUES (UUID(), 'U', new.ref_id, new.fund_id, new.amnt, new.strt_dt, new.strt_price, new.snapshot_ts, now());
END//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;