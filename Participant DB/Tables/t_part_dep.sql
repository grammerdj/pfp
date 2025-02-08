-- Author: Daniel Grammer
-- Date Created: 1/24/2025
-- Date Last Edited: 1/24/2025

-- ---------------------------- --
# Script for Creating Participant Dependent Table
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `t_part_dep` (
  `ref_id` VARCHAR(36) NOT NULL COMMENT "Unique Pariticipant Identifier",
  `dep_id` VARCHAR(36) NOT NULL COMMENT "Unique Dependent Identifier",
  `first_nm` VARCHAR(100) NOT NULL COMMENT "Dependent First Name",
  `dob` VARCHAR(100) NOT NULL COMMENT "Dependent Date of Birth",
  `college_cntrb` DOUBLE NULL COMMENT "Estimated college contribution on a per-year basis",
  `college_strt_dt` YEAR(4) NULL COMMENT "Estimated Start Date of College",
  PRIMARY KEY (`ref_id`, `dep_id`),
  FOREIGN KEY (`ref_id`) REFERENCES t_part_ref(`ref_id`),
  UNIQUE INDEX `dep_id_UNIQUE` (`dep_id` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;