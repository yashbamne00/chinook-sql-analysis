
use chinook;

/*-- Get all invoices with customer names */

Select customer.FirstName, invoice.InvoiceId from invoice
join customer on customer.CustomerId = invoice.CustomerId
order by invoice.CustomerId;

/*-- List tracks with their genres */

Select genre.Name, track.Name from track
join genre on genre.GenreId = track.GenreId
order by genre.GenreId;

/*-- Countries with more than 5 customers */

select customer.Country, sum(CustomerId) as total
from customer
group by Country
having total > 5;

/*-- Label customers as 'Domestic' or 'International' */

select customer.FirstName, 
case
when Country = "USA"
then "domestic"
else "international"
end as type
from customer;


/*-- Customers who made the highest invoice */

select FirstName from customer
where CustomerId = (
select CustomerId from invoice
order by Total DESC 
Limit 1);


/*Buisness idea questions*/


/*Q1: Total Sales by Artist */

select artist.Name 
as Artist_name , 
sum( invoiceline.UnitPrice * invoiceline.Quantity) 
as total_sales
from invoiceline
join track 
on track.TrackId = invoiceline.TrackId
join album 
on album.AlbumId = track.AlbumId
join artist 
on artist.ArtistId = album.ArtistId
group by artist.Name;


/*Q2: Most Purchased Album */

select album.Title from album
where AlbumId = (
Select AlbumId from track 
where TrackId = (
Select TrackId from invoiceline
order by Quantity Desc
Limit 1));


/*Q3: Revenue by Country */

Select customer.Country 
as Desired_country, 
sum(invoice.total) 
as Total_Invoices 
from invoice
join customer 
on customer.CustomerId = invoice.CustomerId
group by country
order by sum(invoice.total)
Limit 20;

