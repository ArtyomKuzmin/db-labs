/* вывод 10 фамилий членов клуба, 
упорядоченных по алфавиту без повторов */
USE cd;
SELECT DISTINCT surname FROM members WHERE surname != 'Guest' ORDER BY surname LIMIT 10;