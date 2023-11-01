/* вывод объединенных имен членов и названий объектов 
в одну таблицу с одним столбцом */
USE cd;
SELECT firstname AS 'Firstname/Facilities' FROM members WHERE firstname != 'Guest'
UNION ALL
SELECT facility FROM facilities;