select case when EXISTS(select * from cars where regno = :regno) then 'ok'
  else 'not ok' end;

insert into cars values ((select max(carid) + 1 from cars), :regno);

delete from cars
where :regno in
      (select regno from cars where carid < (select max(carid) from cars))
and carid = (select max(carid) from cars)