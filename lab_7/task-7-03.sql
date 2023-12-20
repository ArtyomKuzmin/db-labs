-- напишите процедуру, которая считает окупаемость каждого объекта клуба на основании оплаты аренд за месяц. 
-- применить ее к июлю 2012 года
USE cd;
DELIMITER $$
DROP PROCEDURE IF EXISTS getPayback $$
CREATE PROCEDURE getPayback(whichDate DATE)
    READS SQL DATA
    NOT DETERMINISTIC
BEGIN
    SELECT
        b.facid
    ,   f.facility
    ,   SUM(p.payment) - f.monthlymaintenance AS income
    FROM bookings AS b
    JOIN payments AS p ON b.bookid = p.bookid
    JOIN facilities AS f ON b.facid = f.facid
    WHERE DATE_FORMAT(starttime, '%y %m') = DATE_FORMAT(whichDate, '%y %m')
    GROUP BY b.facid
    ORDER BY b.facid;
END $$
DELIMITER ;
CALL getPayback('2012-07-03');