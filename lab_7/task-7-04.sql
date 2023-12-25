-- напишите функцию, которая будет рассчитывать увеличение/уменьшение стоимость аренды объекта на последующие месяцы  для изменения (увеличения или уменьшения) 
-- срока окупаемость на заданную долю (в процентах) на основании расчета окупаемости за уже оплаченные периоды. Сохраните расчет в виде csv или sql файла (например, используя временные таблицы)


CREATE FUNCTION `calculate_rental_change`(
    total_months INT,
    rental_memid INT,
    rental_facid INT,
    percentage_change DECIMAL(10,2)
) RETURNS int(11)
READS SQL DATA
BEGIN
    DECLARE total_rental_cost DECIMAL(10,2);
    SELECT SUM(slots * membercost) INTO total_rental_cost
    FROM bookings
    JOIN facilities ON bookings.facid = facilities.facid
    WHERE memid = rental_memid AND facid = rental_facid AND starttime < NOW();

    DECLARE avg_rental_cost DECIMAL(10,2);
    SET avg_rental_cost = total_rental_cost / total_months;

    DECLARE new_monthly_rental_cost DECIMAL(10,2);
    SET new_monthly_rental_cost = avg_rental_cost * (1 + (percentage_change / 100));

    CREATE TEMPORARY TABLE IF NOT EXISTS rental_change_result (
        month_num INT,
        rental_cost DECIMAL(10,2)
    ) ENGINE=MEMORY;

    DECLARE i INT DEFAULT 1;
    WHILE i <= total_months DO
        INSERT INTO rental_change_result (month_num, rental_cost) VALUES (i, new_monthly_rental_cost);
        SET i = i + 1;
    END WHILE;

    SELECT * FROM rental_change_result
    INTO OUTFILE 'rental_change_result.csv'
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

    RETURN total_months;
END