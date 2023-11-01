/* вывод даты последней регистрации члена клуба */
USE cd;
SELECT max(joindate) AS 'Last registration' FROM members;