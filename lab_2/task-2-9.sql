USE cd;
SELECT memid, surname, firstname FROM members 
WHERE EXTRACT(MONTH FROM joindate) >= 9 AND EXTRACT(YEAR FROM joindate) >= 2012;