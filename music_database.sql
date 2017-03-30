CREATE TABLE people (
  id serial primary key,
  name varchar,
  profession varchar
);

CREATE TABLE album (
  id serial primary key,
  name varchar,
  year integer,
  people_id integer REFERENCES people (id)
);

CREATE TABLE track (
  id serial primary key,
  name varchar,
  duration interval minute to second,
  song_id integer REFERENCES song (id),
  album_id integer REFERENCES album (id)
);

CREATE TABLE song (
  id serial primary key,
  name varchar,
  people_id integer REFERENCES people (id)
);



--1 What are tracks for a given album?

select
	song.name, album.name
from
	album
inner join
	track
on
	track.album_id = album.id

inner join
	song
on
	track.song_id = song.id

where
	album.id = 2;



--2 What are the albums produced by a given artist?

select
	*
from
	album, people
where
	album.people_id = people.id;


--3 What is the track with the longest duration?

select
	song.name, track.duration
from
	track
inner join
	song
on
	track.song_id = song.id
where
	track.duration = (
		select
			max(duration)
 		from track);

--4 What are the albums released in the 60s? 70s? 80s? 90s?

select
	album.name, album.year
from
	album
where
	album.year < 2000;



--5 How many albums did a given artist produce in the 90s?

select
	*
from
	people
inner join
	album
on
	album.people_id = people.id
where
	album.year > 1989 and album.year < 2000;



--6 What is each artist's latest album?

select
	max(album.year), people.name
from
	album
inner join
	people
on album.people_id = people.id
group by
	people.id;


--7 List all albums along with its total duration based on summing the duration of its tracks.

select
	sum(track.duration), album.name
from
	album
inner join
	track
on
	track.album_id = album.id
group by
	album.name;


--8 What is the album with the longest duration?

select
	sum(track.duration), album.name
from
	album
inner join
	track
on
	track.album_id = album.id
group by
	album.name
order by
	sum desc
limit 1;


--9 Who are the 5 most prolific artists based on the number of albums they have recorded?

select
	people.name, count(people.id)
from
	album
right outer join
	people
on
	album.people_id = people.id
group by
	people.name
order by
	count desc
limit 5;


--10 What are all the tracks a given artist has recorded?  ******

select
	song.name, artist.name
from
	track
left outer join
	song
on
	track.song_id = song.id
left outer join
	people as artist
on
	song.artist_id = artist.id
where
	artist.id = 5;






--11 What are the top 5 most often recorded songs?

select
	song.name, count(song.id)
from
	track
left outer join
	song
on
	track.song_id = song.id
group by
	song.name
order by
	count desc
limit 5;


--12 Who are the top 5 song writers whose songs have been most often recorded?

select
	people.name,  count(song.id)
from
	track
inner join
	song
on
	track.song_id = song.id
inner join
	people
on
	song.people_id = people.id
group by
	people.name
order by
	count desc
limit 5;


--13 Who is the most prolific song writer based on the number of songs he has written? ******?


select
	count(song.id), people.name
from
	track
left outer join
	song
on
	track.song_id = song.id
left outer join
	people
on
	song.people_id = people.id
group by
	people.name
order by
	count desc
limit 1;


--14 What songs has a given artist recorded?

select
	song.name, people.name
from
	song
left outer join
	people
on
	song.artist_id = people.id
where
	people.id = 2;


--15 Who are the song writers whose songs a given artist has recorded? ******?


select
	songwriter.name
from
	album
inner join
	people as artist
on
	album.people_id = artist.id
inner join
	track
on
	track.album_id = album.id
inner join
	song
on
	track.song_id = song.id
inner join
	people as songwriter
on
	songwriter.id = song.people_id
where artist.name = 'Madonna';






--16 Who are the artists who have recorded a given song writer's songs?


select
	artist.name, songwriter.name
from
	album
inner join
	people as artist
on
	album.people_id = artist.id
inner join
	track
on
	track.album_id = album.id
inner join
	song
on
	track.song_id = song.id
inner join
	people as songwriter
on
	song.people_id = songwriter.id
where
	songwriter.name = 'Bob Thornton';
