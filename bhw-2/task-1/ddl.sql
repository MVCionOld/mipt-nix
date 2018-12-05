drop table if exists areas cascade;
drop table if exists parking cascade;
drop table if exists clients cascade;
drop table if exists cars cascade;
drop table if exists tariffs cascade;
drop table if exists tariff_data cascade;
drop table if exists docs cascade;
drop table if exists subscriptions cascade;
drop table if exists parking_data cascade;


create table if not exists areas (
  AreaID      int primary key,
  Area        varchar(50),
  CostPerHour float
);
create table if not exists parking (
  ParkingNo int primary key,
  Address   varchar(50),
  AreaID    int references areas(AreaID),
  Num       int
);
create table if not exists clients (
  ClientID       int primary key,
  ClientsPersNum varchar(10),
  Surname        varchar(100),
  Name           varchar(100),
  PhoneNumber    varchar(20)
);
create table if not exists cars (
  CarID int primary key,
  RegNo varchar(10)
);
create table if not exists tariffs (
  TariffID     int primary key,
  Tariff       varchar(100),
  CostPerMonth float
);
create table if not exists tariff_data (
  TariffID int references tariffs(TariffID),
  AreaID   int references areas(AreaID),
  primary key (TariffID, AreaID)
);
create table if not exists docs (
  DocID       int primary key,
  Date_of_doc timestamp,
  ClientID    int references clients(ClientID),
  Total       float
);
create table if not exists subscriptions (
  SubscrID      int primary key,
  DocID         int references docs(DocID),
  CarID         int references cars(CarID),
  TariffID      int references tariffs(TariffID),
  ValidityMonth date,
  Cost          float
);
create table if not exists parking_data (
  ID               int primary key,
  ParkingNo        int,
  DateTime_of_scan timestamp,
  RegNo            varchar(10)
);

