/* вывод 10 фамилий членов клуба, 
упорядоченных по алфавиту без повторов */
USE cd;
SELECT surname FROM members WHERE memid > 1 AND memid < 12 ORDER BY surname;