-- Author: Daniel Grammer
-- Date Created: 1/24/2025
-- Date Last Edited: 1/24/2025

-- ---------------------------- --
# Script for Creating Generated Allocation Schedules Logging Table
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `t_part_allocation_schedule_hist` (
  `instance_id` VARCHAR(36) NOT NULL COMMENT "Unique historical data instance identifier",
  `data_action` VARCHAR(1) NOT NULL COMMENT "I, U, D",
  `ref_id` VARCHAR(36) NOT NULL COMMENT "Unique Pariticipant Identifier",
  `risk_type` VARCHAR(45) NOT NULL COMMENT "Risk Type",
  `gen_allocation_schedule` JSON NOT NULL COMMENT "Asset Allocation and Time Schedule",
  `selected` TINYINT NOT NULL COMMENT "Boolean Participant Selection Indication",
  `gen_ts` DATETIME NOT NULL COMMENT "Generation Timestamp",
  `ins_ts` DATETIME NOT NULL COMMENT "Insert Timestamp",
  PRIMARY KEY (`instance_id`),
  FOREIGN KEY (`ref_id`) REFERENCES t_part_ref(`ref_id`),
  UNIQUE INDEX `instance_id_UNIQUE` (`instance_id` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;