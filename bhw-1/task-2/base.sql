drop table if exists CLIENT cascade;
drop table if exists SERVICE cascade;
drop table if exists CLIENT_X_SERVICE cascade;
drop table if exists COUNTER cascade;
drop table if exists SERVICE_HISTORY cascade;
drop table if exists BILL cascade;
drop table if exists DOC cascade;
drop table if exists DOC_ADJUNCTION cascade;
drop table if exists DOC_WITHDRAWAL cascade;
drop table if exists DOC_RECEIPT cascade;



create table if not exists CLIENT (
  client_id           serial primary key,
  first_nm            varchar(50) not null,
  middle_nm           varchar(50),
  last_nm             varchar(50) not null,
  payment_type_code   int default 0 not null,
  balance_amt         float default 0.0 not null check(balance_amt>=0 and balance_amt<=1)
  /*
    payment_type_code:
      0 - оплата по квитанции
      1 - оплата по предоплате
  */
);

create table if not exists SERVICE (
  service_id            serial primary key,
  description_txt       text not null,
  is_fixed_payment_flg  boolean default true not null
);

create table if not exists CLIENT_X_SERVICE (
  client_service_id serial primary key,
  client_id         int references CLIENT(client_id),
  service_id        int references SERVICE(service_id)
);

create table if not exists COUNTER (
  counter_id        serial primary key,
  client_service_id int references CLIENT_X_SERVICE(client_service_id),
  usage_dt          date not null,
  intake_amt        float default 0 not null
);

create table if not exists SERVICE_HISTORY (
  service_history_id serial primary key,
  service_id         int references SERVICE(service_id),
  change_dt          date not null,
  tariff_amt         float default 0 not null
);

create table if not exists BILL (
  bill_id       serial primary key,
  total_amt     float default 0.0 not null,
  bill_dt       date not null,
  is_paid_off   boolean default false not null
);

create table if not exists DOC (
  document_id serial primary key,
  client_id   int references CLIENT(client_id)
);

create table if not exists DOC_ADJUNCTION (
  document_id     int primary key references DOC(document_id),
  adjunction_dt   date not null,
  adjunction_amt  float default 0 not null
);

create table if not exists DOC_WITHDRAWAL (
  document_id     int primary key references DOC(document_id),
  withdrawal_dt   date not null,
  withdrawal_amt  float default 0 not null,
  bill_id         int references BILL(bill_id)
);

create table if not exists DOC_RECEIPT (
  document_id     int primary key references DOC(document_id),
  receipt_dt      date not null,
  bill_id         int references BILL(bill_id)
);



insert into CLIENT (first_nm, middle_nm, last_nm, payment_type_code) values
  ('A', null, 'AA', 1),
  ('B', null, 'BB', 0),
  ('C', null, 'CC', 1),
  ('D', null, 'DD', 0),
  ('E', null, 'EE', 1);

insert into SERVICE (description_txt, is_fixed_payment_flg) values
  ('Вывоз мусора', true),
  ('Газоснабжение', false),
  ('Водоснабжение', false),
  ('Уборка территории', true),
  ('Работа ассенизаторов', true);

insert into CLIENT_X_SERVICE (client_id, service_id) values
  (1, 5),
  (3, 2),
  (3, 3),
  (4, 3),
  (5, 1),
  (1, 2),
  (1, 3);

insert into COUNTER (client_service_id, usage_dt, intake_amt) values
  (2, '2004-10-01 10:23:54', 324.0),
  (3, '2005-10-01 10:23:54', 124.4),
  (4, '2005-12-01 00:00:00', 12.0),
  (6, '2005-11-01 08:00:00', 153.1),
  (7, '2005-10-01 16:57:05', 194.1);

insert into SERVICE_HISTORY (service_id, change_dt, tariff_amt) values
  (2, '2003-10-01 10:23:54', 31.5),
  (2, '2004-10-01 10:23:54', 23.6),
  (2, '2004-12-01 00:00:00', 28.0),
  (3, '2004-11-01 08:00:00', 124.4),
  (3, '2004-10-01 16:57:05', 142.2);

insert into BILL (total_amt, bill_dt, is_paid_off) values
  (12411.1, '2003-10-01 10:23:54', true),
  (12981.2, '2004-10-01 10:23:54', true),
  (8211.3, '2004-12-01 00:00:00', false),
  (29911.4, '2004-11-01 08:00:00', true),
  (16211.8, '2004-10-01 16:57:05', true);

/*
  таблица DOC является иерархическим
  словарем, т.к. сущности DOC_ADJUNCTION, DOC_WITHDRAWAL,
  DOC_RECEIPT имеют общие поля и близки по смыслу
 */
insert into DOC (client_id) values
  (1),
  (2),
  (3),
  (4),
  (5);

insert into DOC_ADJUNCTION (document_id, adjunction_dt, adjunction_amt) values
  (1, '2004-10-01 10:23:54', 10000.0);

insert into DOC_WITHDRAWAL (document_id, withdrawal_dt, withdrawal_amt, bill_id) values
  (2, '2004-11-01 10:00:00', 29911.4, 4),
  (3, '2004-11-01 12:57:05', 16211.8, 5);

insert into DOC_RECEIPT (document_id, receipt_dt, bill_id) values
  (4, '2003-10-01 10:23:54', 1),
  (5, '2004-10-01 10:23:54', 2);
