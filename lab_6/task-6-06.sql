-- Выведите все объектов клуба, если они содержат в названии слово  ‘Tennis’ в произвольном регистре.
USE cd;
SELECT facility AS 'объекты' FROM facilities
WHERE LOWER(facility) LIKE '%tennis%';