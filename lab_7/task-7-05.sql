DELIMITER $$

CREATE FUNCTION calculateRentChange(facid_param INT, percentage_change DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total_revenue DECIMAL(10,2);
    DECLARE new_monthly_rent DECIMAL(10,2);
    
    SELECT SUM(slots * membercost) INTO total_revenue
    FROM bookings b
    JOIN facilities f ON b.facid = f.facid
    WHERE b.facid = facid_param;
    
    SET new_monthly_rent = (total_revenue * (1 + percentage_change / 100)) / (SELECT COUNT(DISTINCT MONTH(starttime)) FROM bookings WHERE facid = facid_param);
    
    RETURN new_monthly_rent;
END$$

DELIMITER ;

-- изменение стоимости аренды объектов согласно расчёту функции calculateRentChange
UPDATE facilities
SET monthlymaintenance = calculateRentChange(facid, 10)
WHERE facid = facid_param;

-- отмечаем оплату всех аренд за августа 2012 года
UPDATE bookings
SET paid = TRUE
WHERE MONTH(starttime) = 8 AND YEAR(starttime) = 2012;