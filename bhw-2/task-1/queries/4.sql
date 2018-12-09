select c.clientid, clientspersnum,
  case when sum(total) is null then 0 else sum(total) end
from clients as c
left join docs as d on d.clientid = c.clientid
  and date_part('month', date_of_doc) = 11 and
      date_part('year', date_of_doc) = 2018
group by c.clientid, clientspersnum