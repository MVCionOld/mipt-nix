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


create or replace function get_row(id_matrix int, id_row int, default_value float) returns float[]  as
$row_to_return$
DECLARE
  counter int := 0;
  column_count int;
  row_to_return float[] default array[]::float[];
  temp_value float;
  rec record;
begin
  select get_width(id_matrix) into column_count;

  for rec in select column_no, element_val from matrix_data where id_matrix = matrix_id and row_no = id_row
  loop
    if rec.column_no = counter then
      row_to_return := array_append(row_to_return, rec.element_val);
    else
      row_to_return := array_append(row_to_return, default_value);
    end if;

    counter := counter + 1;
  end loop;

  loop
  exit when counter = column_count;
    row_to_return := array_append(row_to_return, default_value);
    counter := counter + 1;
  end loop;

  return row_to_return;

end;
$row_to_return$ language plpgsql;