use sakila;
-- 1a. 
select first_name, last_name from actor;
-- 1b. 
select concat(first_name," ",last_name) as "Actor Name" from actor;
-- 2a. 
select actor_id, first_name, last_name from actor where first_name = "Joe";
-- 2b.
select actor_id, first_name, last_name from actor where last_name like "%GEN%";
-- 2c. 
select last_name, first_name from actor where last_name like "%LI%" order by last_name, first_name;
-- 2d. 
select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');
-- 3a.
alter table actor add column description blob(255);
select * from actor;
-- 3b. 
alter table actor drop column description;
-- 4a.
select last_name, count(last_name) as "Last Name Count" from actor group by last_name;
-- 4b. 
select last_name, count(last_name) as "Last Name Count" from actor
group by last_name having count(last_name)>=2; 
-- 4c.
update actor set first_name = "HARPO" where first_name = "GROUCHO"
and last_name = "WILLIAMS";
-- 4d. 
update actor set first_name = "GROUCHO" where actor_id = 172;
-- 5a. 
show create table address; 
-- 6a. 
select staff.first_name, staff.last_name, address.address from staff
join address on staff.address_id = address.address_id join city on address.city_id = city.city_id 
join country on city.country_id = country.country_id;
-- 6b.
select staff.first_name, staff.last_name, sum(payment.amount) as revenue_received from staff 
join payment on staff.staff_id = payment.staff_id 
where payment.payment_date like '2005-08%' group by payment.staff_id;
-- 6c. 
select title as "Film Title", count(actor_id) as "Number of Actors" from film f
join film_actor fa
on f.film_id = fa.film_id
group by  title;
-- 6d. 
select title, count(inventory_id) from film f
join inventory i on f.film_id = i.film_id
where title = "Hunchback Impossible";
-- 6e. 
select first_name, last_name, sum(amount) as "Total Amount Paid"
from customer c join payment p 
on c.customer_id= p.customer_id
group by last_name;
-- 7a. 
select title from film where title 
like"K%" or title LIKE "Q%"
and title in (select language_id 
	from language
	where name = "English");
-- 7b. 
select first_name, last_name from actor where actor_id in 
(select actor_id from film_actor where film_id in
(select film_id from film where title = "Alone Trip"));
-- 7c. 
select first_name, last_name, email from customer cus
join address a on (cus.address_id = a.address_id)
join city cty on (cty.city_id = a.city_id)
join country on (country.country_id = cty.country_id)
where country.country= "Canada";
-- 7d. 
select title, description from film where film_id IN
(select film_id from film_category where category_id in
(select category_id from category
where name = "Family"));
-- 7e.
select i.film_id, f.title, count(r.inventory_id) from inventory i
join rental r on i.inventory_id = r.inventory_id
join film_text f on i.film_id = f.film_id
group by r.inventory_id
order by count(r.inventory_id) desc;
-- 7f. 
select s.store_id, sum(amount) from payment p
join rental r on (p.rental_id = r.rental_id)
join inventory i on (i.inventory_id = r.inventory_id)
join store s on (s.store_id = i.store_id)
group by s.store_id; 
-- 7g. 
select s.store_id, cty.city, country.country from store s
join address a on (s.address_id = a.address_id)
join city cty on (cty.city_id = a.city_id)
join country on (country.country_id = cty.country_id);
-- 7h.
select c.name as "Genre", sum(p.amount) as "Gross" 
from category c join film_category fc on (c.category_id=fc.category_id)
join inventory i on (fc.film_id=i.film_id)
join rental r on (i.inventory_id=r.inventory_id)
JOIN payment p 
ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross LIMIT 5;
-- 8a. 
create view top_five_genre as
select c.name as 'Genre', sum(p.amount) as 'Gross' from category c
join film_category fc on (c.category_id=fc.category_id)
join inventory i on (fc.film_id=i.film_id)
join rental r on (i.inventory_id=r.inventory_id)
join payment p on (r.rental_id=p.rental_id)
group by c.name order by Gross  limit 5;
-- 8b.
select * from top_five_genre;
-- 8c. 
drop view top_five_genre;
