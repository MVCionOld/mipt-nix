/* 2
  показывает матрицу
  предполагаем здесь и далее, что индексация идёт с 0
*/
select row_no, column_no, element_val from matrix_data where matrix_id = :matrix_id;


/* 3
  возвращает транспонированную матрицу
*/
select column_no as row_no, row_no as column_no, element_val from matrix_data where matrix_id = :matrix_id;


/* 4
  возвращает матрицу, умноженную на число
*/
select row_no, column_no, element_val * :value as element_val from matrix_data where matrix_id = :matrix_id;


/* 5
  является ли матрица вектором
*/
select case
  when max(column_no) = 0 then
      'yes'
  else
      'no'

  end as answer

from matrix_data where matrix_id = :matrix_Id;


/* 6
  является ли матрица квадратной
*/
select
  case
  when max(row_no) = max(column_no) then
      'yes'
  else
      'no'

  end as answer
from matrix_data where matrix_id = :matrix_id;


/* 7
  является ли матрица симметричной
*/
select
  case
    when (select max(row_no) <> max(column_no) from matrix_data where matrix_id = :matrix_id) or
         (select count(*) from matrix_data as matr1
         where matrix_id = :matrix_id and
               element_val <>
               (select element_val from matrix_data as matr2
               where matr2.matrix_id = :matrix_id and matr1.row_no = matr2.column_no and matr1.column_no = matr2.row_no) ) > 0
    then
      'no'
    else
      'yes'
    end as answer;

/* 8
	Написать запрос с параметром, который выводит матрицу,
  содержащую элементы на пересечении нечетных строк и четных
  столбцов исходной матрицы, заданной параметром.
*/

select
  MATRIX_DATA.row_no
  , MATRIX_DATA.column_no
  , MATRIX_DATA.element_val
from
  MATRIX_DATA
where 1=1
  and MATRIX_DATA.matrix_id = :matrix_id
  and MATRIX_DATA.column_no % 2 = 0
  and MATRIX_DATA.row_no % 2 = 1
order by
  row_no
  , column_no;


/* 9 */

/* вставляем матрицу D под id = 7 - фактически первые 3 диагональных элемента*/
insert into
  MATRIX_DATA
values
  (7, 0, 0, 0),
  (7, 0, 1, 1),
  (7, 0, 2, 2),
  (7, 1, 0, 0),
  (7, 1, 1, 1),
  (7, 1, 2, 2);

select matr.row_no, matr.column_no, matr.element_val from matrix_data as matr, matrix_data as d1, matrix_data as d2
where
    d1.matrix_id = 7 and
    d2.matrix_id = 7 and
    matr.matrix_id = :matrix_id1 and
    d1.row_no = 0 and d2.row_no = 1 and
    d1.column_no = d2.column_no and
    matr.row_no = cast(d1.element_val as int) and
    matr.column_no = cast(d2.element_val as int);



/* #10
  Написать запрос с параметрами, который проверяет, можно ли сложить две матрицы.
*/
select
  case
    when
      (select max(row_no) from matrix_data where matrix_id = :matrix_id1)
        = (select max(row_no) from matrix_data where matrix_id = :matrix_id2)
      and (select max(column_no) from matrix_data where matrix_id = :matrix_id1)
            = (select max(column_no) from matrix_data where matrix_id = :matrix_id2)
      then 'POSSIBLE'
    else
       'IMPOSSIBLE'
  end;


/* #11
	Написать запрос с параметрами, который возвращает результат сложения двух матриц
	(если нельзя сложить, ничего не выводим)
*/
    select
        A.column_no
      , A.row_no
      , A.element_val + B.element_val as result
      from
      MATRIX_DATA A
      join
      MATRIX_DATA B
      on A.matrix_id=:matrix_id1 and B.matrix_id=:matrix_id2
    where 1=1
      and A.row_no=B.row_no
      and A.column_no=B.column_no
      and (select max(row_no) from matrix_data where matrix_id = :matrix_id1) = (select max(row_no) from matrix_data where matrix_id = :matrix_id2)
      and (select max(column_no) from matrix_data where matrix_id = :matrix_id1) = (select max(column_no) from matrix_data where matrix_id = :matrix_id2);

