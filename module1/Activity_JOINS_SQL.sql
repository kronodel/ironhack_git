use ppub;

Select p.pub_name, COUNT(t.title_id) AS Number
From publishers p
LEFT JOIN titles t
ON p.pub_id = t.pub_id
GROUP BY p.pub_name;

-- ----------------

Select p.pub_name, COUNT(t.title_id) AS Number
From titles t
RIGHT JOIN publishers p
ON p.pub_id = t.pub_id
GROUP BY p.pub_name;

-- ----------------

select a.col1, a.col2, b.col1, b.col3, c.co1 from
a left join b
on a.col1=b.col2
left join c
on b.col1=c.col1;

