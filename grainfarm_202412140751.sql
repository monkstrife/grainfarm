﻿--
-- Script was generated by Devart dbForge Studio for MySQL, Version 10.0.225.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 14.12.2024 7:51:21
-- Server version: 8.0.30
--

--
-- Disable foreign keys
--
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

--
-- Set SQL mode
--
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

--
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--
USE grainfarm;

--
-- Drop view `nonmanagernonequipmentemployees`
--
DROP VIEW IF EXISTS nonmanagernonequipmentemployees CASCADE;

--
-- Drop view `uniqueequipmentemployees`
--
DROP VIEW IF EXISTS uniqueequipmentemployees CASCADE;

--
-- Drop procedure `GetEmployeesByProduct`
--
DROP PROCEDURE IF EXISTS GetEmployeesByProduct;

--
-- Drop procedure `GetUniqueEquipmentByEmployee`
--
DROP PROCEDURE IF EXISTS GetUniqueEquipmentByEmployee;

--
-- Drop table `EmployeeEquipment`
--
DROP TABLE IF EXISTS EmployeeEquipment;

--
-- Drop table `ProductionEquipment`
--
DROP TABLE IF EXISTS ProductionEquipment;

--
-- Drop procedure `GetEquipmentByType`
--
DROP PROCEDURE IF EXISTS GetEquipmentByType;

--
-- Drop procedure `GetEquipmentByWarehouse`
--
DROP PROCEDURE IF EXISTS GetEquipmentByWarehouse;

--
-- Drop table `Equipment`
--
DROP TABLE IF EXISTS Equipment;

--
-- Drop view `allequipmenttypes`
--
DROP VIEW IF EXISTS allequipmenttypes CASCADE;

--
-- Drop table `EquipmentTypes`
--
DROP TABLE IF EXISTS EquipmentTypes;

--
-- Drop function `GetRemainingCapacity`
--
DROP FUNCTION IF EXISTS GetRemainingCapacity;

--
-- Drop view `viewforgraf`
--
DROP VIEW IF EXISTS viewforgraf CASCADE;

--
-- Drop function `GetTotalWeightByGrainType`
--
DROP FUNCTION IF EXISTS GetTotalWeightByGrainType;

--
-- Drop function `GetUnallocatedProduct`
--
DROP FUNCTION IF EXISTS GetUnallocatedProduct;

--
-- Drop table `StorageProduction`
--
DROP TABLE IF EXISTS StorageProduction;

--
-- Drop procedure `GetTotalProductionByType`
--
DROP PROCEDURE IF EXISTS GetTotalProductionByType;

--
-- Drop table `Production`
--
DROP TABLE IF EXISTS Production;

--
-- Drop view `allgraintypes`
--
DROP VIEW IF EXISTS allgraintypes CASCADE;

--
-- Drop table `GrainTypes`
--
DROP TABLE IF EXISTS GrainTypes;

--
-- Drop view `allfields`
--
DROP VIEW IF EXISTS allfields CASCADE;

--
-- Drop procedure `GetFieldsBySoilType`
--
DROP PROCEDURE IF EXISTS GetFieldsBySoilType;

--
-- Drop table `Fields`
--
DROP TABLE IF EXISTS Fields;

--
-- Drop view `allsoiltypes`
--
DROP VIEW IF EXISTS allsoiltypes CASCADE;

--
-- Drop table `SoilTypes`
--
DROP TABLE IF EXISTS SoilTypes;

--
-- Drop view `storagemanagers`
--
DROP VIEW IF EXISTS storagemanagers CASCADE;

--
-- Drop table `Storages`
--
DROP TABLE IF EXISTS Storages;

--
-- Drop view `warehousemanagers`
--
DROP VIEW IF EXISTS warehousemanagers CASCADE;

--
-- Drop table `Warehouses`
--
DROP TABLE IF EXISTS Warehouses;

--
-- Drop view `countman`
--
DROP VIEW IF EXISTS countman CASCADE;

--
-- Drop view `maxman`
--
DROP VIEW IF EXISTS maxman CASCADE;

