SELECT * FROM movie.imdb_movies;

create database movie;
use movie;

 create table imdb_movies(
    Poster_Link VARCHAR(500),
    Series_Title VARCHAR(255),
    Released_Year varchar(50),
    Certificate VARCHAR(50),
    Runtime VARCHAR(50),
    Genre VARCHAR(255),
    IMDB_Rating varchar(50),
    Overview varchar(2000),
    Meta_score varchar(50),
    Director VARCHAR(255),
    Star1 VARCHAR(255),
    Star2 VARCHAR(255),
    Star3 VARCHAR(255),
    Star4 VARCHAR(255),
    No_of_Votes varchar(60),
    Gross varchar(150)
);

describe imdb_movies ;

show variables like 'sequre_file_priv';

show global variables like 'local_infile' ; 

set global local_infile = 1;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\movie_imdb.csv"
INTO TABLE movie.imdb_movies
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWs;

select * from imdb_movies;

-- check the number of row.
select count(*) from imdb_movies;

-- 1. Find the top 5 highest-rated movies:

select series_title as movie ,imdb_rating from imdb_movies
order by imdb_rating desc
limit 5;

-- how many movies released in each year.

select Released_year,count(*) as movie_count from imdb_movies
where released_year != "PG"
group by Released_year
order by movie_count desc;

-- Year and there movies name

select Released_year, group_concat(series_title) as movie_name  from imdb_movies
group by Released_year
order by Released_year asc;

-- list all movies released after 2000 ,sorted by year.

select Released_year,series_title from imdb_movies
where Released_year > 2000
order by Released_year asc ;

-- Get the average IMDb rating of all movies :

select  Series_title,avg(IMDB_Rating) from imdb_movies
group by Series_title
order by Series_title asc ;

--  Count the number of movies with a rating above 8.0:

select count(*) as Rating from imdb_movies
where IMDB_Rating > 8.0 ;

-- . Find the total gross earnings of movies directed by David Lean:

select Director,sum(Gross)as total_gross from imdb_movies
where Director = 'David Lean';

--  Find the names of all actors who starred in the movie "The Shawshank Redemption"

select  Series_title , concat(Star1,' ,', Star2,' ,', Star3,' ,', Star4) as actors_name from imdb_movies
where Series_title = "The Shawshank Redemption" ;

--  Retrieve the movies with the highest box office earnings and show the release year.

select Series_title as Movies,  Gross as Highest_earing ,Released_Year  from imdb_movies
order by Gross desc
limit 5;

-- Retrieve a list of movies with a genre of "Comedy" and a rating greater than 8.

select Series_title as movie_name, Genre, IMDB_rating  from  imdb_movies
where IMDB_Rating >8  and  Genre = 'Comedy';

--  Get the list of actors who have appeared in more than 10 movies.

select  Star1 , count(Series_title)from imdb_movies
group by Star1
having count(Series_title) > 10 ;

select * from imdb_movies;

 --  Find the movies with the highest number of actors 
 
  select  Series_title,Star1,Star2,Star3,Star4 from imdb_movies
 order by Star1,Star2,Star3,Star4 desc
 limit 1;
 
-- List all movies that have an IMDb rating above 8.0 and were directed by " Ramesh Sippy"

select Series_title, IMDB_Rating, Director from imdb_movies
where Director= "Ramesh sippy" and IMDB_Rating > 8.0 ;

--  calculate the average IMDB rating  and the total of votes for movies director by "Francis Ford Coppola"

select Director,avg(IMDB_Rating) as avg,sum(No_of_Votes) as total_votes from imdb_movies
where Director = 'Francis Ford Coppola'
group by Director;

-- find the movies with a gross higher than the avg gross of all movieseries

select Series_title, Gross from imdb_movies
where Gross > (select avg(gross) from imdb_movies );


select Series_title,Gross from imdb_movies
order by Gross desc
limit 1 ;

-- . List the movies with a Meta score higher than 85 and an IMDB rating below 8.

select Series_title,  Meta_score, IMDB_Rating from  imdb_movies
where Meta_score > 85 and IMDb_Rating < 8;

