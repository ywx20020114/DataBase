-- MySQL Script generated by MySQL Workbench
-- Fri Jun 10 17:19:32 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema java_sql
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema java_sql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `java_sql` DEFAULT CHARACTER SET utf8 ;
USE `java_sql` ;

-- -----------------------------------------------------
-- Table `java_sql`.`cinema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_sql`.`cinema` (
  `cinema_id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `address` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  PRIMARY KEY USING BTREE (`cinema_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = DYNAMIC;


-- -----------------------------------------------------
-- Table `java_sql`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_sql`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `uname` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `passwd` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `type` INT NULL DEFAULT '0' COMMENT '0代表普通用户，1代表管理员',
  `balance` DOUBLE NULL DEFAULT NULL,
  `level` INT NULL DEFAULT NULL,
  PRIMARY KEY USING BTREE (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = DYNAMIC;


-- -----------------------------------------------------
-- Table `java_sql`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_sql`.`movie` (
  `movie_id` INT NOT NULL AUTO_INCREMENT,
  `mname` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `type` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL COMMENT '电影类型',
  `detail` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `duration` INT NULL DEFAULT NULL,
  `img` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL COMMENT '保存图片名称',
  PRIMARY KEY USING BTREE (`movie_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = DYNAMIC;


-- -----------------------------------------------------
-- Table `java_sql`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_sql`.`comment` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `content` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `datetime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY USING BTREE (`comment_id`),
  INDEX `comment_ibfk_1` USING BTREE (`user_id`),
  INDEX `comment_ibfk_2` USING BTREE (`movie_id`),
  CONSTRAINT `comment_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `java_sql`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `comment_ibfk_2`
    FOREIGN KEY (`movie_id`)
    REFERENCES `java_sql`.`movie` (`movie_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = DYNAMIC;


-- -----------------------------------------------------
-- Table `java_sql`.`hall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_sql`.`hall` (
  `hall_id` INT NOT NULL AUTO_INCREMENT,
  `hname` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `capacity` INT NULL DEFAULT NULL,
  `cinema_id` INT NOT NULL,
  PRIMARY KEY USING BTREE (`hall_id`),
  INDEX `hall_ibfk_1` USING BTREE (`cinema_id`),
  CONSTRAINT `hall_ibfk_1`
    FOREIGN KEY (`cinema_id`)
    REFERENCES `java_sql`.`cinema` (`cinema_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = DYNAMIC;


-- -----------------------------------------------------
-- Table `java_sql`.`session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_sql`.`session` (
  `session_id` INT NOT NULL AUTO_INCREMENT,
  `hall_id` INT NOT NULL,
  `cinema_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `starttime` VARCHAR(11) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `price` DOUBLE NULL DEFAULT NULL,
  `remain` INT NULL DEFAULT NULL,
  PRIMARY KEY USING BTREE (`session_id`),
  INDEX `hall_id` USING BTREE (`hall_id`),
  INDEX `cinema_id` USING BTREE (`cinema_id`),
  INDEX `movie_id` USING BTREE (`movie_id`),
  CONSTRAINT `session_ibfk_1`
    FOREIGN KEY (`hall_id`)
    REFERENCES `java_sql`.`hall` (`hall_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `session_ibfk_2`
    FOREIGN KEY (`cinema_id`)
    REFERENCES `java_sql`.`cinema` (`cinema_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `session_ibfk_3`
    FOREIGN KEY (`movie_id`)
    REFERENCES `java_sql`.`movie` (`movie_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = DYNAMIC;


-- -----------------------------------------------------
-- Table `java_sql`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_sql`.`ticket` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `session_id` INT NOT NULL,
  `seat` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ticket_id`),
  INDEX `ticket_ibfk_1` USING BTREE (`user_id`),
  INDEX `ticket_ibfk_2` USING BTREE (`movie_id`),
  INDEX `ticket_ibfk_3` USING BTREE (`session_id`),
  CONSTRAINT `ticket_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `java_sql`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ticket_ibfk_2`
    FOREIGN KEY (`movie_id`)
    REFERENCES `java_sql`.`movie` (`movie_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ticket_ibfk_3`
    FOREIGN KEY (`session_id`)
    REFERENCES `java_sql`.`session` (`session_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 64
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = DYNAMIC;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
