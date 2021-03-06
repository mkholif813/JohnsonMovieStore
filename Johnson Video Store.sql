-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema films
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema films
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `films` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `films` ;

-- -----------------------------------------------------
-- Table `films`.`actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`actors` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 51
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`awards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`awards` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`actors_awards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`actors_awards` (
  `actors_id` SMALLINT(5) UNSIGNED NOT NULL,
  `awards_id` INT(11) NOT NULL,
  PRIMARY KEY (`actors_id`, `awards_id`),
  INDEX `fk_actors_has_awards_awards1_idx` (`awards_id` ASC) VISIBLE,
  INDEX `fk_actors_has_awards_actors1_idx` (`actors_id` ASC) VISIBLE,
  CONSTRAINT `fk_actors_has_awards_actors1`
    FOREIGN KEY (`actors_id`)
    REFERENCES `films`.`actors` (`id`),
  CONSTRAINT `fk_actors_has_awards_awards1`
    FOREIGN KEY (`awards_id`)
    REFERENCES `films`.`awards` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`address` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(25) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 50
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`category` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`customers` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `address_id` INT(11) NOT NULL,
  `created_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  INDEX `fk_customers_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `films`.`address` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`formats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`formats` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `dvd_UNIQUE` (`type` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`genres` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`store` (
  `id` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `address_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_store_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_store_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `films`.`address` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`movies` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `released_year` YEAR(4) NOT NULL,
  `runtime` INT(11) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `rental_rate` DECIMAL(4,2) NOT NULL DEFAULT '3.99',
  `replacement_cost` DECIMAL(4,2) NOT NULL DEFAULT '14.99',
  `formats_id` INT(11) NULL DEFAULT NULL,
  `store_id` SMALLINT(5) NULL DEFAULT NULL,
  `genres_id` INT(11) NOT NULL,
  `category_id` TINYINT(3) UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE,
  INDEX `fk_movies_genres1_idx` (`genres_id` ASC) VISIBLE,
  INDEX `fk_movies_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_store_id_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_formats_id_idx` (`formats_id` ASC) VISIBLE,
  CONSTRAINT `fk_formats_id`
    FOREIGN KEY (`formats_id`)
    REFERENCES `films`.`formats` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_movies_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `films`.`category` (`id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_movies_genres1`
    FOREIGN KEY (`genres_id`)
    REFERENCES `films`.`genres` (`id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_store_id`
    FOREIGN KEY (`store_id`)
    REFERENCES `films`.`store` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 223
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`vendors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(25) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`inventory` (
  `sku` INT(11) NOT NULL AUTO_INCREMENT,
  `vendors_id` INT(11) NOT NULL,
  `movies_id` INT(11) NOT NULL,
  `store_id` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`sku`),
  INDEX `fk_inventory_vendors1_idx` (`vendors_id` ASC) VISIBLE,
  INDEX `fk_inventory_movies1_idx` (`movies_id` ASC) VISIBLE,
  INDEX `fk_inventory_store1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `films`.`movies` (`id`),
  CONSTRAINT `fk_inventory_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `films`.`store` (`id`),
  CONSTRAINT `fk_inventory_vendors1`
    FOREIGN KEY (`vendors_id`)
    REFERENCES `films`.`vendors` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 381
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`movies_awards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`movies_awards` (
  `movies_id` INT(11) NOT NULL,
  `awards_id` INT(11) NOT NULL,
  PRIMARY KEY (`movies_id`, `awards_id`),
  INDEX `fk_movies_has_awards_awards1_idx` (`awards_id` ASC) VISIBLE,
  INDEX `fk_movies_has_awards_movies1_idx` (`movies_id` ASC) VISIBLE,
  CONSTRAINT `fk_movies_has_awards_awards1`
    FOREIGN KEY (`awards_id`)
    REFERENCES `films`.`awards` (`id`),
  CONSTRAINT `fk_movies_has_awards_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `films`.`movies` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`staff` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `store_id` SMALLINT(5) NOT NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  INDEX `fk_staff_store1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `films`.`store` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`payment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `customers_ID` INT(11) NOT NULL,
  `staff_id` INT(11) NOT NULL,
  `rental_id` INT(11) NOT NULL,
  `amount` DECIMAL(5,2) NULL DEFAULT NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_payment_customers1_idx` (`customers_ID` ASC) VISIBLE,
  INDEX `fk_payment_staff1_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_payment_rental1_idx` (`rental_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_customers1`
    FOREIGN KEY (`customers_ID`)
    REFERENCES `films`.`customers` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `films`.`staff` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 166
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`rental` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `movies_id` INT(11) NOT NULL,
  `customers_ID` INT(11) NOT NULL,
  `rental_date` DATE NULL DEFAULT NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_rental_movies1_idx` (`movies_id` ASC) VISIBLE,
  INDEX `fk_rental_customers1_idx` (`customers_ID` ASC) VISIBLE,
  CONSTRAINT `fk_rental_customers1`
    FOREIGN KEY (`customers_ID`)
    REFERENCES `films`.`customers` (`ID`),
  CONSTRAINT `fk_rental_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `films`.`movies` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 127
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `films`.`vendors_formats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`vendors_formats` (
  `vendors_id` INT(11) NOT NULL,
  `formats_id` INT(11) NOT NULL,
  PRIMARY KEY (`vendors_id`, `formats_id`),
  INDEX `fk_vendors_has_formats_formats1_idx` (`formats_id` ASC) VISIBLE,
  INDEX `fk_vendors_has_formats_vendors1_idx` (`vendors_id` ASC) VISIBLE,
  CONSTRAINT `fk_vendors_has_formats_formats1`
    FOREIGN KEY (`formats_id`)
    REFERENCES `films`.`formats` (`id`),
  CONSTRAINT `fk_vendors_has_formats_vendors1`
    FOREIGN KEY (`vendors_id`)
    REFERENCES `films`.`vendors` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `films` ;

-- -----------------------------------------------------
-- Placeholder table for view `films`.`customers_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`customers_address` (`id` INT, `last_name` INT, `first_name` INT, `street` INT, `city` INT, `zip` INT, `country` INT);

-- -----------------------------------------------------
-- Placeholder table for view `films`.`customers_sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`customers_sales` (`ID` INT, `Customer Name` INT, `street` INT, `city` INT, `zip` INT, `country` INT, `movies_id` INT, `Staff Id` INT, `Store id` INT, `rental_date` INT, `return_date` INT, `amount` INT);

-- -----------------------------------------------------
-- Placeholder table for view `films`.`dvd_30_rented`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`dvd_30_rented` (`MovieId` INT, `type` INT, `rental_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `films`.`rented30_dvd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`rented30_dvd` (`CustID` INT, `CustName` INT, `movies_id` INT, `type` INT, `rental_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `films`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`sales` (`ID` INT, `Customer Name` INT, `street` INT, `city` INT, `zip` INT, `country` INT, `movies_id` INT, `Staff Id` INT, `Store id` INT, `rental_date` INT, `return_date` INT, `amount` INT);

-- -----------------------------------------------------
-- View `films`.`customers_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `films`.`customers_address`;
USE `films`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `films`.`customers_address` AS select `films`.`customers`.`ID` AS `id`,`films`.`customers`.`last_name` AS `last_name`,`films`.`customers`.`first_name` AS `first_name`,`films`.`address`.`street` AS `street`,`films`.`address`.`city` AS `city`,`films`.`address`.`zip` AS `zip`,`films`.`address`.`country` AS `country` from (`films`.`customers` join `films`.`address` on((`films`.`address`.`id` = `films`.`customers`.`address_id`))) order by `films`.`customers`.`ID`;

-- -----------------------------------------------------
-- View `films`.`customers_sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `films`.`customers_sales`;
USE `films`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `films`.`customers_sales` AS select `films`.`customers`.`ID` AS `ID`,concat(`films`.`customers`.`first_name`,' ',`films`.`customers`.`last_name`) AS `Customer Name`,`films`.`address`.`street` AS `street`,`films`.`address`.`city` AS `city`,`films`.`address`.`zip` AS `zip`,`films`.`address`.`country` AS `country`,`films`.`rental`.`movies_id` AS `movies_id`,`films`.`staff`.`id` AS `Staff Id`,`films`.`store`.`id` AS `Store id`,`films`.`rental`.`rental_date` AS `rental_date`,(`films`.`rental`.`rental_date` + interval 3 day) AS `return_date`,`films`.`payment`.`amount` AS `amount` from (((((`films`.`rental` join `films`.`customers` on((`films`.`rental`.`customers_ID` = `films`.`customers`.`ID`))) join `films`.`payment` on((`films`.`payment`.`rental_id` = `films`.`rental`.`id`))) join `films`.`address` on((`films`.`customers`.`address_id` = `films`.`customers`.`address_id`))) join `films`.`staff` on((`films`.`payment`.`staff_id` = `films`.`payment`.`staff_id`))) join `films`.`store` on((`films`.`store`.`id` = `films`.`staff`.`store_id`))) order by `films`.`customers`.`ID`;

-- -----------------------------------------------------
-- View `films`.`dvd_30_rented`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `films`.`dvd_30_rented`;
USE `films`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `films`.`dvd_30_rented` AS select `films`.`movies`.`id` AS `MovieId`,`films`.`formats`.`type` AS `type`,`films`.`rental`.`rental_date` AS `rental_date` from ((`films`.`movies` join `films`.`formats` on((`films`.`formats`.`id` = `films`.`movies`.`formats_id`))) join `films`.`rental` on((`films`.`rental`.`movies_id` = `films`.`movies`.`id`))) where ((`films`.`formats`.`id` = 1) and (`films`.`rental`.`rental_date` between (curdate() - interval 30 day) and curdate())) order by `films`.`rental`.`rental_date` desc;

-- -----------------------------------------------------
-- View `films`.`rented30_dvd`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `films`.`rented30_dvd`;
USE `films`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `films`.`rented30_dvd` AS select `films`.`customers`.`ID` AS `CustID`,concat(`films`.`customers`.`last_name`,' ',`films`.`customers`.`first_name`) AS `CustName`,`films`.`rental`.`movies_id` AS `movies_id`,`films`.`formats`.`type` AS `type`,`films`.`rental`.`rental_date` AS `rental_date` from ((((`films`.`rental` join `films`.`customers` on((`films`.`customers`.`ID` = `films`.`rental`.`customers_ID`))) join `films`.`movies` on((`films`.`movies`.`id` = `films`.`rental`.`movies_id`))) join `films`.`formats` on((`films`.`formats`.`id` = `films`.`movies`.`formats_id`))) join (select `films`.`movies`.`title` AS `title`,`films`.`formats`.`type` AS `type` from (`films`.`movies` join `films`.`formats` on((`films`.`formats`.`id` = `films`.`movies`.`formats_id`))) where (`films`.`formats`.`id` = 1)) `y` on((`films`.`formats`.`id` = `films`.`movies`.`formats_id`))) where (`films`.`rental`.`rental_date` between (curdate() - interval 30 day) and curdate()) order by `films`.`rental`.`rental_date` desc;

-- -----------------------------------------------------
-- View `films`.`sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `films`.`sales`;
USE `films`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `films`.`sales` AS select `films`.`customers`.`ID` AS `ID`,concat(`films`.`customers`.`first_name`,' ',`films`.`customers`.`last_name`) AS `Customer Name`,`films`.`address`.`street` AS `street`,`films`.`address`.`city` AS `city`,`films`.`address`.`zip` AS `zip`,`films`.`address`.`country` AS `country`,`films`.`rental`.`movies_id` AS `movies_id`,`films`.`staff`.`id` AS `Staff Id`,`films`.`store`.`id` AS `Store id`,`films`.`rental`.`rental_date` AS `rental_date`,(`films`.`rental`.`rental_date` + interval 3 day) AS `return_date`,`films`.`payment`.`amount` AS `amount` from (((((`films`.`rental` join `films`.`customers` on((`films`.`rental`.`customers_ID` = `films`.`customers`.`ID`))) join `films`.`payment` on((`films`.`payment`.`rental_id` = `films`.`rental`.`id`))) join `films`.`address` on((`films`.`customers`.`address_id` = `films`.`customers`.`address_id`))) join `films`.`staff` on((`films`.`payment`.`staff_id` = `films`.`payment`.`staff_id`))) join `films`.`store` on((`films`.`store`.`id` = `films`.`staff`.`store_id`))) order by `films`.`customers`.`ID`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
