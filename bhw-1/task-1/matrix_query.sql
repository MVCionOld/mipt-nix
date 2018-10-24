/* 2 */
select row_no, column_no, element_val from matrix_data where matrix_id = $1;

/* 3 */
select column_no as row_no, row_no as column_no, element_val from matrix_data where matrix_id = $1;

/* 4 */
select row_no, column_no, element_val * $1 from matrix_data where matrix_id = $0;

/* 5 */
select case
  when max(column_no) = 0 then
      'yes'
  else
      'no'

  end as answer

from matrix_data where matrix_id = $1;

/* 6 */
select
  case
  when max(row_no) = max(column_no) then
      'yes'
  else
      'no'

  end as answer
from matrix_data where matrix_id = $1;

/* 7 */
select
  case
    when (select max(row_no) <> max(column_no) from matrix_data where matrix_id = $1) or
         (select count(*) from matrix_data as matr1
         where matrix_id = $1 and
               element_val <>
               (select element_val from matrix_data as matr2
               where matr2.matrix_id = $1 and matr1.row_no = matr2.column_no and matr1.column_no = matr2.row_no) ) > 0
    then
      'no'
    else
      'yes'
    end as answer;

/* 12 */
select
  case
  when max(matr1.column_no) = max(matr2.row_no) then
      'yes'
  else
      'no'

  end as answer
from matrix_data as matr1, matrix_data as matr2 where matr1.matrix_id = $1 and matr2.matrix_id = $2;

/* 13 */

