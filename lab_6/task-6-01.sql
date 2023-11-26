-- Выберите начальное и конечное время последних 10 аренд  объектов, упорядочив их по времени их окончания.
USE cd;
SELECT starttime AS 'начало', ADDTIME(starttime, SEC_TO_TIME(slots * 1800)) AS конец
FROM bookings
ORDER BY конец DESC
LIMIT 10;