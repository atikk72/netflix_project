-- 1. Count the number of Movies vs TV Shows
select type from netfilx

select type ,count(*) as movie_vs_tv_show
from netfilx
group by type

-- 2. Find the most common rating for movies and TV shows
select new_t.type,new_t.rating,new_t.rank
from
( select type,rating,
		 count(*), rank() over(partition by type order by count(*)desc)
			 from netfilx
			 group by type,rating)new_t
			where rank =1;
			
3. List all movies released in a specific year (e.g., 2020)

	select title,release_year from netfilx
	where release_year =2020
	group by title,release_year


select title,type,release_year
from netfilx
where release_year=2020 and type='Movie'
group by 2,1,3

4. Find the top 5 countries with the most content on Netflix
select * from netfilx

select count(type)as most_content ,country
from netfilx
group by country
order by most_content  desc
limit 5;

5. Identify the longest movie
select * from netfilx
select type , title,duration from netfilx
where type ='Movie'
order by 3 desc

select type,title,max(duration) as max_duration
from netfilx
where type='Movie'
group by 1,2
order by max_duration desc

6. Find content added in the last 5 years

select * from netfilx

select  title,type, max(release_year)last_5_yr from netfilx
where release_year >2017
group by 1,2
order by last_5_yr desc

-- select  title,date_added,release_year
-- from netfilx
-- where release_year >2018

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select type ,director
from netfilx
where director ='Rajiv Chilaka'

-- 8. List all TV shows with more than 5 seasons

select type ,duration from netfilx
	where type='TV Show' and duration> '5 Seasons'

-- 9. Count the number of content items in each genre
select listed_in ,count(*)genre_count
	from netfilx
	group by 1
	order by genre_count desc
	
	
-- 10.Find each year and the average numbers of content release in India on netflix. 
-- return top 5 year with highest avg content release!

		select type,release_year,   count(type) as avg_content
		from netfilx
		where country ='India'
		group by 1,2
		order by avg_content desc
		limit 5
		
-- 11. List all movies that are documentaries

			select type, title,listed_in
			from netfilx
			where type ='Movie' and listed_in ='Documentaries'
			
		
-- 12. Find all content without a director

		select title, director from netfilx
				where director is null
	

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select * from netfilx

select t.casts , t.bhai_year from (
			select type ,casts,release_year as bhai_year
			from netfilx
			where type='Movie' and casts like 'Salman%' and release_year>2013)t;
			

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select * from netfilx
-- select count(casts)actor_count, count(type), type,country
-- from netfilx
-- where country ='India'
-- group by 3,4



select casts,country,count(type),
rank() over(partition by type order by casts)
from netfilx
where country ='India'
group by type,1,2
limit 10;

select count(type) ,casts,country,listed_in
from netfilx
where type='Movie' and country='India'
group by 2,3,4
order by 1 desc
limit 10;


--  15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 


select *,
   case 
   when
   description ilike '%Kill%%' or
   description ilike '%Voilence%' then 'bad_content'
   else 'Good_content'
   end category
   from netfilx
   
     