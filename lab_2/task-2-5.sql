USE cd;
SELECT facility FROM facilities WHERE membercost <= (monthlymaintenance/50) AND membercost != 0;