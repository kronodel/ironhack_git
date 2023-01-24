USE ironhack_examples;


/*    What are the different genres?

    Which is the genre with the most apps rated?

    Which is the genre with most apps?

    Which is the one with least?

    Find the top 10 apps most rated.

    Find the top 10 apps best rated by users.

    Take a look at the data you retrieved in question 5. Give some insights.

    Take a look at the data you retrieved in question 6. Give some insights.

    Now compare the data from questions 5 and 6. What do you see?

    How could you take the top 3 regarding both user ratings and number of votes?

    Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
*/

select * from applestore;
select prime_genre, count(*)
from applestore
group by prime_genre;

-- 1 What are the different genres?

SELECT DISTINCT prime_genre FROM applestore;

-- 2 Which is the genre with the most apps rated?

SELECT prime_genre, COUNT(rating_count_tot) FROM applestore GROUP BY prime_genre ORDER BY COUNT(rating_count_tot) DESC LIMIT 1;


-- 3 Which is the genre with most apps?

SELECT prime_genre, COUNT(*) FROM applestore GROUP BY prime_genre ORDER BY COUNT(*) DESC LIMIT 1;

-- 4 Which is the one with least?

SELECT prime_genre, COUNT(*) FROM applestore GROUP BY prime_genre ORDER BY COUNT(*) ASC LIMIT 1;
Find the top 10 apps most rated.

-- 5 Find the top 10 apps best rated by users.

SELECT track_name, rating_count_tot FROM applestore ORDER BY rating_count_tot DESC LIMIT 10;

-- 6 Take a look at the data you retrieved in question 5. Give some insights.

SELECT track_name, user_rating FROM applestore ORDER BY user_rating DESC LIMIT 10;

-- 7 Take a look at the data you retrieved in question 6. Give some insights.

-- 8 Now compare the data from questions 5 and 6. What do you see?

(SELECT track_name, rating_count_tot, user_rating
FROM applestore
ORDER BY rating_count_tot DESC, user_rating DESC
LIMIT 10)

UNION

(SELECT track_name, rating_count_tot, user_rating
FROM applestore
ORDER BY rating_count_tot ASC, user_rating DESC
LIMIT 10);


-- 9 How could you take the top 3 regarding both user ratings and number of votes?



-- 10 Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?

SELECT track_name, rating_count_tot, user_rating FROM applestore ORDER BY rating_count_tot DESC LIMIT 3;