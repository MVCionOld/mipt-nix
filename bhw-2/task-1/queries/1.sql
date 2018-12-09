select t.tariffid, date_part('month', validitymonth) as month,
  date_part('year', validitymonth) as year,
  count(*),
  sum(cost) from tariffs as t
inner join subscriptions as s
on s.tariffid = t.tariffid
group by t.tariffid, month, year
having count(*) > 0 and sum(cost) > 0
