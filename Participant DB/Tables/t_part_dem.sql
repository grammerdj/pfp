-- Author: Daniel Grammer
-- Date Created: 1/24/2025
-- Date Last Edited: 1/24/2025

-- ---------------------------- --
# Script for Creating Participant Demographic Table
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `t_part_dem` (
  `ref_id` VARCHAR(36) NOT NULL COMMENT "Unique Pariticipant Identifier",
  `first_nm` VARCHAR(100) NOT NULL COMMENT "Participant First Name",
  `last_nm` VARCHAR(100) NOT NULL COMMENT "Participant Last Name",
  `dob` DATE NOT NULL COMMENT "Participant Date of Birth",
  `email_pr` VARCHAR(100) NOT NULL COMMENT "Participant Primary Email",
  `email_sec` VARCHAR(100) NULL COMMENT "Participant Secondary Email",
  `cntry` VARCHAR(3) NOT NULL COMMENT "Participant Country of Residence",
  `state` VARCHAR(2) NULL COMMENT "Participant State of Residence",
  `loc_cd` INT NOT NULL COMMENT "Participant Zip Code",
  `marital_st` TINYINT NOT NULL COMMENT "Participant Marital Status",
  `spouse_dob` DATE NULL COMMENT "Participant's Spouse's Date of Birth",
  `citizen_st` TINYINT NOT NULL COMMENT "Participant's Citizenship Status (SS Eligibility)",
  PRIMARY KEY (`ref_id`),
  FOREIGN KEY (`ref_id`) REFERENCES t_part_ref(`ref_id`),
  UNIQUE INDEX `ref_id_UNIQUE` (`ref_id` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;