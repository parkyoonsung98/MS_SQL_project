CREATE TABLE RESTAURANT (
RestaurantID       int     not null identity(1,1),
RestaurantName  VarChar(100)       not null,
Address       VarChar(100)       not null,
PhoneNumber          char(12)     not null,
CONSTRAINT            RES_PK          PRIMARY KEY(RestaurantID)
);
CREATE TABLE MENU(
MenuID          int     not null identity(1,1),
MenuItem     VarChar(100)       not null,
MenuItemCost       Numeric(10,2)     not null,
RestaurantID       int     not null,
CONSTRAINT            MENU_PK       PRIMARY KEY(MenuID),
CONSTRAINT            MENU_RES_FK          FOREIGN KEY(RestaurantID)
REFERENCES RESTAURANT(RestaurantID)
ON DELETE NO ACTION
);
CREATE TABLE CUSTOMER(
CustomerID           int not null identity(1,1),
FirstName  VarChar(100)       not null,
LastName     VarChar(100)       not null,
CustomerPhoneNumber  char(12) null,
RestaurantID       int     not null,
CONSTRAINT            CUST_PK       PRIMARY KEY(CustomerID),
CONSTRAINT            CUST_RES_FK          FOREIGN KEY(RestaurantID)
REFERENCES RESTAURANT(RestaurantID)
ON DELETE NO ACTION
);
CREATE TABLE Transactions(
TransactionID     int     not null identity(1,1),
TotalCost  Numeric(10,2)     not null,
CustomerID            int not null,
CONSTRAINT            TRANS_PK     PRIMARY KEY(TransactionID),
CONSTRAINT            TRANS_CUST_FK     FOREIGN KEY(CustomerID)
REFERENCES CUSTOMER(CustomerID)
ON DELETE NO ACTION
);


INSERT INTO RESTAURANT VALUES (‘Chipotle’, ‘1235 Beaver Avenue’,’424-123-1209');
INSERT INTO RESTAURANT VALUES (‘Five Guys’, ‘7629 Clover Street’,’123-456-7890');
INSERT INTO RESTAURANT VALUES (‘McDonalds’, ‘5687 Nittany Drive’,’123-456-0986');
INSERT INTO RESTAURANT VALUES (‘Roots’, ‘1238 Amazon Street’,’123-456-0987');
INSERT INTO RESTAURANT VALUES (‘Yallah Taco’, ‘4382 Golden Street’,’123-456-9876');

INSERT INTO MENU VALUES (‘Burrito’, 9.20 ,1);
INSERT INTO MENU VALUES (‘Burger’, 5.80, 2);
INSERT INTO MENU VALUES (‘Fries’, 3.99, 3);
INSERT INTO MENU VALUES (‘Salad’, 10.35, 4);
INSERT INTO MENU VALUES (‘Taco’, 4.99, 5);

INSERT INTO CUSTOMER VALUES (‘Fred’, ‘Washington’, ’234-456-9876' ,1);
INSERT INTO CUSTOMER VALUES ('James’, 'Lee’, ’345-456-9876' ,2); 
INSERT INTO CUSTOMER VALUES (‘Bob’, ‘White’, ’456-456-9876' ,3);
INSERT INTO CUSTOMER VALUES (‘Amy’, ‘Elser’, ’567-456-9876' ,4);
INSERT INTO CUSTOMER VALUES (‘Sam’, ‘Li’, ’678-456-9876' ,5);

INSERT INTO TRANSACTIONS VALUES(15, 1 );
INSERT INTO TRANSACTIONS VALUES(9.79, 2 );
INSERT INTO TRANSACTIONS VALUES(14.34, 3 );
INSERT INTO TRANSACTIONS VALUES(15.34, 4 );
INSERT INTO TRANSACTIONS VALUES(24.54, 5 );
INSERT INTO TRANSACTIONS VALUES(32.93, 5);
INSERT INTO TRANSACTIONS VALUES(185.20, 3);
INSERT INTO TRANSACTIONS VALUES(109.45, 3);


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
FROM  TRANSACTIONS AS T, CUSTOMER AS C, RESTAURANT AS R
WHERE T.CustomerID = C.CustomerID
AND C.RestaurantID = R.RestaurantID
group by C.CustomerID
having Count(T.CustomerID) > 2;