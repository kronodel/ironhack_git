-- LAB 22
-- Challenge 1 - Most Profiting Authors
USE ppub;

/*Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication
*/

SELECT titleauthor.title_id, titleauthor.au_id, titles.advance * titleauthor.royaltyper / 100 as advance, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON titles.title_id = sales.title_id
GROUP BY title_id;

/*Step 2: Aggregate the total royalties for each title and author
*/

SELECT titleauthor.title_id, titleauthor.au_id,
(SELECT SUM(titles.advance * titleauthor.royaltyper / 100 + titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)
FROM titleauthor
LEFT JOIN titles 
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales 
ON titles.title_id = sales.title_id) AS aggregated_royalties
FROM titleauthor
GROUP BY titleauthor.title_id, titleauthor.au_id;

/*Step 3: Calculate the total profits of each author

Now that each title has exactly one row for each author where the advance and royalties are available, we are ready to obtain the eventual output. Using the output from Step 2, write a query, containing two subqueries, to obtain the following output:

    Author ID
    Profits of each author by aggregating the advance and total royalties of each title

Sort the output based on a total profits from high to low, and limit the number of rows to 3.
*/

SELECT au_id, SUM(advance + aggregated_royalties) AS profits
FROM (
  SELECT titleauthor.au_id,
  (SELECT SUM(titles.advance * titleauthor.royaltyper / 100) FROM titleauthor LEFT JOIN titles ON titleauthor.title_id = titles.title_id) AS advance,
  (SELECT SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) FROM titleauthor LEFT JOIN titles ON titleauthor.title_id = titles.title_id LEFT JOIN sales ON titles.title_id = sales.title_id) AS aggregated_royalties
  FROM titleauthor
  GROUP BY titleauthor.au_id
) AS author_profits
GROUP BY au_id
ORDER BY profits DESC
LIMIT 3;

-- Challenge 2 - Alternative Solution

/*In the previous challenge, you have developed your solution the following way:

    Derived tables (subqueries).

We'd like you to try the other way:

    Creating MySQL temporary tables and query the temporary tables in the subsequent steps.*/

-- Creating a temporary table to store the royalties for each sale for each author and the advance for each author and publication
CREATE TEMPORARY TABLE royalties_advance AS
SELECT titleauthor.title_id, titleauthor.au_id, titles.advance * titleauthor.royaltyper / 100 as advance, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON titles.title_id = sales.title_id;

-- Creating a temporary table to store the aggregated royalties for each title and author
CREATE TEMPORARY TABLE aggregated_royalties AS
SELECT royalties_advance.title_id, royalties_advance.au_id, SUM(royalties_advance.advance + royalties_advance.sales_royalty) as royalties
FROM royalties_advance
INNER JOIN titleauthor
ON royalties_advance.title_id = titleauthor.title_id
AND royalties_advance.au_id = titleauthor.au_id
GROUP BY royalties_advance.title_id, royalties_advance.au_id;

-- Creating a temporary table to store the total profits of each author
CREATE TEMPORARY TABLE author_profits AS
SELECT au_id, SUM(royalties) as profits
FROM aggregated_royalties
GROUP BY au_id;

-- Selecting the top 3 authors based on profits
SELECT au_id, profits
FROM author_profits
ORDER BY profits DESC
LIMIT 3;

-- Dropping the temporary tables 
DROP TEMPORARY TABLE royalties_advance, aggregated_royalties, author_profits;

-- Challenge 3

CREATE TABLE most_profiting_authors (
au_id INT,
profits DECIMAL(10,2),
PRIMARY KEY (au_id)
);

INSERT INTO most_profiting_authors (au_id, profits)
SELECT au_id, SUM(advance + aggregated_royalties) AS profits
FROM (
SELECT titleauthor.au_id,
(SELECT SUM(titles.advance * titleauthor.royaltyper / 100) FROM titleauthor LEFT JOIN titles ON titleauthor.title_id = titles.title_id) AS advance,
(SELECT SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) FROM titleauthor LEFT JOIN titles ON titleauthor.title_id = titles.title_id LEFT JOIN sales ON titles.title_id = sales.title_id) AS aggregated_royalties
FROM titleauthor
GROUP BY titleauthor.au_id
) AS author_profits
GROUP BY au_id
ORDER BY profits DESC
LIMIT 3;

SELECT * FROM most_profiting_authors;
