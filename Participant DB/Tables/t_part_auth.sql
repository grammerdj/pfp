-- Author: Daniel Grammer
-- Date Created: 1/24/2025
-- Date Last Edited: 2/9/2025

-- ---------------------------- --
# Script for Creating Authentication Table
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `t_part_auth` (
  `ref_id` VARCHAR(36) NOT NULL COMMENT "Unique Pariticipant Identifier",
  `username` VARCHAR(20) NOT NULL COMMENT "User Set Username",
  `password` VARCHAR(100) NOT NULL COMMENT "User Set Password",
  `previous_pwds` JSON NOT NULL COMMENT "Date Changed: PWD",
  `email_otp` VARCHAR(100) NOT NULL COMMENT "Email to send One-time passcodes",
  `sq_1` VARCHAR(1000) NOT NULL COMMENT "Security Question #1",
  `sq_1_ans` VARCHAR(100) NOT NULL COMMENT "Security Question #1 Answer",
  `sq_2` VARCHAR(1000) NOT NULL COMMENT "Security Question #2",
  `sq_2_ans` VARCHAR(100) NOT NULL COMMENT "Security Question #2 Answer",
  `ins_ts` DATETIME NULL COMMENT "Insert Timestamp",
  PRIMARY KEY (`ref_id`),
  FOREIGN KEY (`ref_id`) REFERENCES t_part_ref(`ref_id`),
  UNIQUE INDEX `ref_id_UNIQUE` (`ref_id` ASC) VISIBLE,
  UNIQUE INDEX `email_otp_UNIQUE` (`email_otp` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;