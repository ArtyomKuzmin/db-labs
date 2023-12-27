-- напишите процедуру, которая считает окупаемость каждого объекта клуба на основании оплаты аренд за месяц. 
-- применить ее к июлю 2012 года

USE cd;

DELIMITER $$

DROP PROCEDURE IF EXISTS recoupment $$
CREATE PROCEDURE recoupment(facid INT, m INT, y INT)
    READS SQL DATA
    NOT DETERMINISTIC
BEGIN
    SELECT b.facid, f.facility, IF(SUM(p.payment) = f.monthlymaintenance, 
	1e300, f.initialoutlay / (SUM(p.payment) - f.monthlymaintenance)) AS payback_period
    FROM bookings b
    INNER JOIN payments p ON b.bookid = p.bookid
	INNER JOIN facilities f ON b.facid = f.facid
    WHERE facid = b.facid AND MONTH(b.starttime) = m AND YEAR(b.starttime) = y
    GROUP BY b.facid
    ORDER BY b.facid;
END $$

CALL recoupment(1, MONTH('2012-07-03'), YEAR('2012-07-03'));