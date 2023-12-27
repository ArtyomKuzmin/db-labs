-- напишите функцию, которая будет рассчитывать увеличение/уменьшение стоимость аренды объекта на последующие месяцы  для изменения (увеличения или уменьшения) 
-- срока окупаемость на заданную долю (в процентах) на основании расчета окупаемости за уже оплаченные периоды. Сохраните расчет в виде csv или sql файла (например, используя временные таблицы)

USE cd;

DELIMITER &&

CREATE FUNCTION paybackPeriod(facid INT, part FLOAT, 
duration TIMESTAMP)
    RETURNS DECIMAL(10, 2)
    READS SQL DATA
    NOT DETERMINISTIC
BEGIN
    DECLARE revenue DECIMAL(10, 2);
    DECLARE service DECIMAL(10, 2);
    DECLARE profit DECIMAL(10, 2);
    DECLARE expenses DECIMAL(10, 2);
    SELECT SUM(p.payment) INTO revenue
    FROM payments AS p
    JOIN bookings AS b ON b.bookid = p.bookid
    JOIN facilities AS f ON b.facid = f.facid
    WHERE facid = b.facid AND b.starttime <= duration
    GROUP BY b.facid;
    IF revenue IS NULL THEN
        RETURN 1;
    END IF;
    SELECT f.monthlyservice * (MONTH(duration) - 
    MONTH(MIN(b.starttime)) + 1) INTO service
    FROM facilities AS f
    JOIN bookings AS b ON b.facid = f.facid
    WHERE facid = b.facid
    GROUP BY b.facid;
    SELECT f.initialoutlay INTO expenses
    FROM facilities AS f
    WHERE facid = f.facid
    LIMIT 1;
    SET profit = (revenue - service);
    IF profit <= 0 OR expenses <= profit THEN
        RETURN 1;
    END IF;
    RETURN ((1 / part) * (expenses - profit) / expenses * (1 - 
    service / revenue) + service / revenue);
END &&

DELIMITER ;

SELECT paybackPeriod(2, 2, '2012-07-31-23:59:59')
INTO OUTFILE 'rental_change_result.csv' 
    FIELDS ENCLOSED BY '"' TERMINATED BY ';' ESCAPED BY '"' 
    LINES TERMINATED BY '\r\n';