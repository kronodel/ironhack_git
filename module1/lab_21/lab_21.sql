use ppub;

/*
CHALLENGE 1

In this challenge you will write a MySQL SELECT query that joins various tables to figure out what titles each author has 
published at which publishers. Your output should have at least the following columns:

    AUTHOR ID - the ID of the author
    LAST NAME - author last name
    FIRST NAME - author first name
    TITLE - name of the published title
    PUBLISHER - name of the publisher where the title was published

If your query is correct, the total rows in your output should be the same as the total number of records in Table titleauthor.
*/

SELECT authors.au_id, authors.au_lname, authors.au_fname,titleauthor.title_id,titles.title,publishers.pub_name
From authors
LEFT JOIN titleauthor
ON authors.au_id=titleauthor.au_id
INNER JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN publishers
ON titles.pub_id=publishers.pub_id;


/*
CHALLENGE 2

Elevating from your solution in Challenge 1, query how many titles each author has published at each publisher.

To check if your output is correct, sum up the TITLE COUNT column. The sum number should be the same as 
the total number of records in Table titleauthor.

*/

SELECT authors.au_id,authors.au_lname, authors.au_fname, publishers.pub_name,count(titles.title)
FROM authors
LEFT JOIN titleauthor
ON authors.au_id=titleauthor.au_id
INNER JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN publishers
ON titles.pub_id=publishers.pub_id
GROUP BY authors.au_id, publishers.pub_name;

/* 
Challenge 3
Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.

Requirements:

    Your output should have the following columns:
        AUTHOR ID - the ID of the author
        LAST NAME - author last name
        FIRST NAME - author first name
        TOTAL - total number of titles sold from this author
    Your output should be ordered based on TOTAL from high to low.
    Only output the top 3 best selling authors.
*/

SELECT a.au_id, a.au_lname, a.au_fname, COUNT(t.title_id) AS TOTAL
FROM authors a
LEFT JOIN titleauthor ta
ON a.au_id=ta.au_id
INNER JOIN titles t
ON ta.title_id=t.title_id
GROUP BY a.au_id
ORDER BY TOTAL;

/* 
Challenge 4 - Best Selling Authors Ranking

Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. 
Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL). 
Also order your results based on TOTAL from high to low.
*/

SELECT a.au_id, a.au_lname, a.au_fname, COUNT(t.title_id) AS TOTAL
FROM authors a
LEFT JOIN titleauthor ta
ON a.au_id=ta.au_id
INNER JOIN titles t
ON ta.title_id=t.title_id
GROUP BY a.au_id
ORDER BY TOTAL;