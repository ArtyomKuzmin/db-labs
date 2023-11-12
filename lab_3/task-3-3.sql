/* выбираем членов клуба, которые рекомендовали других членов для вступления. */
USE cd;
SELECT surname, firstname 
FROM members
WHERE memid IN (SELECT recommendedby FROM members WHERE recommendedby IS NOT NULL); 