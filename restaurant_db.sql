CREATE TABLE restaurant (
  id serial primary key,
  name varchar,
  distance_in_miles_from_ATV integer,
  stars integer,
  favorite_dish varchar,
  does_takeout varchar,
  last_time_you_ate_there date
);

delete from restaurant;

insert into restaurant values
  (default,'Fellinis', 1, 5, 'pizza', 'yes', '2017-03-20');

insert into restaurant values
  (default, 'Kroger', 1, 4, 'mac&cheese', 'yes', '2016-12-2');

insert into restaurant values
  (default, 'Jasons Deli', 1, 3, 'soup', 'yes', '2017-03-2');

insert into restaurant values
  (default, 'Tacos', 10, 5, 'taco', 'yes', '2017-02-20');

insert into restaurant values
  (default, 'Chicken and the Egg', 20, 5, 'breakfast', 'yes', '2017-02-25');



select name from restaurant where stars = 5;
select favorite_dish from restaurant where stars = 5;

\! echo "id of fellinis:"
select id from restaurant where name = 'Fellinis';
select name from restaurant where does_takeout = 'yes';
select name from restaurant where distance_in_miles_from_ATV < 2;
select name from restaurant where last_time_you_ate_there > '2017-03-01';
select name from restaurant where last_time_you_ate_there <  '2017-03-01' and stars = 5;
