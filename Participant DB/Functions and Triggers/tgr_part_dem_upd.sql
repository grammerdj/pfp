-- Author: Daniel Grammer
-- Date Created: 1/28/2025
-- Date Last Edited: 1/28/2025

-- ---------------------------- --
# Script for Creating Demographics Table Update Logging Trigger
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TRIGGER IF EXISTS `trg_part_dem_upd`;
DELIMITER //
CREATE TRIGGER `trg_part_dem_upd`
AFTER UPDATE ON `t_part_dem`
FOR EACH ROW
BEGIN
	INSERT INTO `t_part_dem_hist` (`instance_id`, `data_action`, `ref_id`, `first_nm`, `last_nm`, `dob`, `email_pr`, `email_sec`, `cntry`, `state`, `loc_cd`, `martial_st`, `spouse_dob`, `citizen_st`, `ins_ts`)
    VALUES (UUID(), 'U', new.ref_id, new.first_nm, new.last_nm, new.dob, new.email_pr, new.email_sec, new.cntry, new.state, new.loc_cd, new.marital_st, new.spouse_dob, new.citizen_st, now());
END//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;