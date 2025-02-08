-- Author: Daniel Grammer
-- Date Created: 1/24/2025
-- Date Last Edited: 1/24/2025

-- ---------------------------- --
# Script for Creating Participant Financial Goal Table
-- ---------------------------- --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `t_part_fin_goal` (
  `ref_id` VARCHAR(36) NOT NULL COMMENT "Unique Pariticipant Identifier",
  `goal_id` VARCHAR(36) NOT NULL COMMENT "Unique Goal Identifier",
  `goal_nm` VARCHAR(100) NOT NULL COMMENT "Goal Name",
  `goal_strt_dt` DATE NULL COMMENT "Goal Start Date",
  `goal_avg_cash_flow` DOUBLE NOT NULL COMMENT "Goal Average Period Cash Flow",
  `goal_avg_periodicity` DOUBLE NOT NULL COMMENT "Goal Average Periodicity",
  `goal_est_dur` INT NULL COMMENT "Goal estimated number of periods",
  PRIMARY KEY (`ref_id`, `goal_id`),
  FOREIGN KEY (`ref_id`) REFERENCES t_part_ref(`ref_id`),
  UNIQUE INDEX `ref_id_UNIQUE` (`ref_id` ASC) VISIBLE,
  UNIQUE INDEX `goal_id_UNIQUE` (`goal_id` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;