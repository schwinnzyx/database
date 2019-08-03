/* @Schwin Zhang, my answers to the movie review challenges posted by 
Colt Steele in his Udemy Course: https://www.udemy.com/the-ultimate-mysql-bootcamp-go-from-sql-beginner-to-expert
*/
-- map reviews to their movie titles
SELECT 
  series.title,
  reviews.rating
FROM series 
JOIN reviews
	ON series.id = reviews.series_id
ORDER BY reviews.rating DESC;


-- average rating in ascending order
SELECT 
  series.title,
  AVG(reviews.rating) AS avg_rating
FROM series 
JOIN reviews
ON series.id = reviews.series_id
GROUP BY series.title
ORDER BY avg_rating;


-- map reviews to their reviewers
SELECT 
  reviewers.first_name,
  reviewers.last_name,
  reviews.rating
FROM reviewers
JOIN reviews
  ON reviewers.id = reviews.reviewer_id;


-- find unreviewed series
SELECT 
  series.title,
  reviews.rating
FROM series
LEFT JOIN reviews
ON series.id = reviews.series_id

WHERE reviews.rating IS NULL


-- find avg rating for each genre
SELECT 
  series.genre,
  AVG(reviews.rating)
FROM series 
JOIN reviews
  ON series.id = reviews.series_id

GROUP BY series.genre;


-- data analytics on user
SELECT 
  reviewers.first_name,
  reviewers.last_name,
  count(reviews.id) AS Count,
  IFNULL(min(rating),0) AS MIN,
  IFNULL(max(rating),0) AS MAX,
  IFNULL(avg(reviews.rating),0) AS AVG,
  IF(Count(reviews.id)>0, 'Active', 'Inactive') AS User_Status
FROM reviewers
LEFT JOIN reviews
  ON reviewers.id = reviews.reviewer_id

GROUP BY reviewers.id;


-- put all three tables together
SELECT 
  title,
  rating,
  CONCAT(first_name, ' ', last_name) AS name
FROM series, reviews, reviewers 
WHERE series.id = reviews.reviewer_id 
  AND reviewers.id = series.id;
