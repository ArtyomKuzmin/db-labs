-- Для каждого дня августа 2012 года рассчитайте скользящее среднее общего дохода за предыдущие 15 дней. 
-- Вывод должен содержать столбцы даты и дохода, отсортированные по дате. Не забудьте учесть возможность того, что в день будет нулевой доход.
USE cd;
WITH RECURSIVE DateRange AS (
    SELECT '2012-08-01' AS Date
    UNION ALL
    SELECT DATE_ADD(Date, INTERVAL 1 DAY)
    FROM DateRange
    WHERE Date < '2012-08-31'
),
TotalRevenue AS (
    SELECT DateRange.Date,
    Coalesce(SUM(IF(b.memid = 0, f.guestcost * b.slots, f.membercost * b.slots)), 0) as total_revenue
    FROM DateRange
    LEFT JOIN bookings b ON DATE(b.starttime) = Date
    LEFT JOIN facilities f ON b.facid = f.facid
    GROUP BY Date
),
MovingAverageRevenue AS (
    SELECT TRD.Date,
    ROUND((SELECT SUM(total_revenue)
    FROM TotalRevenue TR
    WHERE TR.Date >= DATE_SUB(TRD.Date, INTERVAL 15 DAY)
    AND TR.Date <= TRD.Date) / 15, 4) AS moving_average_revenue
    FROM TotalRevenue TRD
)
SELECT DISTINCT MAR.Date, MAR.moving_average_revenue
FROM MovingAverageRevenue MAR
LEFT JOIN bookings b ON DATE(b.starttime) = MAR.Date
ORDER BY MAR.Date;