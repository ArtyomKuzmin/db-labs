-- напишите функцию, которая будет рассчитывать увеличение/уменьшение стоимость аренды объекта на последующие месяцы  для изменения (увеличения или уменьшения) 
-- срока окупаемость на заданную долю (в процентах) на основании расчета окупаемости за уже оплаченные периоды. Сохраните расчет в виде csv или sql файла (например, используя временные таблицы)


DELIMITER $$

CREATE FUNCTION calculateRentChange(facid_param INT, percentage_change DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total_revenue DECIMAL(10,2);
    DECLARE new_monthly_rent DECIMAL(10,2);
    
    -- рассчитываем общую выручку от аренды объекта
    SELECT SUM(slots * membercost) INTO total_revenue
    FROM bookings b
    JOIN facilities f ON b.facid = f.facid
    WHERE b.facid = facid_param;
    
    -- рассчитываем новую стоимость аренды для компенсации изменения срока окупаемости
    SET new_monthly_rent = (total_revenue * (1 + percentage_change / 100)) / (SELECT COUNT(DISTINCT MONTH(starttime)) FROM bookings WHERE facid = facid_param);
    
    RETURN new_monthly_rent;
END$$

DELIMITER ;

-- сохраняем расчёт в виде csv файла
SELECT facid, calculateRentChange(facid, 10) AS new_monthly_rent
FROM facilities
INTO OUTFILE '/tmp/rent_changes.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';