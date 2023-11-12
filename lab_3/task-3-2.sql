/* выбираем теннисные корты, забронированные пользователями на 19 сентября 2012 года. */
USE cd;
SELECT DISTINCT facility FROM facilities
JOIN bookings ON facilities.facid = bookings.facid
WHERE facilities.facid LIKE 'Tennis Court%' AND DATE(bookings.starttime) = '2012-09-19';