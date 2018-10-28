create table client(
  client_id serial primary key ,
  first_name varchar(50),
  middle_name varchar(50),
  last_name varchar(50),
  payment_type boolean
);

create table service(
  service_id serial primary key ,
  description_txt text,
  payment_flg boolean

);

create table client_x_service (
  client_service_id serial primary key,
  client_id int references client(client_id),
  service_id int references service(service_id)
);

create table counter (
  counter_id serial primary key ,
  client_service_id int references client_x_service(client_service_id),
  usage_date date,
  amount float
);

create table service_history(
  service_history_id serial primary key ,
  service_id int references service(service_id),
  tariff_amount float,
  change_date date
);

create table bill(
  bill_id serial primary key ,
  client_id int references client(client_id),
  bill_date date,
  payment_state boolean
);

create table balance_supply(
  balance_supply_id serial primary key ,
  supply_amount float,
  supply_time date,
  client_id int references client(client_id)
);

create table payment_from_balance(
  payment_from_balance_id serial primary key ,
  bill_id int references bill(bill_id),
  payment_time date
);

