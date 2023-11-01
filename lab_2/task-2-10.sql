/* вывод 10 фамилий членов клуба, 
упорядоченных по алфавиту без повторов */
USE cd;
SELECT DISTINCT surname FROM members ORDER BY surname LIMIT 10;