--  Find the average gross earnings for movies with an IMDB rating above 8.5 and released before 1990.

select Released_year, IMDB_Rating, avg(Gross) from imdb_movies
 group by Released_year , IMDB_Rating
 having Released_year < 1990 and IMDB_Rating >8.5;
 
-- Identify the actors who appeared in more than 2 movies from this data

    select actor, count(*) as movie_count from
    ( select Star1 as actor from imdb_movies
    union all
    select Star2 as actor from imdb_movies
    union all
    select Star3 as actor from imdb_movies
    union all 
    select Star4 as actor from imdb_movies
    ) as all_actors
    group by actor
    having movie_count >2;
    
    select * from imdb_movies;
    
    -- Find the movie with the highest gross earnings per genre.
    
select Series_Title, Genre, max(Gross) as highest_gross from imdb_movies
group by  series_Title, Genre;

--  List the top 3 movies with the highest IMDB rating.

select Series_Title,IMDB_Rating from imdb_movies
order by IMDB_Rating desc
limit 3;

 -- Find all movies where "Drama" is one of the genres and their corresponding gross earnings.
 
 select Series_Title,Genre,Gross from imdb_movies
 where Genre = 'Drama';
 
  -- Find the director who directed the most number of movies with a rating above 8.
  
  select Director, IMDB_Rating, count(*) as movies from imdb_movies
  group by Director,IMDB_rating
 having IMDB_Rating > 8 
  order by movies desc
  limit 1 ;
  
  --   List all movies that have more than 1 million votes and a gross above 100 million.

select Series_Title,No_of_Votes,Gross from imdb_movies
where No_of_Votes > 1000000 and Gross > 100000000;

  -- Find the average runtime of movies per director.
  
select  Director,avg(Runtime)  from imdb_movies
group by Director
order by avg(Runtime) desc;

   -- List the movies that have been released after 2000 with a rating above 9.0.
   
   select Series_Title , IMDB_Rating, Released_Year from imdb_movies
   Where
    Released_Year > 2000 
    AND IMDB_Rating > 8;
   
   -- Find the average IMDB rating and Meta score for each genre.
   
   select Genre, avg(Meta_Score), avg(IMDB_Rating) from imdb_movies
   group by Genre, Meta_Score ;
   
-- Find the Movies Where the Director's Name Starts with "J"

select Director, Series_Title as movie_name from imdb_movies
where Director like 'J%';

-- Movies with a Budget Greater Than 10 Million and a Rating Over 7

select Series_Title as movie_name,Gross, IMDB_Rating from imdb_movies
where Gross > 10000000 and IMDB_Rating > 7 ;

  --  Movies that have been in Theaters for More Than 3 Months
  
  SELECT Series_Title, Released_Year, Genre, IMDB_Rating, Meta_score
FROM imdb_movies
WHERE 
    CAST(Released_Year AS UNSIGNED) < YEAR(CURDATE()) - 1;
  
  -- Movies Released in the Same Year with a Higher Rating Than the Movie
  
  select  Released_year, IMDB_Rating, count(Series_Title) from imdb_movies
  group by Released_year,IMDB_Rating
  order by Released_year, IMDB_Rating desc
  limit 5;
  
   --  Find Directors Who Have Worked with the Most Number of Different Actors
   
    select Director, count(*) as actor from imdb_movies
    group by Director
    order by actor desc;

    --  Find the Most Profitable Movies  and Rank Them.
    SELECT 
    Poster_link, Series_Title, Gross,
    Meta_score,
    (Meta_score - Gross) AS profit,
    RANK() OVER (ORDER BY (Meta_score - Gross) DESC) as movie_rank 
FROM 
    imdb_movies
ORDER BY 
  movie_rank ;

    select* from imdb_movies;
    
	-- Find the Average Rating for Each Director, But Only for Movies Released After 2000.
    
    select Director, Released_year, avg(IMDB_Rating) as avg_rating from imdb_movies
      where Released_year > 2000
      group by Director, Released_year;
  