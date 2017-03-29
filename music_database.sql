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
