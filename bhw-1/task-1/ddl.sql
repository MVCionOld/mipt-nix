drop table if exists MATRIX_INFO cascade;
drop table if exists MATRIX_DATA;

create table if not exists MATRIX_INFO (
  matrix_id   serial primary key,
  height      int not null default 1 check (height > 0),
  width       int not null default 1 check (width > 0)
);

create table if not exists MATRIX_DATA (
  matrix_id   int references MATRIX_INFO on delete cascade,
  row_no      int not null check (row_no >= 0),
  column_no   int not null check (column_no >= 0),
  element_val float default 0.0,
  primary key (matrix_id, row_no, column_no)
);