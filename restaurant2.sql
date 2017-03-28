CREATE TABLE restaurant (
  id serial primary key,
  name varchar,
  address varchar,
  category varchar,
);

CREATE TABLE reviewer (
  id serial primary key,
  name varchar,
  e-mail varchar,
  karma integer,
  check (karma =< 7 and karma >= 0)
);

CREATE TABLE review (
  id serial primary key,
  reviewer_ID integer REFERENCES review (id),
  stars integer,
  CHECK (stars >= 0 and stars <= 5),
  title varchar,
  review varchar,
  restaurant_id integer REFERENCES restaurant (id)
);


--List all the reviews for a given restaurant given a specific restaurant ID.


select * from review where restaurant_id = 10;

--List all the reviews for a given restaurant, given a specific restaurant name.


select * from review inner join restaurant on review.restaurant_id = restaurant.id where restaurant.name = 'Piu Bello';

--List all the reviews for a given reviewer, given a specific author name.

select * from review where reviewer_id = 1;

--List all the reviews along with the restaurant they were written for. In the query result, select the restaurant name and the review text.

select * from review, restaurant where review.restaurant_id = restaurant.id;

--Get the average stars by restaurant. The result should have the restaurant name and its average star rating.

select avg(stars), restaurant.name from review inner join restaurant on review.restaurant_id = restaurant.id group by restaurant.name;

--Get the number of reviews written for each restaurant. The result should have the restaurant name and its review count.

select count(review), restaurant.name from review inner join restaurant on review.restaurant_id = restaurant.id group by restaurant.name;

--List all the reviews along with the restaurant, and the reviewer's name. The result should have the restaurant name, the review text, and the reviewer name.
--Hint: you will need to do a three-way join - i.e. joining all three tables together.

select restaurant.name, reviewer.name from review right outer join reviewer on review.reviewer_id = reviewer.id left outer join restaurant on review.restaurant_id = restaurant.id;


--Get the average stars given by each reviewer. (reviewer name, average star rating)

select avg(stars), reviewer.name from review inner join reviewer on review.reviewer_id = reviewer.id;
