-- LAB 22
-- Challenge 1 - Most Profiting Authors
USE ppub;

/*Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication

Write a SELECT query to obtain the following output:

- Title ID
- Author ID
- Advance of each title and author
	The formula is:
		advance = titles.advance * titleauthor.royaltyper / 100
- Royalty of each sale
	The formula is:
		sales_royalty = titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100
*/

SELECT titleauthor.title_id, titleauthor.au_id, titles.advance * titleauthor.royaltyper / 100 as advance, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON titles.title_id = sales.title_id
GROUP BY title_id;

/*Step 2: Aggregate the total royalties for each title and author

Using the output from Step 1, write a query, containing a subquery, to obtain the following output:

    Title ID
    Author ID
    Aggregated royalties of each title for each author
        Hint: use the SUM subquery and group by both au_id and title_id

In the output of this step, each title should appear only once for each author.
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