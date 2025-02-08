-- Author: Daniel Grammer
-- Date Created: 1/24/2025
-- Date Last Edited: 1/24/2025

-- ---------------------------- --
# Script for Creating Participant Configured Allocations Table
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `t_part_allocations` (
  `ref_id` VARCHAR(36) NOT NULL COMMENT "Unique Pariticipant Identifier",
  `fund_id` VARCHAR(100) NOT NULL COMMENT "Fund Name to Locate Configuration JSON",
  `amnt` DOUBLE NOT NULL COMMENT "Amount in Fund",
  `strt_dt` DATE NOT NULL COMMENT "Start Date of Investment",
  `strt_price` DOUBLE NULL COMMENT "Starting Price of Investment (p/u * u)",
  `snapshot_ts` DATETIME NOT NULL COMMENT "Insert Timestamp",
  PRIMARY KEY (`ref_id`),
  FOREIGN KEY (`ref_id`) REFERENCES t_part_ref(`ref_id`),
  UNIQUE INDEX `ref_id_UNIQUE` (`ref_id` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;