/* 12
  Написать запрос с параметрами, который проверяет, можно ли перемножить две матрицы
*/
select
  case
  when max(matr1.column_no) = max(matr2.row_no) then
      'yes'
  else
      'no'

  end as answer
from matrix_data as matr1, matrix_data as matr2 where matr1.matrix_id = :matrix_id1 and matr2.matrix_id = :matrix_id2;


/* 13
  Написать запрос с параметрами, который возвращает результат умножения двух матрицы.
  (если умножить нельзя - ничего не выводим)
*/
select matr1.row_no, matr2.column_no,
       (select sum(el1 * el2) from (select matr11.element_val as el1, matr22.element_val as el2 from matrix_data as matr11, matrix_data as matr22
        where
          matr11.matrix_id = matr1.matrix_id and
          matr22.matrix_id = matr2.matrix_id and
          matr11.row_no = matr1.row_no and
          matr22.column_no = matr2.column_no and
          matr11.column_no = matr22.row_no
       ) as cros ) as value
from
  matrix_data as matr1,
  matrix_data as matr2
where
  matr1.matrix_id = :matrix_id1 and
  matr2.matrix_id = :matrix_id2 and
  matr1.column_no = 0 and
  matr2.row_no = 0 and
  (select max(column_no) from matrix_data where matrix_id = :matrix_id1) = (select max(row_no) from matrix_data where matrix_id = :matrix_id2);

/* 14.
  Заведите в базе ортогональную матрицу A. Выведите решение X уравнения AX = B, где B – заданная параметром матрица.
  Мы сделали - задаем матрицу A по параметру, предполагая, что она ортогональна. Затем мы получаем матрицу X,
  перемножая ортогональную матрицу A.T и B.
  К сожалению, не придумали, как вывести "решения не существует" в случае несоответствия размеров, так что
  ничего не выводим.
*/

select transposed.row_no, matr2.column_no,
       (select sum(el1 * el2)
        from (select matr11.element_val as el1, matr22.element_val as el2
              from (select column_no as row_no, row_no as column_no, element_val from matrix_data where matrix_id = :matrix_id1) as matr11, matrix_data as matr22
        where matr22.matrix_id = matr2.matrix_id and
              matr11.row_no = transposed.row_no and
              matr22.column_no = matr2.column_no and
              matr11.column_no = matr22.row_no
       ) as cros ) as value
from
  (select column_no as row_no, row_no as column_no, element_val from matrix_data where matrix_id = :matrix_id1) as transposed,
  matrix_data as matr2
where
  matr2.matrix_id = :matrix_id2 and
  transposed.column_no = 0 and
  matr2.row_no = 0 and
  (select max(column_no) from matrix_data where matrix_id = :matrix_id1) = (select max(row_no) from matrix_data where matrix_id = :matrix_id2);

/* 15.
  Найдите X решение уравнения C + X = B.
  Когде решения не существует - мы опять ничгео не выводим.
*/
   select
       B.column_no
       , B.row_no
       , B.element_val - C.element_val as result
   from
       MATRIX_DATA B
       join
       MATRIX_DATA C
       on
       B.matrix_id=:matrix_id1
       and C.matrix_id=:matrix_id2
   where 1=1
       and B.row_no=C.row_no
       and B.column_no=C.column_no
       and (select max(row_no) from matrix_data where matrix_id = :matrix_id1) = (select max(row_no) from matrix_data where matrix_id = :matrix_id2)
       and (select max(column_no) from matrix_data where matrix_id = :matrix_id1) = (select max(column_no) from matrix_data where matrix_id = :matrix_id2);
