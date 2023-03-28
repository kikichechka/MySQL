DROP DATABASE IF EXISTS lesson5;
CREATE DATABASE IF NOT EXISTS lesson5;
USE lesson5;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    `name` VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- 1.Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов
CREATE OR REPLACE VIEW car_price AS
SELECT *
FROM cars
WHERE cost < 25000; 

SELECT *
FROM car_price;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
ALTER VIEW car_price
AS
SELECT *
FROM cars
WHERE cost < 30000;

SELECT *
FROM car_price;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE OR REPLACE VIEW car_name AS
SELECT *
FROM cars
WHERE cars.name = "Skoda" OR cars.name = "Audi";

SELECT *
FROM car_name;

-- Добавьте новый столбец под названием «время до следующей станции». 
create table data_table (
	train_id INT NOT NULL,
	station VARCHAR(20),
	station_time TIME
);

INSERT INTO data_table
VALUES
	(110, "San Francisco", '10:00:00'),
    (110, "Redwood City", '10:54:00'),
    (110, "Palo Alto", '11:02:00'),
    (110, "San Jose", '12:35:00'),
    (120, "San Francisco", '11:00:00'),
    (120, "Palo Alto", '12:49:00'),
    (120, "San Jose", '13:30:00');

SELECT *
FROM data_table;

SElECT 
    data_table.*,
    timediff(LEAD(station_time) OVER (PARTITION BY train_id), station_time) AS time_to_next_station
FROM data_table;
