drop trigger if exists
  build_matrix
on MATRIX_DATA;

create or replace function
  build_matrix_function()
returns trigger as
$body$

$body$
language plpythonu;

create trigger
  build_matrix
instead of insert
on
  MATRIX_DATA
for each row execute procedure
  build_matrix_function();


create or replace function
  get_matrix(matrix_id integer)
returns table (
  matrix_id   int,
  row_no      int,
  column_no   int,
  element_val float
)
as
$body$
  declare
    row_cnt integer := (select height from MATRIX_INFO where MATRIX_INFO.matrix_id=matrix_id);
    column_cnt integer := (select width from MATRIX_INFO where MATRIX_INFO.matrix_id=matrix_id);
  begin

    return query
      select
        *
      from (
        for i in 1..row_cnt
      )
  end;
$body$
language plpgsql;