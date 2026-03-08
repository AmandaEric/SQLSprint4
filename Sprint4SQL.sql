-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Sprint4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Sprint4
-- -----------------------------------------------------
CREATE SCHEMA  `Sprint4`;
USE `Sprint4` ;

-- -----------------------------------------------------
-- Table `Sprint4`.`Companies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint4`.`Companies` (
  `Companies_id` INT NOT NULL,
  `LocationCity` VARCHAR(45) NOT NULL,
  `CompanyName` VARCHAR(45) NOT NULL,
  `LocationState` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Companies_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sprint4`.`Jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint4`.`Jobs` (
  `Jobs_id` INT NOT NULL,
  `job_name` VARCHAR(75) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `full_part_time` VARCHAR(45) NOT NULL,
  `Jobscol` VARCHAR(45) NULL,
  `Companies_id` INT NOT NULL,
  PRIMARY KEY (`Jobs_id`),
  INDEX `fk_Jobs_Companies1_idx` (`Companies_id` ASC) VISIBLE,
  CONSTRAINT `fk_Jobs_Companies1`
    FOREIGN KEY (`Companies_id`)
    REFERENCES `Sprint4`.`Companies` (`Companies_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sprint4`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint4`.`Users` (
  `Users_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Users_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sprint4`.`Application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint4`.`Application` (
  `Application_id` INT NOT NULL AUTO_INCREMENT,
  `Application_date` DATE NOT NULL,
  `Users_id1` INT NOT NULL,
  `Jobs_id1` INT NOT NULL,
  PRIMARY KEY (`Application_id`),
  INDEX `fk_Application_Users_idx` (`Users_id1` ASC) VISIBLE,
  INDEX `fk_Application_Jobs1_idx` (`Jobs_id1` ASC) VISIBLE,
  CONSTRAINT `fk_Application_Users`
    FOREIGN KEY (`Users_id1`)
    REFERENCES `Sprint4`.`Users` (`Users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Application_Jobs1`
    FOREIGN KEY (`Jobs_id1`)
    REFERENCES `Sprint4`.`Jobs` (`Jobs_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SELECT Jobs.job_name, Jobs.salary, Companies.CompanyName
FROM Jobs
JOIN Companies ON Jobs.Companies_id = Companies.Companies_id;

INSERT INTO Users (Users_id, first_name, last_name, address, status)
VALUES (1, 'Amanda', 'Ericson', 'Rexburg', 'Active');
INSERT INTO Users (Users_id, first_name, last_name, address, status) VALUES
(2, 'Jake', 'Miller', 'Boise', 'Active'),
(3, 'Sarah', 'Johnson', 'Idaho Falls', 'Active'),
(4, 'Liam', 'Garcia', 'Provo', 'Inactive'),
(5, 'Emma', 'Wilson', 'Logan', 'Active');

INSERT INTO Companies (Companies_id, LocationCity, CompanyName, LocationState)
VALUES (1, 'Boise', 'Tech Solutions', 'Idaho');
INSERT INTO Companies (Companies_id, LocationCity, CompanyName, LocationState) VALUES
(2, 'Salt Lake City', 'Mountain Software', 'Utah'),
(3, 'Seattle', 'Cloud Innovations', 'Washington'),
(4, 'Denver', 'Rocky Tech', 'Colorado');

INSERT INTO Jobs (Jobs_id, job_name, salary, status, full_part_time, Companies_id)
VALUES (1, 'Software Developer', 85000.00, 'Open', 'Full-Time', 1);
INSERT INTO Jobs (Jobs_id, job_name, salary, status, full_part_time, Companies_id) VALUES
(2, 'Web Developer', 70000.00, 'Open', 'Full-Time', 2),
(3, 'Database Administrator', 90000.00, 'Open', 'Full-Time', 3),
(4, 'IT Support Specialist', 55000.00, 'Closed', 'Full-Time', 1),
(5, 'Frontend Developer', 75000.00, 'Open', 'Part-Time', 4);

INSERT INTO Application (Application_date, Users_id1, Jobs_id1)
VALUES ('2026-03-07', 1, 1);
INSERT INTO Application (Application_date, Users_id1, Jobs_id1) VALUES
('2026-03-02', 2, 1),
('2026-03-03', 3, 2),
('2026-03-04', 4, 3),
('2026-03-05', 5, 5),
('2026-03-06', 1, 3),
('2026-03-07', 2, 2);

UPDATE Jobs
SET salary = 90000
WHERE Jobs_id = 1;

UPDATE Users
SET status = 'Inactive'
WHERE Users_id = 1;

DELETE FROM Application
WHERE Application_id = 1;

SELECT Users.first_name, Users.last_name, Jobs.job_name, Application.Application_date
FROM Application
JOIN Users ON Application.Users_id1 = Users.Users_id
JOIN Jobs ON Application.Jobs_id1 = Jobs.Jobs_id;