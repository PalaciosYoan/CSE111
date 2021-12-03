PRAGMA foreign_keys = on;

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
    ship CHAR(32) REFERENCES Ships(name) ON DELETE CASCADE,
    battle CHAR(32) REFERENCES Battles(name) ON DELETE CASCADE,
    result CHAR(32),
    CHECK (result IN ('ok', 'sunk', 'damaged'))
)
;
.headers off

SELECT "2----------";
.headers on
--put your code here
;

select * from Classes;
select * from Ships;
select * from Battles;
select * from Outcomes;
.headers off

SELECT "3----------";
.headers on
--put your code here
;

select * from Classes;
select * from Ships;
.headers off

SELECT "4----------";
.headers on
--put your code here
;

select * from Battles;
select * from Outcomes;
.headers off

SELECT "5----------";
.headers on
--put your code here
;

select * from Battles;
select * from Outcomes;
.headers off

SELECT "6----------";
.headers on
--put your code here
;

select * from Ships;
select * from Outcomes;
.headers off
