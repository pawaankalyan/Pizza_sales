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

select a.artist_id,a.name,count(a.artist_id) as mostrock from artist as a
join album2  as al
on a.artist_id=al.artist_id
join track as t
on al.album_id=t.album_id
join genre as g
on t.genre_id=g.genre_id
where g.name like 'Rock'
group by a.artist_id
order by mostrock desc;

-- Q3:return all the track names that have a song length longer than --
-- the avgerage song length return the name and miliseconds for each --
-- track order by the song length with the longestsong listed first. --

SELECT 
    name, milliseconds AS song_length_longer
FROM
    track
WHERE
    milliseconds > (SELECT 
            AVG(milliseconds)
        FROM
            track)
ORDER BY milliseconds DESC;

-- question set 3-advance --

-- Q1: find how much amount spent by each customer on artist? write a query--
-- to return customer name artist name and total spent --

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    a.name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM
    customer AS c
        JOIN
    invoice AS i ON c.customer_id = i.customer_id
        JOIN
    invoice_line AS il ON i.invoice_id = il.invoice_id
        JOIN
    track AS t ON il.track_id = t.track_id
        JOIN
    album2 AS al ON t.album_id = al.album_id
        JOIN
    artist AS a ON al.artist_id = a.artist_id
GROUP BY c.customer_id , c.first_name , c.last_name , a.name
ORDER BY total_spent DESC;

-- Q2: we want to find out the most popular music genre for each country--
-- we detarmine the most populer genre as the genre with the highest amount--
-- of purchases write a query that returns each countryalong with the top genre--
-- for countries where the maximum number of purchases is shared return all genres--


-- Q3: write a query that detarmines the customer that has spent the most on misic--
-- for each countary write a query returns the country along with the top customer--
-- and how much they spent for countries where the top amount spent is shared provide--
-- all customers who spent this amount--
 
with total as(
select c.customer_id,c.first_name,c.last_name,i.billing_country,sum(i.total),
row_number() over(partition by i.billing_country order by sum(i.total) desc) as rn
from customer as c
join invoice as i
on c.customer_id=i.customer_id
group by c.customer_id,i.billing_country,c.first_name,c.last_name)
select * from total
where rn=1;