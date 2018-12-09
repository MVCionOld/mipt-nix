select t.tariffid, t.tariff from tariffs as t
inner join tariff_data as td on td.tariffid = t.tariffid
except
select t.tariffid, t.tariff from tariffs as t
inner join tariff_data as td on td.tariffid = t.tariffid
inner join subscriptions as s on s.tariffid = t.tariffid
inner join docs as d on d.docid = s.docid
where date_of_doc >= date('2018.09.01')