--
-- Drop procedure `AddManagers`
--
DROP PROCEDURE IF EXISTS AddManagers;

--
-- Drop procedure `DelManagers`
--
DROP PROCEDURE IF EXISTS DelManagers;

--
-- Drop procedure `ExistsMan`
--
DROP PROCEDURE IF EXISTS ExistsMan;

--
-- Drop table `Managers`
--
DROP TABLE IF EXISTS Managers;

--
-- Drop view `countempl`
--
DROP VIEW IF EXISTS countempl CASCADE;

--
-- Drop view `maxempl`
--
DROP VIEW IF EXISTS maxempl CASCADE;

--
-- Drop procedure `AddEmployees`
--
DROP PROCEDURE IF EXISTS AddEmployees;

--
-- Drop procedure `DelEmployees`
--
DROP PROCEDURE IF EXISTS DelEmployees;

--
-- Drop procedure `GetEmployeesByPosition`
--
DROP PROCEDURE IF EXISTS GetEmployeesByPosition;

--
-- Drop table `Employees`
--
DROP TABLE IF EXISTS Employees;

--
-- Drop view `allposition`
--
DROP VIEW IF EXISTS allposition CASCADE;

--
-- Drop table `Positions`
--
DROP TABLE IF EXISTS Positions;

--
-- Set default database
--
USE grainfarm;

