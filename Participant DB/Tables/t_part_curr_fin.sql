-- Author: Daniel Grammer
-- Date Created: 1/24/2025
-- Date Last Edited: 1/24/2025

-- ---------------------------- --
# Script for Creating Participant Financial Snapshot Table
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `t_part_curr_fin` (
  `ref_id` VARCHAR(36) NOT NULL COMMENT "Unique Pariticipant Identifier",
  `avg_monthly_exp` DOUBLE NOT NULL COMMENT "Average monthly expenses",
  `avg_monthly_inc_gross` DOUBLE NOT NULL COMMENT "Average Monthly Gross Income",
  `short_term_sav` DOUBLE NOT NULL COMMENT "Emergency Fund Savings",
  `pre_tax_ret_sav` DOUBLE NOT NULL COMMENT "Traditional Retirement Account Savings",
  `post_tax_ret_sav` DOUBLE NOT NULL COMMENT "Roth Retirement Account Savings",
  `hsa_sav` DOUBLE NOT NULL COMMENT "HSA Savings",
  `529_sav` JSON NOT NULL COMMENT "529 Savings, JSON Format for Kid:Value pairs",
  `total_taxable_sav` DOUBLE NOT NULL COMMENT "Medium and Long-Term Taxable Savings",
  `ee_match_pr` DOUBLE NOT NULL COMMENT "Employer Match Percentage Primary Participant",
  `monthly_pen_ben_pr` DOUBLE NOT NULL COMMENT "Monthly Expected Pension Benefit Primary Participant",
  `monthly_ann_ben_pr` DOUBLE NOT NULL COMMENT "Monthly Expected Annuity Benefit Primary Participant",
  `ret_goal_age_pr` INT NOT NULL COMMENT "Retirement Age Goal Primary Participant",
  `ret_goal_age_sec` INT NULL COMMENT "Retirement Age Goal Secondary Participant",
  `ee_match_sec` DOUBLE NULL COMMENT "Employer Match Percentage Secondary Participant",
  `monthly_pen_ben_sec` DOUBLE NULL COMMENT "Monthly Expected Pension Benefit Secondary Participant",
  `monthly_ann_ben_sec` DOUBLE NULL COMMENT "Monthly Expecte Annuity Benefit Secondary Participant",
  PRIMARY KEY (`ref_id`),
  FOREIGN KEY (`ref_id`) REFERENCES t_part_ref(`ref_id`),
  UNIQUE INDEX `ref_id_UNIQUE` (`ref_id` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;