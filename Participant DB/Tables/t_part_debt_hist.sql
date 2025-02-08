-- Author: Daniel Grammer
-- Date Created: 2/1/2025
-- Date Last Edited: 2/1/2025

-- ---------------------------- --
# Script for Creating Participant Debt Obligations Logging Table
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `t_part_debt_hist` (
  `instance_id` VARCHAR(36) NOT NULL COMMENT "Unique historical data instance identifier",
  `data_action` VARCHAR(1) NOT NULL COMMENT "I, U, D",
  `ref_id` VARCHAR(36) NOT NULL COMMENT "Unique Pariticipant Identifier",
  `debt_name` VARCHAR(36) NOT NULL COMMENT "Unique Debt Identifier",
  `prds_remain` INT NULL COMMENT "Number of Payment Periods Remaining in the Life of the Loan",
  `pmnt_amt` DOUBLE NULL COMMENT "Price of Each Payment",
  `prepayment` TINYINT NOT NULL COMMENT "Prepayment Allowed Indicator (T/F)",
  `max_pmnt_amt` DOUBLE NULL COMMENT "Max Price of Each Payment If Restrictions on Prepayment",
  `periodicity` INT NOT NULL COMMENT "Number of Payments Per Year",
  `exp_prds_remain` INT NULL COMMENT "Expected Payment Periods Remaining in the Life of Loan if Expected Sale of Underlying Asset",
  `asset_val` DOUBLE NULL COMMENT "Underlying Asset Value",
  `asset_type` DOUBLE NULL COMMENT "Underlying Asset Type (for FV calculations)",
  `ins_ts` DATETIME NOT NULL COMMENT "Insert Timestamp",
  PRIMARY KEY (`instance_id`),
  UNIQUE INDEX `ref_id_UNIQUE` (`ref_id` ASC) VISIBLE,
  UNIQUE INDEX `instance_id_UNIQUE` (`instance_id` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;