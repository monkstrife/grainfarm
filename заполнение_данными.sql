-- Вставка данных в таблицы базы данных

-- Заполнение таблицы "Типы почвы"
INSERT INTO SoilTypes (soil_name) VALUES 
('Чернозем'),
('Суглинок'),
('Глина'),
('Песчаная почва'),
('Торфяная почва'),
('Щелочная почва'),
('Карбонатная почва'),
('Солонец'),
('Кислая почва'),
('Лесная почва');

-- Заполнение таблицы "Типы зерновых культур"
INSERT INTO GrainTypes (grain_name) VALUES 
('Пшеница'),
('Ячмень'),
('Рожь'),
('Овес'),
('Кукуруза'),
('Гречиха'),
('Рис'),
('Соя'),
('Просо'),
('Лён');

-- Заполнение таблицы "Поля"
INSERT INTO Fields (field_name, area, soil_type_id) VALUES 
('Поле 1', 50.00, 1),
('Поле 2', 45.00, 2),
('Поле 3', 60.00, 3),
('Поле 4', 30.00, 4),
('Поле 5', 25.00, 5),
('Поле 6', 40.00, 6),
('Поле 7', 35.00, 7),
('Поле 8', 55.00, 8),
('Поле 9', 20.00, 9),
('Поле 10', 65.00, 10);

-- Заполнение таблицы "Должности"
INSERT INTO Positions (position_name) VALUES 
('Тракторист'),
('Агроном'),
('Водитель'),
('Инженер'),
('Комбайнер'),
('Начальник');

-- Заполнение таблицы "Работники"
INSERT INTO Employees (first_name, last_name, position_id, hire_date) VALUES 
('Алексей', 'Иванов', 1, '2020-01-10'),
('Сергей', 'Петров', 2, '2019-05-15'),
('Дмитрий', 'Сидоров', 3, '2018-03-20'),
('Иван', 'Кузнецов', 6, '2021-07-12'),
('Павел', 'Морозов', 5, '2020-09-25'),
('Олег', 'Васильев', 6, '2017-12-11'),
('Виктор', 'Смирнов', 1, '2019-11-19'),
('Анна', 'Федорова', 2, '2021-03-22'),
('Мария', 'Крылова', 3, '2022-06-15'),
('Елена', 'Михайлова', 4, '2018-08-30');

-- Заполнение таблицы "Начальники"
INSERT INTO Managers (employee_id) VALUES 
(6), (4);

-- Заполнение таблицы "Склады"
INSERT INTO Warehouses (warehouse_name, location, manager_id) VALUES 
('Склад 1', 'Ростов-на-Дону', 1),
('Склад 2', 'Новочеркасск', 2);

-- Заполнение таблицы "Типы техники"
INSERT INTO EquipmentTypes (equipment_type_name) VALUES 
('Трактор'),
('Комбайн'),
('Сеялка'),
('Опрыскиватель'),
('Культиватор');

-- Заполнение таблицы "Техника"
INSERT INTO Equipment (equipment_name, equipment_type_id, purchase_date, warehouse_id) VALUES 
('Трактор МТЗ-82', 1, '2020-05-15', 1),
('Комбайн Нива СК-5', 2, '2019-07-10', 2);

-- Заполнение таблицы "Производство"
INSERT INTO Production (field_id, grain_type_id, harvest_date, yield_quantity) VALUES 
(1, 1, '2022-06-15', 100.00),
(2, 2, '2022-06-16', 80.00),
(3, 3, '2022-06-17', 90.00),
(4, 4, '2022-06-18', 70.00),
(5, 5, '2022-06-19', 85.00);

-- Заполнение таблицы "Производство и техника"
INSERT INTO ProductionEquipment (production_id, equipment_id) VALUES 
(1, 1),
(2, 2);

-- Заполнение таблицы "Работники и техника"
INSERT INTO EmployeeEquipment (employee_id, equipment_id) VALUES 
(1, 1),
(5, 2);

-- Заполнение таблицы "Хранилища"
INSERT INTO Storages (storage_name, capacity, manager_id) VALUES 
('Хранилище 1', 500.00, 1),
('Хранилище 2', 600.00, 2);

-- Заполнение таблицы "Хранилища и производство"
INSERT INTO StorageProduction (storage_id, production_id, quantity) VALUES 
(1, 1, 50.00),
(1, 2, 30.00),
(2, 3, 40.00),
(2, 4, 35.00);


SELECT GetTotalWeightByGrainType("Пшеница");

SELECT allgraintypes();

SELECT gt.grain_name, GetTotalWeightByGrainType(gt.grain_name)
FROM GrainTypes gt;

CALL AddEmployees(11,"Тест", "Аыва", 1);

CALL DelEmployees(11);

CALL AddManagers(10);

CALL DelManagers(11);

SELECT * FROM countempl;

SELECT * FROM maxempl;

CALL existsman(12);