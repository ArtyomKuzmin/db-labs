/* вывод объектов, использование которых платно, 
но стоимость использования не превышает 1/50 от 
стоимости месячного обслуживания */
USE cd;
SELECT facility FROM facilities WHERE membercost <= (monthlymaintenance/50) AND membercost != 0;