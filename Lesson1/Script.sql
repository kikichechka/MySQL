USE lesson1;

SELECT *
FROM mobile_phone;

SELECT name, manufacturer, price
FROM mobile_phone
WHERE quantity > 2;

SELECT *
FROM mobile_phone
WHERE manufacturer = "Samsung";