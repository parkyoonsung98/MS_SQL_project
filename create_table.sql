CREATE TABLE RESTAURANT (
RestaurantID       int     not null identity(1,1),
RestaurantName  VarChar(100)       not null,
Address       VarChar(100)       not null,
PhoneNumber          char(12)     not null,
CONSTRAINT            RES_PK          PRIMARY KEY(RestaurantID)
);

CREATE TABLE MENU(
MenuID          int     not null identity(1,1),
MenuItem     VarChar(100)       not null,
MenuItemCost       Numeric(10,2)     not null,
RestaurantID       int     not null,
CONSTRAINT            MENU_PK       PRIMARY KEY(MenuID),
CONSTRAINT            MENU_RES_FK          FOREIGN KEY(RestaurantID)
REFERENCES RESTAURANT(RestaurantID)
ON DELETE NO ACTION
);

CREATE TABLE CUSTOMER(
CustomerID           int not null identity(1,1),
FirstName  VarChar(100)       not null,
LastName     VarChar(100)       not null,
CustomerPhoneNumber  char(12) null,
RestaurantID       int     not null,
CONSTRAINT            CUST_PK       PRIMARY KEY(CustomerID),
CONSTRAINT            CUST_RES_FK          FOREIGN KEY(RestaurantID)
REFERENCES RESTAURANT(RestaurantID)
ON DELETE NO ACTION
);

CREATE TABLE Transactions(
TransactionID     int     not null identity(1,1),
TotalCost  Numeric(10,2)     not null,
CustomerID            int not null,
CONSTRAINT            TRANS_PK     PRIMARY KEY(TransactionID),
CONSTRAINT            TRANS_CUST_FK     FOREIGN KEY(CustomerID)
REFERENCES CUSTOMER(CustomerID)
ON DELETE NO ACTION
);
