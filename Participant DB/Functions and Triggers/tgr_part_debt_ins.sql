-- Author: Daniel Grammer
-- Date Created: 2/1/2025
-- Date Last Edited: 2/1/2025

-- ---------------------------- --
# Script for Creating Debt Obligation Table Insert Logging Trigger
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TRIGGER IF EXISTS `tgr_part_debt_ins`;
DELIMITER //
CREATE TRIGGER `tgr_part_debt_ins`
AFTER INSERT ON `t_part_debt`
FOR EACH ROW
BEGIN
	INSERT INTO `t_part_debt_hist` (`instance_id`, `data_action`, `ref_id`, `debt_name`, `prds_remain`, `pmnt_amt`, `prepayment`, `max_pmnt_amt`, `periodicity`, `exp_prds_remain`, `asset_val`, `asset_type`, `ins_ts`)
    VALUES (UUID(), 'I', new.ref_id, new.debt_name, new.prds_remain, new.pmnt_amt, new.prepayment, new.max_pmnt_amt, new.periodicity, new.exp_prds_remain, new.asset_val, new.asset_type, now());
END//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
