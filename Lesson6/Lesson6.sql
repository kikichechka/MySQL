DROP DATABASE IF EXISTS lesson6;
 
CREATE DATABASE lesson6;
USE lesson6;


-- 1. Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds'
DROP PROCEDURE IF EXISTS seconds_converter;
DELIMITER //
CREATE PROCEDURE seconds_converter
(
	IN input_seconds INT,
    OUT converter_date VARCHAR(100)
)

BEGIN
	DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    DECLARE seconds INT DEFAULT 0;
    SET converter_date = "";     
    
    If input_seconds >= 86400 THEN
		SET days = FLOOR(input_seconds / 86400);
        SET input_seconds = input_seconds - 86400 * days;
	END IF;
    
    If input_seconds >= 3600 THEN
		SET hours = FLOOR(input_seconds / 3600);
        SET input_seconds = input_seconds - 3600 * hours;
    END IF;    
    
    If input_seconds >= 60 THEN
		SET minutes = FLOOR(input_seconds / 60);
        SET input_seconds = input_seconds - 60 * minutes;
	END IF;
    
    If input_seconds < 60 AND input_seconds > 0 THEN
        SET seconds = input_seconds;
	END IF;
    
    SET converter_date = CONCAT(days, " days ", hours, " hours ", minutes, " minutes ", seconds, " seconds"); -- 1 days 10 hours 17 minutes 36 seconds
END//

CALL seconds_converter(123456, @dates);
SELECT @dates;


-- 2. Выведите только четные числа от 1 до 10 включительно. (Через функцию / процедуру)
-- Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)
DROP PROCEDURE IF EXISTS print_numbers;
DELIMITER //
CREATE PROCEDURE print_numbers 
(
	IN input_numbers INT
)
BEGIN
	DECLARE n INT DEFAULT 0;
    DECLARE result VARCHAR(45) DEFAULT "";
    
    REPEAT
        SET n = n + 2;
        IF n < input_numbers THEN
		    SET result = CONCAT(result, n, ",");
	    ELSE
		    SET result = CONCAT(result, n);
	    END IF;
        UNTIL n >= input_numbers
	END REPEAT;
    
    SELECT result;
END //
CALL print_numbers(10);