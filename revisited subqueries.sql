-- 1.Select the first name, last name, and email address of all the customers who have rented a movie.
select distinct(concat(first_name, ' ' ,last_name)) as customer, email from rental
join sakila.customer using (customer_id)


-- 2.What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
-- Write the query using multiple join statements
-- Write the query using sub queries with multiple WHERE clause and IN condition
-- Verify if the above two queries produce the same results or not

select distinct(customer_id), concat(first_name, ' ' ,last_name) as customer_name , avg(amount)from sakila.customer
join sakila.payment using (customer_id)
group by customer_id

-- 3.Select the name and email address of all the customers who have rented the "Action" movies.
select distinct(concat(first_name, ' ' ,last_name)) as customer, email from rental
join sakila.customer using (customer_id)
join sakila.inventory using (inventory_id)
join sakila.film_category using (film_id)
join sakila.category using (category_id)


or 


select concat(c.first_name, ' ' ,c.last_name) as customer, email from customer c
where c.customer_id in  
	(select r.customer_id  from sakila.rental r
	where r.inventory_id in 
		(select i.inventory_id from sakila.inventory i
		 where i.film_id in 
			(select fc.film_id from sakila.film_category fc
			  where fc.category_id in 
				(select cat.category_id from sakila.category cat
				  where name = 'ACTION'
                  )
				)
			)
          )


-- 4.Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment.
-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

SELECT payment_id, customer_id, staff_id,rental_id,amount, case 
when amount between 0 and 2  then 'Low'
when amount between 2 and 4 then 'Medium'
when amount > 4 then 'High'
end as transaction_classification
 from payment 
