/* Postgre SQL 9.6 */

/* 1 */
SELECT BusID, BusRegNo, Year from Buses
WHERE BusRegNo LIKE '%9%'
ORDER BY Year ASC ;

/* 2 */
SELECT DriverID, Surname, FirstName from Drivers
where Date_of_Birth = (SELECT MIN(Date_of_Birth) FROM Drivers);

/* 3 */
SELECT RegionId, COUNT(TownID) from Towns
GROUP BY RegionID;

/* 4 */
SELECT BusID, (SELECT COUNT(BusID) from Movements as M1 where M.BusID = M1.BusID) as sum_count, COUNT(BusID) as driver_count from Movements as M
WHERE DriverID = 2
GROUP BY BusId;

/* 5  строго более двух*/
SELECT date_part('year', Date_of_Birth) as year from Drivers
GROUP BY year
HAVING COUNT(DriverID) > 2;

/* 6 */
SELECT Year FROM Buses
GROUP BY Year
HAVING COUNT(BusID) >= ALL (SELECT COUNT(BusID) FROM Buses GROUP BY Year);

/* 7 */
SELECT Regions.RegionID, Regions.Region FROM Regions, Towns
WHERE Towns.RegionID = Regions.RegionID AND Towns.TownID = $1;

/* 8 */
SELECT date_part('year', DATE_of_Birth) as year, COUNT(distinct D.DriverID), COUNT(distinct MoveID)
FROM Drivers as D, Movements as M
WHERE M.DriverID = D.DriverID
GROUP BY year

/* 9 */




