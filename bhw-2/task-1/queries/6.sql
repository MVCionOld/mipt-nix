select c.clientid, carid from clients as c
inner join docs as d on d.clientid = c.clientid
inner join subscriptions as s on s.docid = d.docid
where date_part('month', validitymonth) = 9 and
  date_part('year', validitymonth) = 2018
except
  select c.clientid, carid from clients as c
inner join docs as d on d.clientid = c.clientid
inner join subscriptions as s on s.docid = d.docid
where validitymonth >= date('2018.10.01')