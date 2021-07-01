USE sakila;
-- 1. Drop column `picture` from `staff`.
ALTER TABLE staff
DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO staff ('first_name', 'last_name', 'address_id', 'email', 'store_id', 'active', 'username','password', 'last_update') 
VALUES ('Tammy', 'Sanders', 79, 'Tammy.Sanders@sakilastaff.com', 2, 1, 'Tammy', NULL, 2006-02-15 04:57:20);

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

    -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:
   -- 4.1 Check if there are any non-active users
SELECT count(*) FROM customer
WHERE active = false;

   -- 4.2 Create a table _backup table_ as suggested
CREATE TABLE _backup_table_ (
customer_id INT(11) UNIQUE NOT NULL,
email VARCHAR(50) DEFAULT NULL,
date INT(11) DEFAULT NULL,
CONSTRAINT PRIMARY KEY (customer_id)
);

   -- 4.3 Insert the non active users in the table _backup table_
INSERT INTO _backup_table_ (customer_id, email)
SELECT customer_id, email
FROM customer
WHERE active = false;

   -- 4.4 Delete the non active users from the table _customer_
DELETE FROM customer
WHERE active = false;
-- I get an error on safe update mode