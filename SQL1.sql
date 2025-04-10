-- 1. Таблица "Производство зерновых" (основная таблица с информацией о производстве)
CREATE TABLE Production (
    production_id INT AUTO_INCREMENT PRIMARY KEY,
    field_id INT NOT NULL,
    grain_type_id INT NOT NULL,
    harvest_date DATE NOT NULL,
    yield_quantity DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (field_id) REFERENCES Fields(field_id),
    FOREIGN KEY (grain_type_id) REFERENCES GrainTypes(grain_type_id)
);

-- 2. Таблица "Поля" (информация о полях)
CREATE TABLE Fields (
    field_id INT AUTO_INCREMENT PRIMARY KEY,
    field_name VARCHAR(50) NOT NULL,
    area DECIMAL(10, 2) NOT NULL,
    soil_type_id INT NOT NULL,
    FOREIGN KEY (soil_type_id) REFERENCES SoilTypes(soil_type_id)
);

-- 3. Таблица "Типы зерновых культур" (справочная таблица)
CREATE TABLE GrainTypes (
    grain_type_id INT AUTO_INCREMENT PRIMARY KEY,
    grain_name VARCHAR(50) NOT NULL UNIQUE
);

-- 4. Таблица "Типы почвы" (справочная таблица)
CREATE TABLE SoilTypes (
    soil_type_id INT AUTO_INCREMENT PRIMARY KEY,
    soil_name VARCHAR(50) NOT NULL UNIQUE
);

-- 5. Таблица "Склады" (информация о складах)
CREATE TABLE Warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(50) NOT NULL,
    capacity DECIMAL(10, 2) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- 6. Таблица "Хранилища" (информация о хранилищах внутри склада)
CREATE TABLE StorageUnits (
    storage_unit_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_id INT NOT NULL,
    storage_name VARCHAR(50) NOT NULL,
    capacity DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- 7. Таблица "Техника" (информация о технике)
CREATE TABLE Equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_name VARCHAR(50) NOT NULL,
    equipment_type_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    FOREIGN KEY (equipment_type_id) REFERENCES EquipmentTypes(equipment_type_id)
);

-- 8. Таблица "Типы техники" (справочная таблица)
CREATE TABLE EquipmentTypes (
    equipment_type_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_type_name VARCHAR(50) NOT NULL UNIQUE
);

-- 9. Таблица "Работники" (информация о сотрудниках фермы)
CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position_id INT NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (position_id) REFERENCES Positions(position_id)
);

-- 10. Таблица "Должности" (справочная таблица)
CREATE TABLE Positions (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    position_name VARCHAR(50) NOT NULL UNIQUE
);

-- Примерные дополнительные связи и индексы
-- Добавление уникального ограничения на поля, если требуется
ALTER TABLE StorageUnits ADD UNIQUE (warehouse_id, storage_name);
ALTER TABLE Fields ADD UNIQUE (field_name);

-- Опционально: индексы для ускорения запросов
CREATE INDEX idx_production_field ON Production(field_id);
CREATE INDEX idx_production_grain ON Production(grain_type_id);
CREATE INDEX idx_warehouse_location ON Warehouses(location);
