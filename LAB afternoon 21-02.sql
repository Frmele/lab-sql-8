#Rank films by length (filter out the rows that have nulls or 0s in length column).
 #In your output, only select the columns title, length, and the rank.
 select*from sakila.film;
 

select title, length, rank() over(order by length desc) as 'Rank'
from sakila.film
where length<>0;

#Rank films by length within the rating category (filter out the rows
#that have nulls or 0s in length column). In your output, only select the columns title,
 #length, rating and the rank.
 
 
#select rating,title, length, rank() over(order by length desc) as 'Rank'
#from sakila.film
#group by rating
#having length<>0;

#group by was giving 5 rows while partition was better

select title, rating, length, rank() over(partition by rating order by length desc) as 'Rank'
from sakila.film
having length<>0;

 
#How many films are there for each of the categories in the category table. 
#Use appropriate join to write this query
select c.category_id, c.name, count(f.film_id) as no_of_films from sakila.category as c
join sakila.film_category as f
on c.category_id = f.category_id
group by c.category_id
order by c.category_id;



#Which actor has appeared in the most films? film and film_actor
select count(f.film_id) as no_film, a.actor_id, a.first_name, a.last_name from sakila.actor as a
join sakila.film_actor as f
on a.actor_id = f.actor_id
group by f.actor_id
order by no_film desc
LIMIT 1;


#Most active customer (the customer that has rented the most number of films) customer_id from rental
select a.first_name,a.last_name,a.customer_id,count(f.customer_id) as number_rental from sakila.customer as a
join sakila.rental as f
on a.customer_id = f.customer_id
group by f.customer_id
order by count(f.customer_id) desc
LIMIT 1;
#Bonus: Which is the most rented film? The answer is Bucket Brotherhood 
#This query might require using more than one join statement. Give it a try. 
#We will talk about queries with multiple join statements later in the lessons.