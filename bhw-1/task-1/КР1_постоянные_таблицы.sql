


CREATE TABLE Buses (BusID int primary key, BusRegNo varchar(50), Year int);
CREATE TABLE Drivers (DriverID int primary key, Surname varchar(50), FirstName varchar(50), Date_of_Birth date);
CREATE TABLE Movements (MoveID int primary key, BusID int, DriverID int, FromTownID int, ToTownID int, DT_Begin date, DT_End date, Km float);
CREATE TABLE Towns (TownID int primary key, Town varchar(50), RegionID int);
CREATE TABLE Regions (RegionID int primary key, Region varchar(50));


--buses
INSERT INTO Buses VALUES (1, 'T567OP190', 1990);
INSERT INTO Buses VALUES (2, 'O583AA190', 2001);
INSERT INTO Buses VALUES (3, 'O364HK190', 2005);
INSERT INTO Buses VALUES (4, 'M562OH150', 2001);
INSERT INTO Buses VALUES (5, 'B656BP150', 2002);
INSERT INTO Buses VALUES (6, 'B756PB197', 1991);
INSERT INTO Buses VALUES (7, 'H001HH777', 2016);
INSERT INTO Buses VALUES (8, 'K002KK777', 2014);
INSERT INTO Buses VALUES (9, 'P003OK799', 2017);
INSERT INTO Buses VALUES (10, 'E683HP777', 1993);
INSERT INTO Buses VALUES (11, 'E690HE777', 2002);

--drivers
INSERT INTO Drivers VALUES (1, 'Ivanov', 'Ivan', '19911201');
INSERT INTO Drivers VALUES (2, 'Sazikov', 'Andrey', '19890308');
INSERT INTO Drivers VALUES (3, 'Petrov', 'Pavel', '19770707');
INSERT INTO Drivers VALUES (4, 'Novikov', 'Stepan', '19840803');
INSERT INTO Drivers VALUES (5, 'Voloshin', 'Aleksey', '19730603');
INSERT INTO Drivers VALUES (6, 'Voloshin', 'Petr', '19850906');
INSERT INTO Drivers VALUES (7, 'Sidorov', 'Maksim', '19860614');
INSERT INTO Drivers VALUES (8, 'Stepanov', 'Oleg', '19730413');
INSERT INTO Drivers VALUES (9, 'Bezrukov', 'Ivan', '19890502');
INSERT INTO Drivers VALUES (10, 'Kochetov', 'Ildar', '19830915');
INSERT INTO Drivers VALUES (11, 'Velikiy', 'Uriy', '19740601');

--towns
INSERT INTO Towns VALUES (1, 'Moskva', 1);
INSERT INTO Towns VALUES (2, 'Sankt-Peterburg', 2);
INSERT INTO Towns VALUES (3, 'Razan', 3);
INSERT INTO Towns VALUES (4, 'Zelenograd', 1);
INSERT INTO Towns VALUES (5, 'Tula', 4);
INSERT INTO Towns VALUES (6, 'Novomoskovsk', 4);

--regions
INSERT INTO Regions VALUES (1, 'Moskva');
INSERT INTO Regions VALUES (2, 'Sankt-Peterburg');
INSERT INTO Regions VALUES (3, 'Ryazanskaya');
INSERT INTO Regions VALUES (4, 'Tulskaya');

--Movements
INSERT INTO Movements VALUES (1, 1, 5, 1, 3, '20181015 11:45:00', '20181015 15:15:00', 181);
INSERT INTO Movements VALUES (2, 10, 3, 1, 2, '20181015 16:00:00', '20181016 03:30:00', 720);
INSERT INTO Movements VALUES (3, 1, 8, 1, 3, '20181016 12:50:00', '20181016 15:40:00', 180);
INSERT INTO Movements VALUES (4, 10, 4, 2, 1, '20181016 18:30:00', '20181017 06:00:00', 725);
INSERT INTO Movements VALUES (5, 4, 9, 3, 1, '20181017 14:30:00', '20181017 17:50:00', 182);
INSERT INTO Movements VALUES (6, 7, 10, 3, 1, '20181017 15:15:00', '20181017 18:50:00', 180);
INSERT INTO Movements VALUES (7, 2, 1, 5, 6, '20181017 18:02:00', '20181017 19:17:00', 60);
INSERT INTO Movements VALUES (8, 3, 2, 1, 6, '20181018 12:10:00', '20181018 15:10:00', 223);
INSERT INTO Movements VALUES (9, 5, 7, 5, 6, '20181018 15:14:00', '20181018 16:36:00', 60);
INSERT INTO Movements VALUES (10, 6, 11, 6, 1, '20181018 16:00:00', '20181018 19:00:00', 223);
INSERT INTO Movements VALUES (11, 11, 3, 1, 2, '20181018 21:30:00', '20181019 08:45:00', 725);
INSERT INTO Movements VALUES (12, 8, 6, 1, 4, '20181019 15:40:00', '20181019 16:20:00', 50);
INSERT INTO Movements VALUES (13, 8, 6, 4, 1, '20181019 18:55:00', '20181019 19:35:00', 50);

/*
SELECT *
FROM Buses

SELECT *
FROM Towns

SELECT *
FROM Drivers

SELECT *
FROM Regions

SELECT *
FROM Movements
*/

