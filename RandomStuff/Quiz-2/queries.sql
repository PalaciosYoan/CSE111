
.header on
-- 1 : What makers produce Laptops cheaper than $2000 with a screen larger than 16?
SELECT Product.maker
FROM Product, Laptop
WHERE
    Product.model = Laptop.model AND
    screen > 16 AND
    price < 2000;

--2: What makers produce PCs but do not produce Laptops?


SELECT Product.maker
    FROM Product
    WHERE
        type = 'pc'
EXCEPT
SELECT Product.maker
    FROM Product
    WHERE
        type = 'laptop';

--3 For every maker that sells both PCs and Printers, 
    -- find the combination of PC and Printer that hasmaximum price.  
    -- Print the maker, the PC model, Printer model, and the combination price (PC price+ Printer price)
SELECT
        pd1.maker,
        PC.model as pc_model, 
        printers.model as printers_model,
        MAX(PC.price + printers.price) as combo

FROM 
        Product pd1,
        Product pd2, 
        Printer printers, 
        PC
WHERE
        pd1.maker = pd2.maker AND
        pd1.model = PC.model AND
        pd2.model = printers.model 
GROUP BY
        pd1.maker;

--4:  What Laptop hd sizes are offered in at least 2 different models?
SELECT 
        lt.hd
FROM 
        Laptop lt
GROUP BY 
        lt.hd
having 
        COUNT(lt.hd) > 1;

--5:  What PCs are less expensive than all the Laptops?  
        -- Print the model and the price.
SELECT PC.model, PC.price
FROM Laptop, PC
GROUP BY PC.model, PC.price
HAVING PC.price < MIN(Laptop.price);
-- SELECT 
--         pc.model, 
--         pc.price
-- FROM 
--         PC pc
-- WHERE 
--         pc.price < (
--                         SELECT MIN(price)
--                         FROM Laptop
--                         );

--6: What makers produce at least a Laptop model and at least 2 Printer models?

SELECT  
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
