select td.areaid,
  (select sum(num) from parking as p where p.areaid = td.areaid) as places,
  count(distinct carid) as buzy,
  cast(count(distinct carid) as float) / (select sum(num) from parking as p where p.areaid = td.areaid)
    as business
from subscriptions as ss
inner join tariff_data as td
  on td.tariffid = ss.tariffid
where date_part('month', validitymonth) = 11
  and date_part('year', validitymonth) = 2018
group by td.areaid