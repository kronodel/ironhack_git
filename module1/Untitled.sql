USE ppub;

SELECT Store, Items/Orders AS AvgItems, Qty/Items AS AvgQty
FROM (
    SELECT stores.stor_name AS Store, COUNT(DISTINCT(ord_num)) AS Orders, COUNT(title_id) AS Items, SUM(qty) AS Qty
    FROM ppub.sales sales
    INNER JOIN ppub.stores stores ON stores.stor_id = sales.stor_id
    GROUP BY Store
) summary;

CREATE TABLE ppub.store_sales_summary
SELECT stores.stor_id AS StoreID, stores.stor_name AS Store, COUNT(DISTINCT(ord_num)) AS Orders, COUNT(title_id) AS Items, SUM(qty) AS Qty
FROM ppub.sales sales
INNER JOIN ppub.stores stores ON stores.stor_id = sales.stor_id
GROUP BY StoreID, Store;

CREATE TEMPORARY TABLE ppub.store_sales_summary
SELECT stores.stor_id AS StoreID, stores.stor_name AS Store, COUNT(DISTINCT(ord_num)) AS Orders, COUNT(title_id) AS Items, SUM(qty) AS Qty
FROM ppub.sales sales
INNER JOIN ppub.stores stores ON stores.stor_id = sales.stor_id
GROUP BY StoreID, Store;
