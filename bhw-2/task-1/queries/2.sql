select p.parkingno, date_part('month', datetime_of_scan) as month,
  date_part('year', datetime_of_scan) as year,
    date_part('hour', datetime_of_scan) as hour,
  count(distinct regno) as parked,
  num
from parking as p
inner join parking_data as d
on p.parkingno = d.parkingno
group by p.parkingno, month, year, hour
