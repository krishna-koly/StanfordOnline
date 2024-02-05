-- Stanford Excercise ==

-- 01. Find the titles of all movies directed by Steven Spielberg.
#Solution :-

select title
from Movie
where director = 'Steven Spielberg';

-- 02. Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
#Solution
select year
from Movie
join Rating using(mID)
where stars = 4 or stars = 5
group by year
order by year;

-- 03 -- Find the titles of all movies that have no ratings
#Solution 
select title
from Movie
where mID not in (select mID from Rating);

-- 04-- Some reviewers didn't provide a date with their rating. 
#Find the names of all reviewers who have ratings with a NULL value for the date.
#Solution

select name
from Reviewer 
join Rating using (rID)
where ratingDate is null;

-- 05 -- Write a query to return the ratings data in a more readable format: 
#reviewer name, movie title, stars, and ratingDate. Also, sort the data, 
#first by reviewer name, then by movie title, and lastly by number of stars
#Solution 

select rd.name,m.title,r.stars,r.ratingDate
from Movie m
join Rating r using (mID)
join Reviewer rd on rd.rID = r.rID
order by rd.name,m.title,stars;
-- 06 -- For all cases where the same reviewer rated the same movie twice and 
# gave it a higher rating the second time, return the reviewer's name and the title of the movie.
#Solution
SELECT name, title
FROM Movie
INNER JOIN Rating R1 USING(mId)
INNER JOIN Rating R2 USING(rId)
INNER JOIN Reviewer USING(rId)
WHERE R1.mId = R2.mId AND R1.ratingDate < R2.ratingDate AND R1.stars < R2.stars;

-- 07 --For each movie that has at least one rating, find the highest number of stars that movie received.
# Return the movie title and number of stars. Sort by movie title
#Solution
select m.title, max(stars) as num_of_rating
from movie m
join rating r using (mID)
group by m.title
having count(stars)>=1;

-- 08 -- For each movie, return the title and the 'rating spread', that is, the difference between highest 
#and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.
#Solution 

select m.title,(max(r.stars) - min(r.stars)) as rating_spread
from movie m
join rating r using (mID)
group by m.title
order by rating_spread desc, m.title;

-- 9 -- Find the difference between the average rating of movies released before 1980 and
-- the average rating of movies released after 1980. 
 -- (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)
#Solution
select max(a1)-min(a1) from
(select avg(av1) a1 from
(select avg(stars) av1 from rating r join movie m on r.mid=m.mid where m.year < 1980
group by r.mid)
union
select avg(av2) a1 from
(select avg(stars) av2 from rating r join movie m on r.mid=m.mid where m.year > 1980
group by r.mid))






