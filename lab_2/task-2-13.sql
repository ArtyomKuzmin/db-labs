/* выбор имён, фамилий и дат вступления
в клуб последних из всех вступивших */
USE cd;
SELECT firstname, surname, joindate FROM members WHERE joindate = (SELECT MAX(joindate) FROM members);