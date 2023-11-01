/* вывод объектов, использование которых платно, то есть membercost > 0 */
USE cd;
SELECT facility FROM facilities WHERE membercost != 0;