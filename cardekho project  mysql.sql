-- read car data

SELECT 
    *
FROM
    cardekho;
    
-- total cars: to get a count of total records

SELECT 
    COUNT(name)
FROM
    cardekho;
    
-- the manager asked the employee how many cars is available in 2023

SELECT 
    COUNT(*), year AS count
FROM
    cardekho
WHERE
    year = 2023;

-- the manager asked the employee how many cars is available in 2020,2021,2022

SELECT 
    COUNT(name) AS count, year
FROM
    cardekho
WHERE
    year IN (2020 , 2021, 2022)
GROUP BY year
ORDER BY year , count;

-- clint asked me to print the total of all cars by year.I don't see all the details.

SELECT 
    year, COUNT(name) AS count
FROM
    cardekho
GROUP BY year
ORDER BY count DESC;

-- clint asked to car dealer agent how many diesel cars will there be in 2020?

SELECT 
    year, COUNT(fuel) AS fuel
FROM
    cardekho
WHERE
    year = 2020 AND fuel = 'diesel'
GROUP BY year;

-- clint requested a car dealer agent how many petrol cars will there be in 2020?

SELECT 
    year, COUNT(fuel) AS fuel
FROM
    cardekho
WHERE
    year = 2020 AND fuel = 'petrol'
GROUP BY year;

-- the manager told the employee to give a print all the fuel cars
-- (petrol,diesel and CNG) com by all year.

SELECT 
    year, COUNT(*)
FROM
    cardekho
WHERE
    fuel IN ('petrol' , 'diesel', 'CNG')
GROUP BY year;

-- manager said there were more than 100 cars in a given year,which year had
-- more than 100 cars?

SELECT 
    year, COUNT(name) AS cars
FROM
    cardekho
GROUP BY year
HAVING COUNT(name) > 100;

-- the manager said to the employee all cars count details between 2015 and 2023;
-- we need a complete list.

SELECT 
    COUNT(*) AS count
FROM
    cardekho
WHERE
    year BETWEEN 2015 AND 2023;
    
-- the manager said to the employee all cars details between 2015 to 2023;
-- need complete list

SELECT 
    *
FROM
    cardekho
WHERE
    year BETWEEN 2015 AND 2023;