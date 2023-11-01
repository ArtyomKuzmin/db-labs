/* вывод объектов, использование которых бесплатно, то есть membercost = 0 */
USE cd;
SELECT facility FROM facilities WHERE membercost = 0;