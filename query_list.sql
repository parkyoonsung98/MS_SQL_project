
/*Finds names of Restaurants where there is a transaction greater than a specific value*/

SELECT RestaurantName
FROM RESTAURANT
WHERE RestaurantID IN
(SELECT CustomerID
FROM CUSTOMER
WHERE CustomerID IN
(SELECT TransactionID
FROM TRANSACTIONS
WHERE TotalCost > 15
)
);



/*Displays Names of Customers who have all purchased a specific item*/

SELECT FirstName, MenuItem 
FROM CUSTOMER AS C, MENU AS M
WHERE C.RestaurantID = M.RestaurantID AND M.MenuItem = 'Burrito';  



/*Finds average cost of transactions at a certain Restaurant*/

SELECT AVG(TotalCost) 
FROM TRANSACTIONS AS T, CUSTOMER AS C, RESTAURANT AS R
WHERE T.CustomerID = C.CustomerID 
AND C.RestaurantID = R.RestaurantID 
AND RestaurantName = 'Five Guys'; SS



/*Displays menu item along with the cost of the items organized in a descending matter of cost*/

SELECT MenuItem, MenuItemCost
FROM MENU
ORDER BY MenuItemCost DESC;



/* Find the RestaurantName and the TotalCost of a restaurant that has a name starting with Yallah */  
  
SELECT RestaurantName, TotalCost
FROM RESTAURANT AS R, CUSTOMER AS C, TRANSACTIONS AS T
WHERE R.RestaurantName LIKE 'Yallah%'
AND R.RestaurantID = C.RestaurantID 
AND C.CustomerID = T.CustomerID;



/* Find sum of TotalCost for each Type of CustomerID with more than two transactions */

Select C.CustomerID, sum(TotalCost) as TotalCost
FROM  TRANSACTIONS AS T, CUSTOMER AS C, RESTAURANT AS R
WHERE T.CustomerID = C.CustomerID
AND C.RestaurantID = R.RestaurantID
group by C.CustomerID
having Count(T.CustomerID) > 2;
