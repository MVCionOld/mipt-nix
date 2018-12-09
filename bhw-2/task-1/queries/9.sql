select distinct c.regno, p.parkingno, :data as date from cars as c
inner join parking_data as d
  on c.regno = d.regno
inner join parking as p
  on p.parkingno = d.parkingno
where date_part('month', datetime_of_scan) = date_part('month', date(:data)) and
  date_part('year', datetime_of_scan) = date_part('year', date(:data)) and
  date_part('day', datetime_of_scan) = date_part('day', date(:data))
except
select distinct c.regno, p.parkingno, :data as date from cars as c
inner join parking_data as d
  on c.regno = d.regno
inner join parking as p
  on p.parkingno = d.parkingno
inner join subscriptions as ss
  on ss.carid = c.carid
inner join tariffs as t
  on t.tariffid = ss.tariffid
inner join tariff_data as td
  on td.tariffid = t.tariffid and td.areaid = p.areaid
where date_part('month', datetime_of_scan) = date_part('month', date(:data)) and
  date_part('year', datetime_of_scan) = date_part('year', date(:data)) and
  date_part('day', datetime_of_scan) = date_part('day', date(:data))


