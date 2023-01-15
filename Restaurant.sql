-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema DB_Project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DB_Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DB_Project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `DB_Project` ;

-- -----------------------------------------------------
-- Table `DB_Project`.`RESTAURANT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`RESTAURANT` (
  `phone#` BIGINT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `opentime` TIME NOT NULL,
  `closetime` TIME NOT NULL,
  `area` VARCHAR(45) NOT NULL,
  `contractissuedate` DATE NOT NULL,
  PRIMARY KEY (`phone#`, `address`),
  UNIQUE INDEX `Phone#_UNIQUE` (`phone#` ASC) VISIBLE,
  UNIQUE INDEX `Address_UNIQUE` (`address` ASC) VISIBLE,
  INDEX `FK_Restaurant` (`address` ASC, `phone#` ASC, `name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`EMPLOYEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`EMPLOYEE` (
  `employeeid` VARCHAR(4) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `middlename` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NULL DEFAULT NULL,
  `dob` DATE NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `start_date` VARCHAR(45) NOT NULL,
  `raddress` VARCHAR(45) NULL DEFAULT NULL,
  `rphone#` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`employeeid`),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`employeeid` ASC) VISIBLE,
  INDEX `FK_RAddress_idx` (`raddress` ASC) VISIBLE,
  INDEX `FK_RPhone#_idx` (`rphone#` ASC) VISIBLE,
  CONSTRAINT `FK_RAddress`
    FOREIGN KEY (`raddress`)
    REFERENCES `DB_Project`.`RESTAURANT` (`address`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_RPhone#`
    FOREIGN KEY (`rphone#`)
    REFERENCES `DB_Project`.`RESTAURANT` (`phone#`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`AREA_MANAGER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`AREA_MANAGER` (
  `managerid` VARCHAR(4) NOT NULL,
  `area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`managerid`, `area`),
  UNIQUE INDEX `ManagerID_UNIQUE` (`managerid` ASC) VISIBLE,
  INDEX `FK_RManager` (`area` ASC, `managerid` ASC) VISIBLE,
  INDEX `FK_AMEmployeeID_idx` (`managerid` ASC) VISIBLE,
  CONSTRAINT `FK_AMEmployeeID`
    FOREIGN KEY (`managerid`)
    REFERENCES `DB_Project`.`EMPLOYEE` (`employeeid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`PROMOTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`PROMOTION` (
  `code` VARCHAR(8) NOT NULL,
  `raddress` VARCHAR(45) NOT NULL,
  `rphone#` BIGINT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`, `raddress`, `rphone#`),
  UNIQUE INDEX `Code_UNIQUE` (`code` ASC) VISIBLE,
  INDEX `FK_PromotionRAddress_idx` (`raddress` ASC) VISIBLE,
  INDEX `FK_PromotionRPhone#_idx` (`rphone#` ASC) VISIBLE,
  CONSTRAINT `FK_PromotionRAddress`
    FOREIGN KEY (`raddress`)
    REFERENCES `DB_Project`.`RESTAURANT` (`address`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PromotionRPhone#`
    FOREIGN KEY (`rphone#`)
    REFERENCES `DB_Project`.`RESTAURANT` (`phone#`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`CUSTOMER` (
  `customerID` VARCHAR(4) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `middlename` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `phone#` BIGINT NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `promotioncode` VARCHAR(8) NULL DEFAULT NULL,
  PRIMARY KEY (`customerID`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`customerID` ASC) VISIBLE,
  INDEX `FK_CustomerID` (`customerID` ASC) VISIBLE,
  INDEX `FK_PCode_idx` (`promotioncode` ASC) VISIBLE,
  CONSTRAINT `FK_PCode`
    FOREIGN KEY (`promotioncode`)
    REFERENCES `DB_Project`.`PROMOTION` (`code`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`DELIVERER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`DELIVERER` (
  `delivererid` VARCHAR(4) NOT NULL,
  `area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`delivererid`, `area`),
  UNIQUE INDEX `DelivererID_UNIQUE` (`delivererid` ASC) VISIBLE,
  INDEX `FK_OrderDelivery` (`area` ASC, `delivererid` ASC) VISIBLE,
  INDEX `FK_DelivererID_idx` (`delivererid` ASC) VISIBLE,
  CONSTRAINT `FK_DelieverID`
    FOREIGN KEY (`delivererid`)
    REFERENCES `DB_Project`.`EMPLOYEE` (`employeeid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`DELIVERER_MANAGER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`DELIVERER_MANAGER` (
  `delivererid` VARCHAR(4) NOT NULL,
  `dmanagerid` VARCHAR(4) NOT NULL,
  `dmanagerarea` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`delivererid`),
  UNIQUE INDEX `DelivererID_UNIQUE` (`delivererid` ASC) VISIBLE,
  INDEX `FK_DManagerID_idx` (`dmanagerid` ASC) VISIBLE,
  INDEX `FK_DManagerArea_idx` (`dmanagerarea` ASC) VISIBLE,
  CONSTRAINT `FK_DManagerArea`
    FOREIGN KEY (`dmanagerarea`)
    REFERENCES `DB_Project`.`AREA_MANAGER` (`area`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_DManagerID`
    FOREIGN KEY (`dmanagerid`)
    REFERENCES `DB_Project`.`AREA_MANAGER` (`managerid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_MDelivererID`
    FOREIGN KEY (`delivererid`)
    REFERENCES `DB_Project`.`DELIVERER` (`delivererid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`EMPLOYEE_PHONE#`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`EMPLOYEE_PHONE#` (
  `employeeid` VARCHAR(4) NOT NULL,
  `phone#` BIGINT NOT NULL,
  PRIMARY KEY (`employeeid`, `phone#`),
  UNIQUE INDEX `Phone#_UNIQUE` (`phone#` ASC) VISIBLE,
  INDEX `FK_EPEmployeeID_idx` (`employeeid` ASC) VISIBLE,
  CONSTRAINT `FK_EPEmployeeID`
    FOREIGN KEY (`employeeid`)
    REFERENCES `DB_Project`.`EMPLOYEE` (`employeeid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`SILVER_MEMBER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`SILVER_MEMBER` (
  `customerid` VARCHAR(4) NOT NULL,
  `issuedate` DATE NOT NULL,
  PRIMARY KEY (`customerid`, `issuedate`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`customerid` ASC) VISIBLE,
  INDEX `FK_CardIssueDate_idx` (`issuedate` ASC) VISIBLE,
  INDEX `FK_SMCustomerID_idx` (`customerid` ASC) VISIBLE,
  CONSTRAINT `FK_SMCustomerID`
    FOREIGN KEY (`customerid`)
    REFERENCES `DB_Project`.`CUSTOMER` (`customerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`STAFF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`STAFF` (
  `staffid` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`staffid`),
  UNIQUE INDEX `StaffID_UNIQUE` (`staffid` ASC) VISIBLE,
  INDEX `FK_SEmployeeID_idx` (`staffid` ASC) VISIBLE,
  CONSTRAINT `FK_SEmployeeID`
    FOREIGN KEY (`staffid`)
    REFERENCES `DB_Project`.`EMPLOYEE` (`employeeid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`ISSUE_CARD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`ISSUE_CARD` (
  `staffid` VARCHAR(4) NOT NULL,
  `customerid` VARCHAR(4) NOT NULL,
  `cardissuedate` DATE NOT NULL,
  PRIMARY KEY (`staffid`, `customerid`),
  UNIQUE INDEX `StaffID_UNIQUE` (`staffid` ASC) VISIBLE,
  UNIQUE INDEX `CustomerID_UNIQUE` (`customerid` ASC) VISIBLE,
  INDEX `PK_CardStaffID_idx` (`staffid` ASC) VISIBLE,
  INDEX `PK_CardCustomerID_idx` (`customerid` ASC) VISIBLE,
  INDEX `PK_CardIssueDate_idx` (`cardissuedate` ASC) VISIBLE,
  CONSTRAINT `FK_CardCustomerID`
    FOREIGN KEY (`customerid`)
    REFERENCES `DB_Project`.`CUSTOMER` (`customerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CardIssueDate`
    FOREIGN KEY (`cardissuedate`)
    REFERENCES `DB_Project`.`SILVER_MEMBER` (`issuedate`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CardStaffID`
    FOREIGN KEY (`staffid`)
    REFERENCES `DB_Project`.`STAFF` (`staffid`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`ORDER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`ORDER` (
  `orderid` INT NOT NULL,
  `customerid` VARCHAR(4) NOT NULL,
  `ordercontents` VARCHAR(300) NOT NULL,
  `totalbalance` DOUBLE NOT NULL,
  PRIMARY KEY (`orderid`, `customerid`),
  UNIQUE INDEX `OrderID_UNIQUE` (`orderid` ASC) VISIBLE,
  INDEX `FK_CustomerID_idx` (`customerid` ASC) VISIBLE,
  CONSTRAINT `FK_OrderCustomerID`
    FOREIGN KEY (`customerid`)
    REFERENCES `DB_Project`.`CUSTOMER` (`customerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`ORDER_DELIVERY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`ORDER_DELIVERY` (
  `orderid` INT NOT NULL,
  `raddress` VARCHAR(45) NOT NULL,
  `rphone#` BIGINT NOT NULL,
  `delivererid` VARCHAR(4) NOT NULL,
  `delivererarea` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`orderid`),
  UNIQUE INDEX `OrderID_UNIQUE` (`orderid` ASC) VISIBLE,
  INDEX `FK_ODRAddress_idx` (`raddress` ASC) VISIBLE,
  INDEX `FK_ODRPhone#_idx` (`rphone#` ASC) VISIBLE,
  INDEX `FK_DelivererID_idx` (`delivererid` ASC) VISIBLE,
  INDEX `FK_DelivererArea_idx` (`delivererarea` ASC) VISIBLE,
  CONSTRAINT `FK_OrderDelieverID`
    FOREIGN KEY (`delivererid`)
    REFERENCES `DB_Project`.`DELIVERER` (`delivererid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_OrderDelivererArea`
    FOREIGN KEY (`delivererarea`)
    REFERENCES `DB_Project`.`DELIVERER` (`area`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_OrderRAddress`
    FOREIGN KEY (`raddress`)
    REFERENCES `DB_Project`.`RESTAURANT` (`address`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_OrderRPhone#`
    FOREIGN KEY (`rphone#`)
    REFERENCES `DB_Project`.`RESTAURANT` (`phone#`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`ORDINARY_CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`ORDINARY_CUSTOMER` (
  `customerid` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`customerid`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`customerid` ASC) VISIBLE,
  INDEX `PK_OCustomerID_idx` (`customerid` ASC) VISIBLE,
  CONSTRAINT `FK_OCustomerID`
    FOREIGN KEY (`customerid`)
    REFERENCES `DB_Project`.`CUSTOMER` (`customerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`PAYMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`PAYMENT` (
  `confirmation#` INT NOT NULL,
  `orderid` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `time` TIME NOT NULL,
  PRIMARY KEY (`confirmation#`, `orderid`),
  UNIQUE INDEX `Confirmation#_UNIQUE` (`confirmation#` ASC) VISIBLE,
  UNIQUE INDEX `OrderID_UNIQUE` (`orderid` ASC) VISIBLE,
  INDEX `FK_POrderID_idx` (`orderid` ASC) VISIBLE,
  CONSTRAINT `FK_POrderID`
    FOREIGN KEY (`orderid`)
    REFERENCES `DB_Project`.`ORDER` (`orderid`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`RESTAURANT_MANAGER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`RESTAURANT_MANAGER` (
  `address` VARCHAR(45) NOT NULL,
  `rmanagerid` VARCHAR(4) NOT NULL,
  `rmanagerarea` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`address`),
  UNIQUE INDEX `Address_UNIQUE` (`address` ASC) VISIBLE,
  INDEX `FK_RManagerID_idx` (`rmanagerid` ASC) VISIBLE,
  INDEX `FK_RManagerArea_idx` (`rmanagerarea` ASC) VISIBLE,
  CONSTRAINT `FK_RManagerArea`
    FOREIGN KEY (`rmanagerarea`)
    REFERENCES `DB_Project`.`AREA_MANAGER` (`area`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_RManagerID`
    FOREIGN KEY (`rmanagerid`)
    REFERENCES `DB_Project`.`AREA_MANAGER` (`managerid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`RESTAURANT_TYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`RESTAURANT_TYPE` (
  `raddress` VARCHAR(45) NOT NULL,
  `rphone#` BIGINT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`raddress`, `rphone#`, `type`),
  INDEX `PK_TypeRAddress_idx` (`raddress` ASC) VISIBLE,
  INDEX `PK_TypeRPhone#_idx` (`rphone#` ASC) VISIBLE,
  CONSTRAINT `FK_TypeRAddress`
    FOREIGN KEY (`raddress`)
    REFERENCES `DB_Project`.`RESTAURANT` (`address`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_TypeRPhone#`
    FOREIGN KEY (`rphone#`)
    REFERENCES `DB_Project`.`RESTAURANT` (`phone#`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DB_Project`.`VEHICLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`VEHICLE` (
  `plate#` VARCHAR(7) NOT NULL,
  `delivererid` VARCHAR(4) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `maker` VARCHAR(45) NOT NULL,
  `delivererarea` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`plate#`, `delivererid`),
  UNIQUE INDEX `Plate#_UNIQUE` (`plate#` ASC) VISIBLE,
  INDEX `FK_DelivererID_idx` (`delivererid` ASC) VISIBLE,
  INDEX `FK_DelivererArea_idx` (`delivererarea` ASC) VISIBLE,
  CONSTRAINT `FK_VehicleDelievererArea`
    FOREIGN KEY (`delivererarea`)
    REFERENCES `DB_Project`.`DELIVERER` (`area`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_VehicleDelievererID`
    FOREIGN KEY (`delivererid`)
    REFERENCES `DB_Project`.`DELIVERER` (`delivererid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `DB_Project` ;

-- -----------------------------------------------------
-- Placeholder table for view `DB_Project`.`annual top customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`annual top customers` (`TotalBalance` INT, `FirstName` INT, `LastName` INT);

-- -----------------------------------------------------
-- Placeholder table for view `DB_Project`.`best area manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`best area manager` (`ManagerID` INT, `FirstName` INT, `MiddleName` INT, `LastName` INT, `Gender` INT, `DOB` INT, `Address` INT, `Start_Date` INT, `Area` INT, `ContractCount` INT);

-- -----------------------------------------------------
-- Placeholder table for view `DB_Project`.`popular restaurant type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`popular restaurant type` (`Type` INT, `OrderCount` INT);

-- -----------------------------------------------------
-- Placeholder table for view `DB_Project`.`potential silver member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Project`.`potential silver member` (`CustomerID` INT, `FirstName` INT, `MiddleName` INT, `LastName` INT, `Phone#` INT, `Address` INT, `PromotionCode` INT);

-- -----------------------------------------------------
-- View `DB_Project`.`annual top customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DB_Project`.`annual top customers`;
USE `DB_Project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `db_project`.`annual top customers` AS select `db_project`.`order`.`totalbalance` AS `TotalBalance`,`db_project`.`customer`.`firstname` AS `FirstName`,`db_project`.`customer`.`lastname` AS `LastName` from (`db_project`.`order` join `db_project`.`customer`) where (`db_project`.`order`.`customerid` = `db_project`.`customer`.`customerID`) order by `db_project`.`order`.`totalbalance` desc limit 3;

-- -----------------------------------------------------
-- View `DB_Project`.`best area manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DB_Project`.`best area manager`;
USE `DB_Project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `db_project`.`best area manager` AS select distinct `A`.`managerid` AS `ManagerID`,`E`.`firstname` AS `FirstName`,`E`.`middlename` AS `MiddleName`,`E`.`lastname` AS `LastName`,`E`.`gender` AS `Gender`,`E`.`dob` AS `DOB`,`E`.`address` AS `Address`,`E`.`start_date` AS `Start_Date`,`A`.`area` AS `Area`,count(`R`.`contractissuedate`) AS `ContractCount` from (((`db_project`.`restaurant` `R` join `db_project`.`area_manager` `A`) join `db_project`.`restaurant_manager` `M`) join `db_project`.`employee` `E`) where ((`A`.`managerid` = `M`.`rmanagerid`) and (`E`.`employeeid` = `M`.`rmanagerid`)) group by `A`.`managerid`,`E`.`firstname`,`E`.`middlename`,`E`.`lastname`,`E`.`gender`,`E`.`dob`,`E`.`address`,`E`.`start_date`,`A`.`area`,`R`.`contractissuedate` order by count(`R`.`contractissuedate`) desc limit 1;

-- -----------------------------------------------------
-- View `DB_Project`.`popular restaurant type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DB_Project`.`popular restaurant type`;
USE `DB_Project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `db_project`.`popular restaurant type` AS select `T`.`type` AS `Type`,count(`D`.`raddress`) AS `OrderCount` from (((`db_project`.`restaurant_type` `T` join `db_project`.`restaurant` `R`) join `db_project`.`order` `O`) join `db_project`.`order_delivery` `D`) where ((`R`.`address` = `T`.`raddress`) and (`T`.`raddress` = `D`.`raddress`) and (`D`.`orderid` = `O`.`orderid`)) group by `T`.`type` order by count(`D`.`raddress`) desc;

-- -----------------------------------------------------
-- View `DB_Project`.`potential silver member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DB_Project`.`potential silver member`;
USE `DB_Project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `db_project`.`potential silver member` AS select `C`.`customerID` AS `CustomerID`,`C`.`firstname` AS `FirstName`,`C`.`middlename` AS `MiddleName`,`C`.`lastname` AS `LastName`,`C`.`phone#` AS `Phone#`,`C`.`address` AS `Address`,`C`.`promotioncode` AS `PromotionCode` from ((`db_project`.`ordinary_customer` `D` join `db_project`.`customer` `C`) join `db_project`.`order` `O`) where ((`D`.`customerid` = `C`.`customerID`) and (`C`.`customerID` = `O`.`customerid`)) group by `C`.`customerID`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
