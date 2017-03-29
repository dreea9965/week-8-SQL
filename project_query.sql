--What are all projects that use Python?

select *
from project, project_uses_tech, tech
where tech.id = 4;


--What are all technologies used by the Personal Website?


select distinct on (
	project.name, tech.name) *
from
	project_uses_tech, tech, project
where project.id = 4;


--Perform a left outer join from the tech table to the project_uses_tech table - which techs has no associated project?

select *
from tech
left outer join project_uses_tech
on project_uses_tech.tech_id = tech.id
where tech_id is null;

--Based on the previous query, get the count of the number of techs used by each project.

select
	count(tech.id), tech.name

from
	tech
left outer join
	project_uses_tech
on
	project_uses_tech.tech_id = tech.id

group by
	tech.name;

--Perform a left outer join from the project table to the project_users_tech table - which projects has no associated tech?

select *
from tech
left outer join project_uses_tech
on project_uses_tech.tech_id = tech.id
where tech_id is null;

--List all projects along with each technology used by it. You will need to do a three-way join.

select *
from
 project_uses_tech
left outer join
	project
on
	project_uses_tech.project_id = project.id
left outer join
	tech
on project_uses_tech.tech_id = tech.id;

--List all the distinct techs that are used by at least one project.

select
	distinct (tech.name)
from tech
left outer join
project_uses_tech
on project_uses_tech.tech_id = tech.id
where tech_id > 1;


--List all the distinct techs that are not used by any projects.

select
	distinct (tech.name)
from
	tech
left outer join
	project_uses_tech
on
	project_uses_tech.tech_id = tech.id
where
	tech_id is null;


--List all the distinct projects that use at least one tech.

select
	distinct (project.name)
from
	project
right outer join
	project_uses_tech
on
	project_uses_tech.project_id = project.id
where
	tech_id >= 1;

--List all the distinct projects that use no tech.

select distinct (project.name)
from
	project
left outer join
	project_uses_tech
on
	project_uses_tech.project_id = project.id
where
	tech_id is null;

--Order the projects by how many tech it uses.


select
	*
from
		(select count(tech_id), project.name
	from
		project
	left outer join
		project_uses_tech
	on
		project_uses_tech.project_id = project.id
	group by
		project.id) as order_tech
order by
	count;




--Order the tech by how many projects use it.

select *
from
	(select count(project_id), tech.name
	from
		tech
	left outer join
		project_uses_tech
	on
		project_uses_tech.tech_id = tech.id
	group by
		tech.id) as order_project
order by
	count;




-- What is the average number of techs used by a project?

select
	avg(count)
from
	(select
		count(project_id), tech.name
from
	tech
left outer join
	project_uses_tech
on
	project_uses_tech.tech_id = tech.id
group by
	tech.id) as order_project;
