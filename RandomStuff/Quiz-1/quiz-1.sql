-- SQLite
.headers on


--1
SELECT 
        Product.maker
FROM 
        Product
INNER JOIN 
        Printer on Printer.model = Product.model
WHERE 
        price < 120 AND
        Printer.color = 1;


--2
SELECT DISTINCT 
        Product.maker
FROM 
        Product
WHERE 
        type = 'pc' AND 
        Product.maker NOT IN 
                        (SELECT 
                                Product.maker 
                        FROM  
                                Product 
                        WHERE 
                                type = 'laptop' OR 
                                type = 'printer');

--3

SELECT
        pd1.maker,
        PC.model as pc_model, 
        lt.model as lt_model,
        MAX(PC.price + lt.price) as combo

FROM 
        Product pd1,
        Product pd2, 
        Laptop lt, 
        PC
WHERE
        pd1.maker = pd2.maker AND
        pd1.model = PC.model AND
        pd2.model = lt.model 
GROUP BY
        pd1.maker;


--4
SELECT DISTINCT 
        lt.screen
FROM 
        Laptop lt
GROUP BY 
        lt.screen
having 
        COUNT(lt.screen) > 1;

--5

SELECT 
        lp.model, 
        lp.price
FROM 
        Laptop lp
WHERE 
        lp.price > (
                        SELECT MAX(price)
                        FROM PC
                        );

--6

SELECT DISTINCT 
        pd.maker
FROM 
        Product pd
WHERE 
        type = 'pc'
AND 
        pd.maker IN 
                (
                SELECT pd.maker 
                FROM Product pd
                WHERE type = 'printer'
                )

UNION ALL

SELECT DISTINCT 
        pd.maker
FROM 
        Product pd
WHERE 
        type = 'laptop' AND 
        pd.maker IN 
                (
                SELECT pd.maker 
                FROM Product pd 
                WHERE type = 'printer'
                )

INTERSECT

SELECT 
        pd.maker 
FROM 
        Product pd
WHERE 
        type = 'printer'
GROUP BY 
        maker
HAVING 
        COUNT(pd.type) > 1;
