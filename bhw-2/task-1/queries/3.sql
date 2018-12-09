with rating_table as (
select p1.parkingno, count(distinct pd1.regno) as total, 0 as rating
from parking as p1
join parking_data as pd1 on p1.parkingno = pd1.parkingno
group by p1.parkingno

union

select pp.parkingno, 0 as total, 0 as rating
from (
select p2.parkingno from parking as p2

except

select p3.parkingno from parking as p3
join parking_data as pd2 on p3.parkingno = pd2.parkingno
) as pp
)

select rt.parkingno, rt.total, (
select count(*)
from rating_table as rt1
where rt.total >= rt1.total
) as rating_position
from rating_table as rt
order by rating_position