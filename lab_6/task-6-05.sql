-- Выведите наименования всех объектов клуба заглавными буквами, если они содержат в названии слово ‘Tennis’.
USE cd;
SELECT UPPER(facility) AS 'наименования объектов c заглавными буквами' FROM facilities 
WHERE facility LIKE '%Tennis%';