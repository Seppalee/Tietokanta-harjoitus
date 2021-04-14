-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema streamingservice_database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema streamingservice_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `streamingservice_database` DEFAULT CHARACTER SET utf8 ;
USE `streamingservice_database` ;

-- -----------------------------------------------------
-- Table `streamingservice_database`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streamingservice_database`.`subscription` (
  `idsubscription` INT(11) NOT NULL AUTO_INCREMENT,
  `subcription_type` VARCHAR(45) NOT NULL,
  `price` VARCHAR(45) NOT NULL,
  `quality` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idsubscription`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `streamingservice_database`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streamingservice_database`.`account` (
  `iduser` INT(11) NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phonenumber` VARCHAR(45) NOT NULL,
  `subscription_idsubscription` INT(11) NOT NULL,
  PRIMARY KEY (`iduser`),
  INDEX `fk_user_subscription_idx` (`subscription_idsubscription` ASC) VISIBLE,
  CONSTRAINT `fk_user_subscription`
    FOREIGN KEY (`subscription_idsubscription`)
    REFERENCES `streamingservice_database`.`subscription` (`idsubscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `streamingservice_database`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streamingservice_database`.`genre` (
  `idgenre` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idgenre`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `streamingservice_database`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streamingservice_database`.`movie` (
  `idmovie` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `release_year` INT(11) NULL DEFAULT NULL,
  `mpaa_rating` VARCHAR(45) NULL DEFAULT NULL,
  `subscription_idsubscription` INT(11) NOT NULL,
  PRIMARY KEY (`idmovie`),
  INDEX `fk_movie_subscription1_idx` (`subscription_idsubscription` ASC) VISIBLE,
  CONSTRAINT `fk_movie_subscription1`
    FOREIGN KEY (`subscription_idsubscription`)
    REFERENCES `streamingservice_database`.`subscription` (`idsubscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `streamingservice_database`.`movie_has_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streamingservice_database`.`movie_has_genre` (
  `movie_idmovie` INT(11) NOT NULL,
  `genre_idgenre` INT(11) NOT NULL,
  PRIMARY KEY (`movie_idmovie`, `genre_idgenre`),
  INDEX `fk_movie_has_genre_genre1_idx` (`genre_idgenre` ASC) VISIBLE,
  INDEX `fk_movie_has_genre_movie1_idx` (`movie_idmovie` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_genre_genre1`
    FOREIGN KEY (`genre_idgenre`)
    REFERENCES `streamingservice_database`.`genre` (`idgenre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_genre_movie1`
    FOREIGN KEY (`movie_idmovie`)
    REFERENCES `streamingservice_database`.`movie` (`idmovie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `streamingservice_database`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streamingservice_database`.`payment` (
  `idpayment` INT(11) NOT NULL AUTO_INCREMENT,
  `method` VARCHAR(45) NOT NULL,
  `payment_date` DATE NULL DEFAULT NULL,
  `user_iduser` INT(11) NOT NULL,
  `subscription_idsubscription` INT(11) NOT NULL,
  PRIMARY KEY (`idpayment`, `user_iduser`, `subscription_idsubscription`),
  INDEX `fk_payment_user1_idx` (`user_iduser` ASC) VISIBLE,
  INDEX `fk_payment_subscription1_idx` (`subscription_idsubscription` ASC) VISIBLE,
  CONSTRAINT `fk_payment_subscription1`
    FOREIGN KEY (`subscription_idsubscription`)
    REFERENCES `streamingservice_database`.`subscription` (`idsubscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `streamingservice_database`.`account` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
