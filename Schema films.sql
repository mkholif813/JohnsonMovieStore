
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
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `films`.`awards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`awards` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`));


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
    REFERENCES `films`.`awards` (`id`));


-- -----------------------------------------------------
-- Table `films`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`address` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(25) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `films`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`category` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);


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
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `films`.`formats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`formats` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `dvd_UNIQUE` (`type` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `films`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`genres` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`));


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
    ON UPDATE CASCADE);


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
    ON UPDATE CASCADE);


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
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);


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
    REFERENCES `films`.`vendors` (`id`));


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
    REFERENCES `films`.`movies` (`id`));


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
    ON UPDATE CASCADE);


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
    ON UPDATE CASCADE);


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
    REFERENCES `films`.`movies` (`id`));


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
    REFERENCES `films`.`vendors` (`id`));

USE `films` ;

-- -----------------------------------------------------
-- Placeholder table for view `films`.`customers_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`customers_address` (`id` INT, `last_name` INT, `first_name` INT, `street` INT, `city` INT, `zip` INT, `country` INT);

-- -----------------------------------------------------
-- View `films`.`customers_address`
-- -----------------------------------------------------
SELECT 
        `films`.`customers`.`ID` AS `id`,
        `films`.`customers`.`last_name` AS `last_name`,
        `films`.`customers`.`first_name` AS `first_name`,
        `films`.`address`.`street` AS `street`,
        `films`.`address`.`city` AS `city`,
        `films`.`address`.`zip` AS `zip`,
        `films`.`address`.`country` AS `country`
    FROM
        (`films`.`customers`
        JOIN `films`.`address` ON ((`films`.`address`.`id` = `films`.`customers`.`address_id`)))
    ORDER BY `films`.`customers`.`ID`;
-- -----------------------------------------------------
-- Placeholder table for view `films`.`dvd_30_rented`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `films`.`dvd_30_rented` (`MovieId` INT, `type` INT, `rental_date` INT);
-- -----------------------------------------------------
SELECT 
        `films`.`movies`.`id` AS `MovieId`,
        `films`.`formats`.`type` AS `type`,
        `films`.`rental`.`rental_date` AS `rental_date`
    FROM
        ((`films`.`movies`
        JOIN `films`.`formats` ON ((`films`.`formats`.`id` = `films`.`movies`.`formats_id`)))
        JOIN `films`.`rental` ON ((`films`.`rental`.`movies_id` = `films`.`movies`.`id`)))
    WHERE
        ((`films`.`formats`.`id` = 1)
            AND (`films`.`rental`.`rental_date` BETWEEN (CURDATE() - INTERVAL 30 DAY) AND CURDATE()))
    ORDER BY `films`.`rental`.`rental_date` DESC;
-- -----------------------------------------------------


