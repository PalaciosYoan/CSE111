PRAGMA foreign_keys = on;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Ships;
DROP TABLE IF EXISTS Battles;
DROP TABLE IF EXISTS Outcomes;

SELECT "1----------";
.headers on
--put your code here
create table Classes(
    class CHAR(55) PRIMARY KEY,
    type VARCHAR(20),
    country CHAR(55) NOT NULL,
    numGuns INTEGER,
    bore INTEGER,
    displacement INTEGER,
    CheCK (type IN ('bb', 'bc'))
);

create table Ships(
    name CHAR(32) PRIMARY KEY,
    class char(55) REFERENCES Classes(class) ON DELETE SET NULL ON UPDATE SET NULL,
    launched INTEGER
);


create table Battles(
    name CHAR(32) PRIMARY KEY,
    date DATE
);

create table Outcomes(
    ship CHAR(32) REFERENCES Ships(name) ON DELETE CASCADE ON UPDATE CASCADE,
    battle CHAR(32) REFERENCES Battles(name) ON DELETE CASCADE ON UPDATE CASCADE,
    result CHAR(32),
    CHECK (result IN ('ok', 'sunk', 'damaged'))
)
;
.headers off

SELECT "2----------";
.headers on
--put your code here
INSERT INTO Classes VALUES ('Bismarck', 'bb', 'Germany', 8, 15, 42000);
INSERT INTO Classes VALUES ('Iowa', 'bb', 'USA', 9, 16, 46000);
INSERT INTO Classes VALUES ('Kongo', 'bc', 'Japan', 8, 14, 32000);
INSERT INTO Classes VALUES ('North Carolina', 'bb', 'USA', 9, 16, 37000);
INSERT INTO Classes VALUES ('Renown', 'bc', 'Britain', 6, 15, 32000);
INSERT INTO Classes VALUES ('Revenge', 'bb', 'Britain', 8, 15, 29000);
INSERT INTO Classes VALUES ('Tennessee', 'bb', 'USA', 12, 14, 32000);
INSERT INTO Classes VALUES ('Yamato', 'bb', 'Japan', 9, 18, 65000);


INSERT INTO Ships VALUES ('California', 'Tennessee',  1915);
INSERT INTO Ships VALUES ('Haruna', 'Kongo',  1915);
INSERT INTO Ships VALUES ('Hiei', 'Kongo',  1915);
INSERT INTO Ships VALUES ('Iowa', 'Iowa',  1933);
INSERT INTO Ships VALUES ('Kirishima', 'Kongo',  1915);
INSERT INTO Ships VALUES ('Kongo', 'Kongo',  1913);
INSERT INTO Ships VALUES ('Missouri', 'Iowa',  1935);
INSERT INTO Ships VALUES ('Musashi', 'Yamato',  1942);
INSERT INTO Ships VALUES ('New Jersey', 'Iowa',  1936);
INSERT INTO Ships VALUES ('North Carolina', 'North Carolina',  1941);
INSERT INTO Ships VALUES ('Ramillies', 'Revenge',  1917);
INSERT INTO Ships VALUES ('Renown', 'Renown',  1916);
INSERT INTO Ships VALUES ('Repulse', 'Renown',  1916);
INSERT INTO Ships VALUES ('Resolution', 'Revenge',  1916);
INSERT INTO Ships VALUES ('Revenge', 'Revenge',  1916);
INSERT INTO Ships VALUES ('Royal Oak', 'Revenge',  1916);
INSERT INTO Ships VALUES ('Royal Sovereign', 'Revenge',  1916);
INSERT INTO Ships VALUES ('Tennessee', 'Tennessee',  1915);
INSERT INTO Ships VALUES ('Washington', 'North Carolina',  1941);
INSERT INTO Ships VALUES ('Wisconsin', 'Iowa',  1940);
INSERT INTO Ships VALUES ('Yamato', 'Yamato',  1941);

INSERT INTO Battles VALUES ('Denmark Strait', '1941-05-24');
INSERT INTO Battles VALUES ('Guadalcanal', '1942-11-15');
INSERT INTO Battles VALUES ('North Cape', '1943-12-26');
INSERT INTO Battles VALUES ('Surigao Strait', '1944-10-25');

INSERT INTO Outcomes VALUES ('California', 'Surigao Strait',  'ok');
INSERT INTO Outcomes VALUES ('Kirishima', 'Guadalcanal',  'sunk');
INSERT INTO Outcomes VALUES ('Resolution', 'Denmark Strait',  'ok');
INSERT INTO Outcomes VALUES ('Wisconsin', 'Guadalcanal',  'damaged');
INSERT INTO Outcomes VALUES ('Tennessee', 'Surigao Strait',  'ok');
INSERT INTO Outcomes VALUES ('Washington', 'Guadalcanal',  'ok');
INSERT INTO Outcomes VALUES ('New Jersey', 'Surigao Strait',  'ok');
INSERT INTO Outcomes VALUES ('Yamato', 'Surigao Strait',  'sunk');
INSERT INTO Outcomes VALUES ('Wisconsin', 'Surigao Strait',  'damaged');
;

select * from Classes;
select * from Ships;
select * from Battles;
select * from Outcomes;
.headers off

SELECT "3----------";
.headers on
--put your code here
DELETE 
FROM Classes
WHERE
    displacement < 30000 OR
    numGuns < 8
;

select * from Classes;
select * from Ships;
.headers off

SELECT "4----------";
.headers on
--put your code here
DELETE 
FROM Battles
WHERE
    name = "Guadalcanal"
;

select * from Battles;
select * from Outcomes;
.headers off

SELECT "5----------";
.headers on
--put your code here
UPDATE Battles
SET 
    name = 'Strait of Surigao'
WHERE 
    name = 'Surigao Strait';
;

select * from Battles;
select * from Outcomes;
.headers off

SELECT "6----------";
.headers on
--put your code here
DELETE
FROM Ships
WHERE class IS NULL
;

select * from Ships;
select * from Outcomes;
.headers off
