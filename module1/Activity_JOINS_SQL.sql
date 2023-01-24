use ppub;

Select publishers.pub_name, COUNT(titles.title_id) AS Titles
From publishers
LEFT JOIN titles
ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name;