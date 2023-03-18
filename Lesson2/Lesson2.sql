/*
-- 1. Создать БД
-- IF EXISTS - если существует 
-- IF NOT EXISTS - если НЕ существует 
DROP DATABASE IF EXISTS lesson2;  -- Удаление БД с именем lesson2, если она существует
CREATE DATABASE IF NOT EXISTS lesson2; # Создаем БД lesson2, если она не существует
-- или "CREATE SCHEMA lesson2"

-- 2. Подключиться к БД
USE lesson2;

-- 3. Создание таблицы
-- DOL: CREATE(создание), DROP(удаление), ALTER(внести изменения), RENAME(переименов), TRUNCATE(очистка табл от данных)

CREATE TABLE IF NOT EXISTS movie
(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(45) NOT NULL,
title_eng VARCHAR(45),
year_movie YEAR NOT NULL,
count_min INT NOT NULL,
storyline TEXT
);


-- 4. Заполнение таблицы данными
-- DML: INSERT(заполнение таблицы данными), DELETE(удаление), UPDATE(обновление)
INSERT movie -- заполняем абсолютно все столбцы, в том числе и id 
VALUES
	(1, "Игры Разума", "A Beautiful Mind",2001,135, "...");

INSERT movie(title,title_eng,year_movie,count_min,storyline) -- Заполняем конкретные столбцы(title,title_eng,year_movie,count_min,storyline)
VALUES
	("Игры Разума", "A Beautiful Mind",2001,135, "...");

-- SELECT* FROM movie; просмотр таблицы

INSERT INTO movie (title, title_eng, year_movie, count_min, storyline)
VALUES 
('Игры разума', 'A Beautiful Mind', 2001, 135, 'От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший. Математический гений, он на заре своей карьеры сделал титаническую работу в области теории игр, которая перевернула этот раздел математики и практически принесла ему международную известность. Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, который переворачивает уже его собственную жизнь.'),
('Форрест Гамп', 'Forrest Gump', 1994, 142, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, но в один прекрасный день Форрест открыл в себе невероятные способности к бегу. Подруга детства Дженни всегда его поддерживала и защищала, но вскоре дороги их разошлись.'),
('Иван Васильевич меняет профессию', NULL, 1998, 128,'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного. Туда-то и попадают тезка царя пенсионер-общественник Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место в двадцатом веке «переселяется» великий государь. Поломка машины приводит ко множеству неожиданных и забавных событий...'),
('Назад в будущее', 'Back to the Future', 1985, 116, 'Подросток Марти с помощью машины времени, сооружённой его другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. Там он встречается со своими будущими родителями, ещё подростками, и другом-профессором, совсем молодым.'),
('Криминальное чтиво', 'Pulp Fiction', 1994, 154, NULL);

-- SELECT* FROM movie;
RENAME TABLE movie TO cinema; -- переименовываем таблицу

SELECT* FROM cinema;

-- ALTER TABLE - добавление нового столбца и удаление
ALTER TABLE cinema
ADD test INT DEFAULT 100, -- Все значения столбца test = 100, в конец таблицы
ADD COLUMN price INT DEFAULT 200 AFTER id; -- Столбец с ценой (200р) будет находиться после столбца id

SELECT* FROM cinema;


-- Переименовать столбец test в example
ALTER TABLE cinema
CHANGE test example INT DEFAULT 100;

-- Переименовать столбец test в example
ALTER TABLE cinema
CHANGE test example INT DEFAULT 100;

-- DROP: удалить столбец
ALTER TABLE cinema
DROP example;

-- Просмотр всех столбцов в таблице
SHOW COLUMNS FROM cinema;

UPDATE cinema
SET price = price + 150 -- price = 200 + 150 => price = 350
WHERE title = 'Иван Васильевич меняет профессию' OR title = 'Игры разума';

SELECT *
FROM cinema;

ALTER TABLE cinema
ADD payment_status INT;  -- Все строчки изначально заполнены значением NULL

UPDATE cinema
SET payment_status = RAND(); -- от 0 до 1

SELECT *
FROM cinema;


SELECT id, title, payment_status, -- Перед CASE идет запятая
CASE
	WHEN payment_status = 0 THEN "заказ еще не оплачен, его нужно оплатить :)"
    WHEN payment_status = 1 THEN "заказ оплачен :)"
    ELSE "Error"
END AS result
FROM cinema;

SELECT IF (200 > 100, "200 больше, чем 100",  "200 меньше, чем 100") AS result;


SELECT 
	id AS "Номер фильма",
    title AS "Название фильма",
    count_min AS "Продолжительность" , -- Перед IF ставится  запятая :) 
	IF (count_min < 50, "короткометражка",
		IF(count_min BETWEEN 50 AND 140, "среднеметражка",
			IF(count_min >= 141 AND count_min <= 150, "полнометражка"," не пойдем на фильм , слишком долгий :)" )))
	AS "Тип фильма"
FROM cinema;
*/

USE lesson2;

CREATE TABLE sales
(
id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE NOT NULL,
count_product INT NOT NULL
);

SELECT * From sales;

INSERT sales (order_date, count_product)
VALUES 
('2022-01-01', 156),
('2022-01-01', 180),
('2022-01-01', 21),
('2022-01-01', 124),
('2022-01-01', 341);

SELECT * From sales;

SELECT id,
CASE
	WHEN count_product < 100 THEN "Маленький заказ"
    WHEN count_product BETWEEN 100 AND 300 THEN "Средний заказ"
    WHEN count_product > 300 THEN "Большой заказ"
    ELSE ""
END AS "Тип заказа"
FROM sales;

CREATE TABLE orders
(
id INT PRIMARY KEY AUTO_INCREMENT,
employee_id VARCHAR(3) NOT NULL,
amount FLOAT NOT NULL,
order_status VARCHAR(15) NOT NULL
);

INSERT orders (employee_id, amount, order_status)
VALUES 
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');

SELECT * From orders;

SELECT id, employee_id, amount, order_status,
CASE
	WHEN order_status = "OPEN" THEN "Order is in open state"
    WHEN order_status = "CLOSED" THEN "Order is closed"
    WHEN order_status = "CANCELLED" THEN "Order is cancelled"
    ELSE ""
END AS "full_order_status"
FROM orders;

SELECT * From orders;
