create or replace function get_width(_id int) returns int as
$res$
DECLARE
  res int;
begin
  select matrix_info.width into res from matrix_info where _id = matrix_id;
  return res;
end; $res$ language plpgsql;

create or replace function get_height(_id int) returns int as
$res$
DECLARE
  res int;
begin
  select matrix_info.height into res from matrix_info where _id = matrix_id;
  return res;
end; $res$ language plpgsql;


create or replace function get_row(id_matrix int, id_row int) returns setof  as
$$
DECLARE
  counter int := 1;
  column_count int := select get_width(id_matrix) + 1;
  row_to_return int[];
begin
  loop
  exit when counter = column_count;
  set row_to_return[counter] = select element_val from matrix_data where id_matrix = matrix_id and row_no = id_row and column_no = counter;
  counter := counter + 1;
  end loop;

  return row_to_return;
end;
$$ language plpqsql;