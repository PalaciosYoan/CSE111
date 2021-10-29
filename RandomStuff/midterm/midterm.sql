DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Ships;
DROP TABLE IF EXISTS Battles;
DROP TABLE IF EXISTS Outcomes;


SELECT "1----------";
.headers on
--put your code here
CREATE TABLE IF NOT EXISTS Classes (
    class varchar(55) PRIMARY KEY,
    type varchar(25) not null,
    country varchar(55) not null,
    numGuns integer not null,
    bore integer not null,
    displacement integer not null
);

CREATE TABLE IF NOT EXISTS Ships (
    name varchar(55) PRIMARY KEY,
    class varchar(55) not null,
    launched integer not null
);

CREATE TABLE IF NOT EXISTS Battles (
    name varchar(55) PRIMARY KEY,
    date date not null
);

CREATE TABLE IF NOT EXISTS Outcomes (
    ship varchar(55) NOT NULL,
    battle varchar(55) NOT NULL,
    result varchar(55) not null,
    PRIMARY KEY(ship,battle)
);

.headers off

SELECT "2----------";
.headers on
--put your code here
INSERT INTO Ships (name, class, launched) 
VALUES ("California", "Tennessee", 1915),  
("Haruna", "Kongo", 1915),  
("Hiei", "Kongo", 1915),  
("Iowa", "Iowa", 1933),  
("Kirishima", "Kongo", 1915), 
("Kongo", "Kongo", 1913),  
("Missouri", "Iowa", 1935),  
("Musashi", "Yamato", 1942),  
("New Jersey", "Iowa", 1936),  
("North Carolina", "North Carolina", 1941),  
("Ramillies", "Revenge", 1917),  
("Renown", "Renown", 1916),  
("Repulse", "Renown", 1916),  
("Resolution", "Revenge", 1916),  
("Revenge", "Revenge", 1916),  
("Royal Oak", "Revenge", 1916),  
("Royal Sovereign", "Revenge", 1916),  
("Tennessee", "Tennessee", 1915),  
("Washington", "North Carolina", 1941),  
("Wisconsin", "Iowa", 1940),  
("Yamato", "Yamato", 1941);

INSERT INTO Classes (class, type, country, numGuns, bore, displacement) VALUES ("Bismarck", "bb", "Germany", 8, 15, 42000),  ("Iowa", "bb", "USA", 9, 16, 46000),  ("Kongo", "bc", "Japan", 8, 14, 32000),  ("North Carolina", "bb", "USA", 9, 16, 37000),  ("Renown", "bc", "Britain", 6, 15, 32000),  ("Revenge", "bb", "Britain", 8, 15, 29000),  ("Tennessee", "bb", "USA", 12, 14, 32000),  ("Yamato", "bb", "Japan", 9, 18, 
65000);

INSERT INTO Outcomes (ship, battle, result) VALUES ("California", "Surigao Strait", "ok"),  ("Kirishima", "Guadalcanal", "sunk"),  ("Resolution", "Denmark Strait", "ok"),  ("Wisconsin", "Guadalcanal", "damaged"),  ("Tennessee", "Surigao Strait", "ok"),  ("Washington", "Guadalcanal", "ok"),  ("New Jersey", "Surigao Strait", "ok"),  ("Yamato", "Surigao Strait", "sunk"),  ("Wisconsin", "Surigao Strait", "damaged");

INSERT INTO Battles (name, date) VALUES ("Denmark Strait", "1941-05-24 00:00:00"),  ("Guadalcanal", "1942-11-15 00:00:00"),  ("North Cape", "1943-12-26 00:00:00"),  ("Surigao Strait", "1944-10-25 00:00:00");
.headers off

SELECT "3----------";
.headers on
--put your code here
SELECT cls.country, COUNT(shp.name) as numShips
FROM Classes cls, Ships shp
WHERE 
    cls.class = shp.class AND
    shp.launched BETWEEN 1930 AND 1940
GROUP BY cls.country
;
.headers off

SELECT "4----------";
.headers on
--put your code here
INSERT INTO Outcomes(ship, battle, result)
SELECT name, 'Denmark Strait' as battle, 'damaged' as result
FROM 
    (
        SELECT ship.name, 'Denmark Strait' as battle
        FROM Ships ship
        WHERE launched <= 1920
        EXCEPT
        SELECT ship, battle
        FROM Outcomes
    )
;

.headers off

SELECT "5----------";
.headers on
--put your code here
SELECT country, COUNT(result) as numDamage
FROM
    (
        SELECT country, result
        FROM Classes cls, Ships ship, Outcomes otcme
        WHERE
            cls.class = ship.class AND
            ship.name = otcme.ship AND
            otcme.result = 'damaged'
    )
GROUP BY country
;
.headers off

SELECT "6----------";
.headers on
--put your code here
SELECT country
FROM 
    (
        SELECT country, COUNT(result) as numDamage
        FROM
            (
                SELECT country, result
                FROM Classes cls, Ships ship, Outcomes otcme
                WHERE
                    cls.class = ship.class AND
                    ship.name = otcme.ship AND
                    otcme.result = 'damaged'
            )
        GROUP BY country
    )
WHERE cast(numDamage as REAL) = (
    SELECT MIN(CAST(numDamage as real))
    FROM 
        (
            SELECT country, COUNT(result) as numDamage
            FROM
                (
                    SELECT country, result
                    FROM Classes cls, Ships ship, Outcomes otcme
                    WHERE
                        cls.class = ship.class AND
                        ship.name = otcme.ship AND
                        otcme.result = 'damaged'
                )
            GROUP BY country
        ) t1
)
;
.headers off

SELECT "7----------";
.headers on
--put your code here
DELETE FROM Outcomes
WHERE
    ship IN (
        SELECT ship
        FROM Classes cls, Ships ship,
            (
                SELECT ship, battle, result
                FROM Outcomes otcme
                WHERE otcme.battle = 'Denmark Strait'
            ) t1
        WHERE
            cls.class =ship.class AND
            ship.name = t1.ship AND
            cls.country = 'Japan'
    ) AND
    battle IN 
            (
                SELECT battle
                FROM Outcomes otcme
                WHERE otcme.battle = 'Denmark Strait'
            )
    ;

.headers off

SELECT "8----------";
.headers on
--put your code here
;
.headers off

SELECT "9----------";
.headers on
--put your code here
;
.headers off

SELECT "10---------";
.headers on
--put your code here
;
.headers off

SELECT "11---------";
.headers on
--put your code here
;
.headers off

SELECT "12---------";
.headers on
--put your code here
;
.headers off

SELECT "13---------";
.headers on
--put your code here
;
.headers off

SELECT "14---------";
.headers on
--put your code here
;
.headers off

SELECT "15---------";
.headers on
--put your code here
;
.headers off

SELECT "16---------";
.headers on
--put your code here
;
.headers off

SELECT "17---------";
.headers on
--put your code here
;
.headers off
