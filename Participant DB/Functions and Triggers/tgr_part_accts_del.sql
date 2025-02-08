-- Author: Daniel Grammer
-- Date Created: 1/28/2025
-- Date Last Edited: 1/28/2025

-- ---------------------------- --
# Script for Creating Participant Accounts Table Delete Logging Trigger
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TRIGGER IF EXISTS `trg_part_accts_del`;
DELIMITER //
CREATE TRIGGER `trg_part_accts_del`
AFTER DELETE ON `t_part_accts`
FOR EACH ROW
BEGIN
	INSERT INTO `t_part_accts_hist` (`instance_id`, `data_action`, `ref_id`, `acct_name`, `acct_type`, `acct_balance`, `start_ts`, `ins_ts`)
    VALUES (UUID(), 'D', old.ref_id, old.acct_name, old.acct_type, old.acct_balance, old.start_ts, now());
END//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;