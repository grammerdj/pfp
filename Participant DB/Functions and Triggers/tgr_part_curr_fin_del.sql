-- Author: Daniel Grammer
-- Date Created: 1/28/2025
-- Date Last Edited: 1/28/2025

-- ---------------------------- --
# Script for Creating Participant Current Financials Table Delete Logging Trigger
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TRIGGER IF EXISTS `trg_part_curr_fin_del`;
DELIMITER //
CREATE TRIGGER `trg_part_curr_fin_del`
AFTER DELETE ON `t_part_curr_fin`
FOR EACH ROW
BEGIN
	INSERT INTO `t_part_curr_fin_hist` (`instance_id`, `data_action`, `ref_id`, `avg_monthly_exp`, `avg_monthly_inc_gross`, `short_term_sav`, `pre_tax_ret_sav`, `post_tax_ret_sav`, `hsa_sav`, `529_sav`, `total_taxable_sav`, `ee_match_pr`, `monthly_pen_ben_pr`, `monthly_ann_ben_pr`, `ret_goal_age_pr`, `ret_goal_age_sec`, `ee_match_sec`, `monthly_pen_ben_sec`, `monthly_ann_ben_sec`, `ins_ts`)
    VALUES (UUID(), 'D', old.ref_id, old.avg_monthly_exp, old.avg_monthly_inc_gross, old.short_term_sav, old.pre_tax_ret_sav, old.post_tax_ret_sav, old.hsa_sav, old.`529_sav`, old.total_taxable_sav, old.ee_match_pr, old.monthly_pen_ben_pr, old.monthly_ann_ben_pr, old.ret_goal_age_pr, old.ret_goal_age_sec, old.ee_match_sec, old.monthly_pen_ben_sec, old.monthly_ann_ben_sec, now());
END//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;