--
-- Create table `Positions`
--
CREATE TABLE Positions (
  position_id int NOT NULL AUTO_INCREMENT,
  position_name varchar(50) NOT NULL,
  PRIMARY KEY (position_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 7,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Должности" (справочная таблица)',
ROW_FORMAT = DYNAMIC;

--
-- Create index `position_name` on table `Positions`
--
ALTER TABLE Positions
ADD UNIQUE INDEX position_name (position_name);

--
-- Create view `allposition`
--
CREATE
DEFINER = 'root'@'%'
VIEW allposition
AS
SELECT
  `p`.`position_id` AS `position_id`,
  `p`.`position_name` AS `position_name`
FROM `positions` `p`;

--
-- Create table `Employees`
--
CREATE TABLE Employees (
  employee_id int NOT NULL AUTO_INCREMENT,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL,
  position_id int NOT NULL,
  hire_date date NOT NULL,
  PRIMARY KEY (employee_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 15,
AVG_ROW_LENGTH = 1638,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Работники" (информация о сотрудниках фермы)',
ROW_FORMAT = DYNAMIC;

--
-- Create foreign key
--
ALTER TABLE Employees
ADD CONSTRAINT employees_ibfk_1 FOREIGN KEY (position_id)
REFERENCES Positions (position_id);

DELIMITER $$

--
-- Create procedure `GetEmployeesByPosition`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE GetEmployeesByPosition (IN positionName varchar(50))
COMMENT 'Все работники по должности'
BEGIN
  SELECT
    e.employee_id,
    e.first_name,
    e.last_name
  FROM Employees e
    JOIN Positions p
      ON e.position_id = p.position_id
  WHERE p.position_name = positionName;
END
$$

--
-- Create procedure `DelEmployees`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE DelEmployees (IN id int)
BEGIN
  DELETE
    FROM Employees
  WHERE employee_id = id;
END
$$

--
-- Create procedure `AddEmployees`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE AddEmployees (IN id int, IN fn varchar(50), IN ln varchar(50), IN pos int)
BEGIN
  INSERT INTO Employees (employee_id, first_name, last_name, position_id, hire_date)
    VALUES (id, fn, ln, pos, NOW());
END
$$

DELIMITER ;

--
-- Create view `maxempl`
--
CREATE
DEFINER = 'root'@'%'
VIEW maxempl
AS
SELECT
  MAX(`e`.`employee_id`) AS `MAX(e.employee_id)`
FROM `employees` `e`;

--
-- Create view `countempl`
--
CREATE
DEFINER = 'root'@'%'
VIEW countempl
AS
SELECT
  COUNT(0) AS `COUNT(*)`
FROM `employees` `e`;

--
-- Create table `Managers`
--
CREATE TABLE Managers (
  manager_id int NOT NULL AUTO_INCREMENT,
  employee_id int NOT NULL,
  PRIMARY KEY (manager_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Начальники" (выбор начальников из числа работников)',
ROW_FORMAT = DYNAMIC;

--
-- Create index `employee_id` on table `Managers`
--
ALTER TABLE Managers
ADD UNIQUE INDEX employee_id (employee_id);

--
-- Create foreign key
--
ALTER TABLE Managers
ADD CONSTRAINT managers_ibfk_1 FOREIGN KEY (employee_id)
REFERENCES Employees (employee_id);

DELIMITER $$

--
-- Create procedure `ExistsMan`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE ExistsMan (IN id int)
BEGIN
  SELECT
    EXISTS (SELECT
        id
      FROM Managers m
      WHERE id = m.employee_id);
END
$$

--
-- Create procedure `DelManagers`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE DelManagers (IN id int)
BEGIN
  DELETE
    FROM Managers
  WHERE employee_id = id;
END
$$

--
-- Create procedure `AddManagers`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE AddManagers (IN id_m int, IN id int)
BEGIN
  INSERT INTO Managers (manager_id, employee_id)
    VALUES (id_m, id);
END
$$

DELIMITER ;

--
-- Create view `maxman`
--
CREATE
DEFINER = 'root'@'%'
VIEW maxman
AS
SELECT
  MAX(`m`.`manager_id`) AS `MAX(m.manager_id)`
FROM `managers` `m`;

--
-- Create view `countman`
--
CREATE
DEFINER = 'root'@'%'
VIEW countman
AS
SELECT
  COUNT(0) AS `COUNT(*)`
FROM `managers` `m`;

--
-- Create table `Warehouses`
--
CREATE TABLE Warehouses (
  warehouse_id int NOT NULL AUTO_INCREMENT,
  warehouse_name varchar(50) NOT NULL,
  location varchar(100) NOT NULL,
  manager_id int NOT NULL,
  PRIMARY KEY (warehouse_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Склады" (информация о местах хранения техники)',
ROW_FORMAT = DYNAMIC;

--
-- Create foreign key
--
ALTER TABLE Warehouses
ADD CONSTRAINT warehouses_ibfk_1 FOREIGN KEY (manager_id)
REFERENCES Managers (manager_id);

--
-- Create view `warehousemanagers`
--
CREATE
DEFINER = 'root'@'%'
VIEW warehousemanagers
AS
SELECT
  `w`.`warehouse_id` AS `warehouse_id`,
  `w`.`warehouse_name` AS `warehouse_name`,
  `e`.`first_name` AS `first_name`,
  `e`.`last_name` AS `last_name`,
  `e`.`position_id` AS `position_id`
FROM ((`warehouses` `w`
  JOIN `managers` `m`
    ON ((`w`.`manager_id` = `m`.`manager_id`)))
  JOIN `employees` `e`
    ON ((`m`.`employee_id` = `e`.`employee_id`)));

--
-- Create table `Storages`
--
CREATE TABLE Storages (
  storage_id int NOT NULL AUTO_INCREMENT,
  storage_name varchar(50) NOT NULL,
  capacity decimal(10, 2) NOT NULL,
  manager_id int NOT NULL,
  PRIMARY KEY (storage_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Хранилища" (информация о хранилищах)',
ROW_FORMAT = DYNAMIC;

--
-- Create foreign key
--
ALTER TABLE Storages
ADD CONSTRAINT storages_ibfk_1 FOREIGN KEY (manager_id)
REFERENCES Managers (manager_id);

--
-- Create view `storagemanagers`
--
CREATE
DEFINER = 'root'@'%'
VIEW storagemanagers
AS
SELECT
  `s`.`storage_id` AS `storage_id`,
  `s`.`storage_name` AS `storage_name`,
  `e`.`first_name` AS `first_name`,
  `e`.`last_name` AS `last_name`,
  `e`.`position_id` AS `position_id`
FROM ((`storages` `s`
  JOIN `managers` `m`
    ON ((`s`.`manager_id` = `m`.`manager_id`)))
  JOIN `employees` `e`
    ON ((`m`.`employee_id` = `e`.`employee_id`)));

--
-- Create table `SoilTypes`
--
CREATE TABLE SoilTypes (
  soil_type_id int NOT NULL AUTO_INCREMENT,
  soil_name varchar(50) NOT NULL,
  PRIMARY KEY (soil_type_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 11,
AVG_ROW_LENGTH = 1638,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Типы почвы" (справочная таблица)',
ROW_FORMAT = DYNAMIC;

--
-- Create index `soil_name` on table `SoilTypes`
--
ALTER TABLE SoilTypes
ADD UNIQUE INDEX soil_name (soil_name);

--
-- Create view `allsoiltypes`
--
CREATE
DEFINER = 'root'@'%'
VIEW allsoiltypes
AS
SELECT
  `st`.`soil_type_id` AS `soil_type_id`,
  `st`.`soil_name` AS `soil_name`
FROM `soiltypes` `st`;

--
-- Create table `Fields`
--
CREATE TABLE Fields (
  field_id int NOT NULL AUTO_INCREMENT,
  field_name varchar(50) NOT NULL,
  area decimal(10, 2) NOT NULL,
  soil_type_id int NOT NULL,
  PRIMARY KEY (field_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 11,
AVG_ROW_LENGTH = 1638,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Поля" (информация о полях)',
ROW_FORMAT = DYNAMIC;

--
-- Create foreign key
--
ALTER TABLE Fields
ADD CONSTRAINT fields_ibfk_1 FOREIGN KEY (soil_type_id)
REFERENCES SoilTypes (soil_type_id);

DELIMITER $$

--
-- Create procedure `GetFieldsBySoilType`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE GetFieldsBySoilType (IN soilName varchar(50))
COMMENT 'Все поля по типу почвы'
BEGIN
  SELECT
    f.field_id,
    f.field_name,
    f.area
  FROM Fields f
    JOIN SoilTypes st
      ON f.soil_type_id = st.soil_type_id
  WHERE st.soil_name = soilName;
END
$$

DELIMITER ;

--
-- Create view `allfields`
--
CREATE
DEFINER = 'root'@'%'
VIEW allfields
AS
SELECT
  `f`.`field_id` AS `field_id`,
  `f`.`field_name` AS `field_name`,
  `f`.`area` AS `area`,
  `st`.`soil_name` AS `soil_name`
FROM (`fields` `f`
  JOIN `soiltypes` `st`
    ON ((`f`.`soil_type_id` = `st`.`soil_type_id`)));

--
-- Create table `GrainTypes`
--
CREATE TABLE GrainTypes (
  grain_type_id int NOT NULL AUTO_INCREMENT,
  grain_name varchar(50) NOT NULL,
  PRIMARY KEY (grain_type_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 11,
AVG_ROW_LENGTH = 1638,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Типы зерновых культур" (справочная таблица)',
ROW_FORMAT = DYNAMIC;

--
-- Create index `grain_name` on table `GrainTypes`
--
ALTER TABLE GrainTypes
ADD UNIQUE INDEX grain_name (grain_name);

--
-- Create view `allgraintypes`
--
CREATE
DEFINER = 'root'@'%'
VIEW allgraintypes
AS
SELECT
  `g`.`grain_type_id` AS `grain_type_id`,
  `g`.`grain_name` AS `grain_name`
FROM `graintypes` `g`;

--
-- Create table `Production`
--
CREATE TABLE Production (
  production_id int NOT NULL AUTO_INCREMENT,
  field_id int NOT NULL,
  grain_type_id int NOT NULL,
  harvest_date date NOT NULL,
  yield_quantity decimal(10, 2) NOT NULL,
  PRIMARY KEY (production_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
AVG_ROW_LENGTH = 3276,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Производство зерновых" (основная таблица с информацией о производстве)',
ROW_FORMAT = DYNAMIC;

--
-- Create foreign key
--
ALTER TABLE Production
ADD CONSTRAINT production_ibfk_1 FOREIGN KEY (field_id)
REFERENCES Fields (field_id);

--
-- Create foreign key
--
ALTER TABLE Production
ADD CONSTRAINT production_ibfk_2 FOREIGN KEY (grain_type_id)
REFERENCES GrainTypes (grain_type_id);

DELIMITER $$

--
-- Create procedure `GetTotalProductionByType`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE GetTotalProductionByType (IN grainTypeName varchar(50), IN startDate date, IN endDate date)
COMMENT 'Производство за период по типу зерновых'
BEGIN
  SELECT
    SUM(p.yield_quantity) AS total_production
  FROM Production p
    JOIN GrainTypes g
      ON p.grain_type_id = g.grain_type_id
  WHERE g.grain_name = grainTypeName
  AND p.harvest_date BETWEEN startDate AND endDate;
END
$$

DELIMITER ;

--
-- Create table `StorageProduction`
--
CREATE TABLE StorageProduction (
  id int NOT NULL AUTO_INCREMENT,
  storage_id int NOT NULL,
  production_id int NOT NULL,
  quantity decimal(10, 2) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 5,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Хранилища и производство" (связь между хранилищами и производством)',
ROW_FORMAT = DYNAMIC;

--
-- Create index `storage_id` on table `StorageProduction`
--
ALTER TABLE StorageProduction
ADD UNIQUE INDEX storage_id (storage_id, production_id);

--
-- Create foreign key
--
ALTER TABLE StorageProduction
ADD CONSTRAINT storageproduction_ibfk_1 FOREIGN KEY (storage_id)
REFERENCES Storages (storage_id);

--
-- Create foreign key
--
ALTER TABLE StorageProduction
ADD CONSTRAINT storageproduction_ibfk_2 FOREIGN KEY (production_id)
REFERENCES Production (production_id);

DELIMITER $$

--
-- Create function `GetUnallocatedProduct`
--
CREATE
DEFINER = 'root'@'%'
FUNCTION GetUnallocatedProduct (productionID int)
RETURNS decimal(10, 2)
COMMENT 'Неразмещенный продукт'
BEGIN
  DECLARE allocatedQuantity decimal(10, 2);
  SELECT
    COALESCE(SUM(quantity), 0) INTO allocatedQuantity
  FROM StorageProduction
  WHERE production_id = productionID;
  RETURN (SELECT
      yield_quantity - allocatedQuantity
    FROM Production
    WHERE production_id = productionID);
END
$$

--
-- Create function `GetTotalWeightByGrainType`
--
CREATE
DEFINER = 'root'@'%'
FUNCTION GetTotalWeightByGrainType (grainTypeName varchar(50))
RETURNS decimal(10, 2)
BEGIN
  DECLARE totalWeight decimal(10, 2);
  SELECT
    COALESCE(SUM(sp.quantity), 0) INTO totalWeight
  FROM StorageProduction sp
    JOIN Production p
      ON sp.production_id = p.production_id
    JOIN GrainTypes g
      ON p.grain_type_id = g.grain_type_id
  WHERE g.grain_name = grainTypeName;
  RETURN totalWeight;
END
$$

DELIMITER ;

--
-- Create view `viewforgraf`
--
CREATE
DEFINER = 'root'@'%'
VIEW viewforgraf
AS
SELECT
  `gt`.`grain_type_id` AS `grain_id`,
  `gt`.`grain_name` AS `grain_name`,
  `GetTotalWeightByGrainType`(`gt`.`grain_name`) AS `sum`
FROM `graintypes` `gt`;

DELIMITER $$

--
-- Create function `GetRemainingCapacity`
--
CREATE
DEFINER = 'root'@'%'
FUNCTION GetRemainingCapacity (storageID int)
RETURNS decimal(10, 2)
COMMENT 'Оставшаяся вместимость хранилища'
BEGIN
  DECLARE usedCapacity decimal(10, 2);
  SELECT
    COALESCE(SUM(quantity), 0) INTO usedCapacity
  FROM StorageProduction
  WHERE storage_id = storageID;
  RETURN (SELECT
      capacity - usedCapacity
    FROM Storages
    WHERE storage_id = storageID);
END
$$

DELIMITER ;

--
-- Create table `EquipmentTypes`
--
CREATE TABLE EquipmentTypes (
  equipment_type_id int NOT NULL AUTO_INCREMENT,
  equipment_type_name varchar(50) NOT NULL,
  PRIMARY KEY (equipment_type_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
AVG_ROW_LENGTH = 3276,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Типы техники" (справочная таблица)',
ROW_FORMAT = DYNAMIC;

--
-- Create index `equipment_type_name` on table `EquipmentTypes`
--
ALTER TABLE EquipmentTypes
ADD UNIQUE INDEX equipment_type_name (equipment_type_name);

--
-- Create view `allequipmenttypes`
--
CREATE
DEFINER = 'root'@'%'
VIEW allequipmenttypes
AS
SELECT
  `et`.`equipment_type_id` AS `equipment_type_id`,
  `et`.`equipment_type_name` AS `equipment_type_name`
FROM `equipmenttypes` `et`;

--
-- Create table `Equipment`
--
CREATE TABLE Equipment (
  equipment_id int NOT NULL AUTO_INCREMENT,
  equipment_name varchar(50) NOT NULL,
  equipment_type_id int NOT NULL,
  purchase_date date NOT NULL,
  warehouse_id int NOT NULL,
  PRIMARY KEY (equipment_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Техника" (информация о технике)',
ROW_FORMAT = DYNAMIC;

--
-- Create foreign key
--
ALTER TABLE Equipment
ADD CONSTRAINT equipment_ibfk_1 FOREIGN KEY (equipment_type_id)
REFERENCES EquipmentTypes (equipment_type_id);

--
-- Create foreign key
--
ALTER TABLE Equipment
ADD CONSTRAINT equipment_ibfk_2 FOREIGN KEY (warehouse_id)
REFERENCES Warehouses (warehouse_id);

DELIMITER $$

--
-- Create procedure `GetEquipmentByWarehouse`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE GetEquipmentByWarehouse (IN warehouseName varchar(50))
COMMENT 'Вся техника по складу'
BEGIN
  SELECT
    eq.equipment_id,
    eq.equipment_name,
    eq.purchase_date
  FROM Equipment eq
    JOIN Warehouses w
      ON eq.warehouse_id = w.warehouse_id
  WHERE w.warehouse_name = warehouseName;
END
$$

--
-- Create procedure `GetEquipmentByType`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE GetEquipmentByType (IN equipmentTypeName varchar(50))
COMMENT 'Вся техника по типу'
BEGIN
  SELECT
    eq.equipment_id,
    eq.equipment_name,
    eq.purchase_date
  FROM Equipment eq
    JOIN EquipmentTypes et
      ON eq.equipment_type_id = et.equipment_type_id
  WHERE et.equipment_type_name = equipmentTypeName;
END
$$

DELIMITER ;

--
-- Create table `ProductionEquipment`
--
CREATE TABLE ProductionEquipment (
  id int NOT NULL AUTO_INCREMENT,
  production_id int NOT NULL,
  equipment_id int NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Производство и техника" (связь между производством и техникой)',
ROW_FORMAT = DYNAMIC;

--
-- Create index `production_id` on table `ProductionEquipment`
--
ALTER TABLE ProductionEquipment
ADD UNIQUE INDEX production_id (production_id, equipment_id);

--
-- Create foreign key
--
ALTER TABLE ProductionEquipment
ADD CONSTRAINT productionequipment_ibfk_1 FOREIGN KEY (production_id)
REFERENCES Production (production_id);

--
-- Create foreign key
--
ALTER TABLE ProductionEquipment
ADD CONSTRAINT productionequipment_ibfk_2 FOREIGN KEY (equipment_id)
REFERENCES Equipment (equipment_id);

--
-- Create table `EmployeeEquipment`
--
CREATE TABLE EmployeeEquipment (
  id int NOT NULL AUTO_INCREMENT,
  employee_id int NOT NULL,
  equipment_id int NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица "Работники и техника" (связь между работниками и техникой)',
ROW_FORMAT = DYNAMIC;

--
-- Create index `employee_id` on table `EmployeeEquipment`
--
ALTER TABLE EmployeeEquipment
ADD UNIQUE INDEX employee_id (employee_id, equipment_id);

--
-- Create foreign key
--
ALTER TABLE EmployeeEquipment
ADD CONSTRAINT employeeequipment_ibfk_1 FOREIGN KEY (employee_id)
REFERENCES Employees (employee_id);

--
-- Create foreign key
--
ALTER TABLE EmployeeEquipment
ADD CONSTRAINT employeeequipment_ibfk_2 FOREIGN KEY (equipment_id)
REFERENCES Equipment (equipment_id);

DELIMITER $$

--
-- Create procedure `GetUniqueEquipmentByEmployee`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE GetUniqueEquipmentByEmployee (IN employeeID int)
COMMENT 'Уникальная техника по работнику'
BEGIN
  SELECT DISTINCT
    eq.equipment_id,
    eq.equipment_name,
    eq.purchase_date
  FROM EmployeeEquipment ee
    JOIN Equipment eq
      ON ee.equipment_id = eq.equipment_id
  WHERE ee.employee_id = employeeID;
END
$$

--
-- Create procedure `GetEmployeesByProduct`
--
CREATE
DEFINER = 'root'@'%'
PROCEDURE GetEmployeesByProduct (IN productionID int)
COMMENT 'Работники по продукту'
BEGIN
  SELECT DISTINCT
    e.employee_id,
    e.first_name,
    e.last_name
  FROM ProductionEquipment pe
    JOIN EmployeeEquipment ee
      ON pe.equipment_id = ee.equipment_id
    JOIN Employees e
      ON ee.employee_id = e.employee_id
  WHERE pe.production_id = productionID;
END
$$

DELIMITER ;

--
-- Create view `uniqueequipmentemployees`
--
CREATE
DEFINER = 'root'@'%'
VIEW uniqueequipmentemployees
AS
SELECT DISTINCT
  `e`.`employee_id` AS `employee_id`,
  `e`.`first_name` AS `first_name`,
  `e`.`last_name` AS `last_name`
FROM (`employeeequipment` `ee`
  JOIN `employees` `e`
    ON ((`ee`.`employee_id` = `e`.`employee_id`)));

--
-- Create view `nonmanagernonequipmentemployees`
--
CREATE
DEFINER = 'root'@'%'
VIEW nonmanagernonequipmentemployees
AS
SELECT
  `e`.`employee_id` AS `employee_id`,
  `e`.`first_name` AS `first_name`,
  `e`.`last_name` AS `last_name`
FROM ((`employees` `e`
  LEFT JOIN `managers` `m`
    ON ((`e`.`employee_id` = `m`.`employee_id`)))
  LEFT JOIN `employeeequipment` `ee`
    ON ((`e`.`employee_id` = `ee`.`employee_id`)))
WHERE ((`m`.`manager_id` IS NULL)
AND (`ee`.`id` IS NULL));

-- 
-- Dumping data for table Positions
--
INSERT INTO Positions VALUES
(2, 'Агроном'),
(3, 'Водитель'),
(4, 'Инженер'),
(5, 'Комбайнер'),
(6, 'Начальник'),
(1, 'Тракторист');

-- 
-- Dumping data for table Employees
--
INSERT INTO Employees VALUES
(1, 'Алексей', 'Иванов', 1, '2020-01-10'),
(2, 'Сергей', 'Петров', 2, '2019-05-15'),
(3, 'Дмитрий', 'Сидоров', 3, '2018-03-20'),
(4, 'Иван', 'Кузнецов', 6, '2021-07-12'),
(5, 'Павел', 'Морозов', 5, '2020-09-25'),
(6, 'Олег', 'Васильев', 6, '2017-12-11'),
(7, 'Виктор', 'Смирнов', 1, '2019-11-19'),
(8, 'Анна', 'Федорова', 2, '2021-03-22'),
(9, 'Мария', 'Крылова', 3, '2022-06-15'),
(10, 'Елена', 'Михайлова', 4, '2018-08-30');

-- 
-- Dumping data for table SoilTypes
--
INSERT INTO SoilTypes VALUES
(3, 'Глина'),
(7, 'Карбонатная почва'),
(9, 'Кислая почва'),
(10, 'Лесная почва'),
(4, 'Песчаная почва'),
(8, 'Солонец'),
(2, 'Суглинок'),
(5, 'Торфяная почва'),
(1, 'Чернозем'),
(6, 'Щелочная почва');

-- 
-- Dumping data for table Managers
--
INSERT INTO Managers VALUES
(2, 4),
(1, 6);

-- 
-- Dumping data for table GrainTypes
--
INSERT INTO GrainTypes VALUES
(6, 'Гречиха'),
(5, 'Кукуруза'),
(10, 'Лён'),
(4, 'Овес'),
(9, 'Просо'),
(1, 'Пшеница'),
(7, 'Рис'),
(3, 'Рожь'),
(8, 'Соя'),
(2, 'Ячмень');

-- 
-- Dumping data for table Fields
--
INSERT INTO Fields VALUES
(1, 'Поле 1', 50.00, 1),
(2, 'Поле 2', 45.00, 2),
(3, 'Поле 3', 60.00, 3),
(4, 'Поле 4', 30.00, 4),
(5, 'Поле 5', 25.00, 5),
(6, 'Поле 6', 40.00, 6),
(7, 'Поле 7', 35.00, 7),
(8, 'Поле 8', 55.00, 8),
(9, 'Поле 9', 20.00, 9),
(10, 'Поле 10', 65.00, 10);

-- 
-- Dumping data for table Warehouses
--
INSERT INTO Warehouses VALUES
(1, 'Склад 1', 'Ростов-на-Дону', 1),
(2, 'Склад 2', 'Новочеркасск', 2);

-- 
-- Dumping data for table EquipmentTypes
--
INSERT INTO EquipmentTypes VALUES
(2, 'Комбайн'),
(5, 'Культиватор'),
(4, 'Опрыскиватель'),
(3, 'Сеялка'),
(1, 'Трактор');

-- 
-- Dumping data for table Storages
--
INSERT INTO Storages VALUES
(1, 'Хранилище 1', 500.00, 1),
(2, 'Хранилище 2', 600.00, 2);

-- 
-- Dumping data for table Production
--
INSERT INTO Production VALUES
(1, 1, 1, '2022-06-15', 100.00),
(2, 2, 2, '2022-06-16', 80.00),
(3, 3, 3, '2022-06-17', 90.00),
(4, 4, 4, '2022-06-18', 70.00),
(5, 5, 5, '2022-06-19', 85.00);

-- 
-- Dumping data for table Equipment
--
INSERT INTO Equipment VALUES
(1, 'Трактор МТЗ-82', 1, '2020-05-15', 1),
(2, 'Комбайн Нива СК-5', 2, '2019-07-10', 2);

-- 
-- Dumping data for table StorageProduction
--
INSERT INTO StorageProduction VALUES
(1, 1, 1, 50.00),
(2, 1, 2, 30.00),
(3, 2, 3, 40.00),
(4, 2, 4, 35.00);

-- 
-- Dumping data for table ProductionEquipment
--
INSERT INTO ProductionEquipment VALUES
(1, 1, 1),
(2, 2, 2);

-- 
-- Dumping data for table EmployeeEquipment
--
INSERT INTO EmployeeEquipment VALUES
(1, 1, 1),
(2, 5, 2);

--
-- Restore previous SQL mode
--
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

--
-- Enable foreign keys
--
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;