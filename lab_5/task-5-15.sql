/*Составьте список участников (включая гостей) вместе с количеством часов, которые они забронировали для объекта,  
округленным до ближайших десяти часов. Ранжируйте их по этой округленной цифре, получая в результате имя, фамилию, 
округленные часы и звание. Сортировка по званию, фамилии и имени.
Примечание: используйте функцию ранжирования*/
USE cd;
SELECT CONCAT(m.firstname, ' ', m.surname) AS 'ФИО', ROUND(SUM(COALESCE(b.slots / 2, 0)), -1) as 'Кол-во часов', 
RANK() OVER (ORDER BY ROUND(SUM(COALESCE(b.slots / 2, 0)), -1)) as ranks
FROM members m
LEFT JOIN bookings b ON m.memid = b.memid GROUP BY m.memid ORDER BY m.surname, m.firstname;