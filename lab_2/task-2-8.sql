USE cd;
SELECT facility, 'Дешевый' AS 'Качественная стоимость' FROM facilities WHERE monthlymaintenance < 100
UNION
SELECT facility, 'Дорогой' FROM facilities WHERE monthlymaintenance >= 100;