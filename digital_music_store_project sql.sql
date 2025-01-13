-- Q1: who is the senior most employee based on job title? --

SELECT 
    *
FROM
    employee
ORDER BY levels DESC
LIMIT 1;

-- Q2: which countries have the most invoice? --

SELECT 
    billing_country, COUNT(*) AS invoice
FROM
    invoice
GROUP BY billing_country
ORDER BY invoice DESC
LIMIT 1;

-- Q3: what are top 3 values of total invoice --

SELECT 
    total
FROM
    invoice
ORDER BY total DESC
LIMIT 3;

-- Q4: which city has best customers? we would like to throw alter
-- promotional music festival in the city we made the most money write alter
-- query that returns one city that has the highest sum of invoice totals.
-- return both the city name & sum of all invoice totals

SELECT 
    billing_city, SUM(total) AS highest
FROM
    invoice
GROUP BY billing_city
ORDER BY highest DESC;

-- Q5: who is the best customer? the customer who has spent the most
-- money will be declared the best customer write a query that returns
-- the person who has spent the most money.

SELECT 
    c.first_name, last_name, SUM(i.total) AS most
FROM
    customer AS c
        JOIN
    invoice AS i ON c.customer_id = i.customer_id
GROUP BY c.first_name , last_name
ORDER BY most DESC limit 1;

-- Question set 2-moderate --

-- Q1: write query to return the email firt_name,last_name & genre
-- of all rock music listeners. return your list ordered alphabetically
-- by email starting with A

select c.first_name,c.last_name,c.email from customer as c
join invoice as i
on c.customer_id=i.customer_id
join invoice_line as il
on i.invoice_id=il.invoice_id
join track as t
on il.track_id=t.track_id
join genre as g
on t.genre_id=g.genre_id
where g.name='rock'
order by c.email;

-- Q2: let's invite the artist who have written the most rock music in
-- our dataset write a query that returns the artist name and total
-- track count of the top 10 rock band

select a.name,g.name from artist as a
join album2  as al
on a.artist_id=al.artist_id
join track as t
on al.album_id=t.album_id
join genre as g
on t.genre_id=g.genre_id
where g.name='track';

-- 

