--1
CREATE TABLE Restaurant_Chain(
Chain_ID Number(4),
Name VARCHAR2(50),
Constraint PK_Chain PRIMARY KEY (Chain_ID));

--2
CREATE TABLE Store(
Store_ID Number(4),
Store_Name VARCHAR2(50),
Chain_ID Number(4),
Location VARCHAR2(50),
Constraint PK_Store PRIMARY KEY (Store_ID),
Constraint FK_Chain_Store FOREIGN KEY (Chain_ID) REFERENCES
Restaurant_Chain(Chain_ID));

--3
CREATE TABLE Menu(
Menu_ID Number(4),
Menu_Name VARCHAR2(50),
Constraint PK_Menu PRIMARY KEY (Menu_ID));

--4
CREATE TABLE Store_Menu(
StoreMenu_ID Number(4),
Store_ID Number(4),
Menu_ID Number(4),
StartDate Date,
EndDate Date,
Rating Number(5),
CONSTRAINT CHK_StoreMenu CHECK (Rating <=5),
CONSTRAINT PK_Store_Menu PRIMARY KEY (StoreMenu_ID),
CONSTRAINT FK1_Store FOREIGN KEY (Store_ID) REFERENCES Store (Store_ID),
CONSTRAINT FK2_Menu FOREIGN KEY (Menu_ID) REFERENCES Menu (Menu_ID));

--5
CREATE TABLE MenuSection(
MenuSection_ID Number(4),
SectionName VARCHAR2(50),
Constraint PK_ItemSection PRIMARY KEY (MenuSection_ID));

--6
CREATE TABLE MenuItem(
MenuItem_ID Number(4),
ItemName VARCHAR2(50),
Ethnic VARCHAR2(50),
ItemPrice FLOAT(4),
MenuSection_ID Number(4),
Menu_ID Number(4),
Constraint PK_MenuItem PRIMARY KEY (MenuItem_ID),
Constraint FK_ItemSection FOREIGN KEY (MenuSection_ID) REFERENCES MenuSection(MenuSection_ID),
Constraint FK2_Menu2 FOREIGN KEY (Menu_ID) REFERENCES Menu(Menu_ID),
Constraint CHK_ItemPrice CHECK (ItemPrice > 0));

--7
CREATE TABLE Ingredient(
Ingredient_ID Number(4),
IngredientName VARCHAR2(30),
Constraint PK_Ingredient PRIMARY KEY (Ingredient_ID));

--8
CREATE TABLE MenuItemIng(
MenuItemIng_ID Number(4),
Ingredient_ID Number(4),
MenuItem_ID Number(4),
IngQuantityUsed Number(4),
Constraint PK_MenuItemIng PRIMARY KEY (MenuItemIng_ID),
Constraint FK1_MenuItem FOREIGN KEY (MenuItem_ID) REFERENCES MenuItem (MenuItem_ID),
Constraint FK2_Ingredient FOREIGN KEY (Ingredient_ID) REFERENCES Ingredient (Ingredient_ID),
Constraint Check_Quantity CHECK(IngQuantityUsed > 0));

--9
CREATE TABLE Supplier(
Supplier_ID Number(4),
SupplierName VARCHAR2(30),
Constraint PK_Supplier PRIMARY KEY (Supplier_ID));

--10
CREATE TABLE SupplierProduct(
Product_ID NUMBER(4),
Supplier_ID Number(4),
Ingredient_ID Number(4),
Price FLOAT,
Deal_Off FLOAT, 
Constraint PK_SupplierProduct PRIMARY KEY (Product_ID),
Constraint FK1_Ingredient2 FOREIGN KEY (Ingredient_ID) REFERENCES Ingredient (Ingredient_ID),
Constraint FK2_Supplier2 FOREIGN KEY (Supplier_ID) REFERENCES Supplier (Supplier_ID));


--11
CREATE TABLE Orders(
Order_ID NUMBER(4),
Store_ID Number(4),
PaymentMethod VARCHAR2(5),
Order_Date Date,
CONSTRAINT PK_Order PRIMARY KEY (Order_ID),
CONSTRAINT FK1_Store1 FOREIGN KEY (Store_ID) REFERENCES Store (Store_ID),
CONSTRAINT Check_Payment CHECK(PaymentMethod IN ('C', 'F')));


--12
CREATE TABLE Orderline(
Orderline_ID NUMBER(4),
Product_ID NUMBER(4),
Order_ID NUMBER(4),
Quantity NUMBER,
CONSTRAINT PK_Orderline PRIMARY KEY (Orderline_ID),
CONSTRAINT FK1_Order FOREIGN KEY (Order_ID) REFERENCES Orders (Order_ID),
CONSTRAINT FK2_SupplierProduct FOREIGN KEY (Product_ID) REFERENCES SupplierProduct (Product_ID),
CONSTRAINT Check_Quantity CHECK (Quantity > 0));




-------------------------------SEQUENCE----------------------------------
--1
CREATE SEQUENCE seq_Chain_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

--2
CREATE SEQUENCE seq_Store_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

--3
CREATE SEQUENCE seq_Menu_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;


--4
CREATE SEQUENCE seq_StoreMenu_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;


--5
CREATE SEQUENCE seq_MenuSection_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;


--6
CREATE SEQUENCE seq_MenuItem_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;


--7
CREATE SEQUENCE seq_Ingredient_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;


--8
CREATE SEQUENCE seq_MenuItemIng_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;


--9
CREATE SEQUENCE seq_Supplier_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;


--10
CREATE SEQUENCE seq_Product_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;


--11
CREATE SEQUENCE seq_Order_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;



--12
CREATE SEQUENCE seq_Orderline_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;





-------------------------------- TRIGGERS -----------------------------------------
--1
CREATE OR REPLACE TRIGGER TR_seq_Chain_ID
BEFORE INSERT ON Restaurant_Chain
FOR EACH ROW
BEGIN
  SELECT seq_Chain_ID.nextval
  INTO :new.Chain_ID
  FROM dual;
END;

--2
CREATE OR REPLACE TRIGGER TR_seq_Store_ID
BEFORE INSERT ON Store
FOR EACH ROW
BEGIN
  SELECT seq_Store_ID.nextval
  INTO :new.Store_ID
  FROM dual;
END;


--3
CREATE OR REPLACE TRIGGER TR_seq_Menu_ID
BEFORE INSERT ON Menu
FOR EACH ROW
BEGIN
  SELECT seq_Menu_ID.nextval
  INTO :new.Menu_ID
  FROM dual;
END;


--4
CREATE OR REPLACE TRIGGER TR_seq_StoreMenu_ID
BEFORE INSERT ON Store_Menu
FOR EACH ROW
BEGIN
  SELECT seq_StoreMenu_ID.nextval
  INTO :new.StoreMenu_ID
  FROM dual;
END;

--5
CREATE OR REPLACE TRIGGER TR_seq_MenuSection_ID
BEFORE INSERT ON MenuSection
FOR EACH ROW
BEGIN
  SELECT seq_MenuSection_ID.nextval
  INTO :new.MenuSection_ID
  FROM dual;
END;


--6
CREATE OR REPLACE TRIGGER TR_seq_MenuItem_ID
BEFORE INSERT ON MenuItem
FOR EACH ROW
BEGIN
  SELECT seq_MenuItem_ID.nextval
  INTO :new.MenuItem_ID
  FROM dual;
END;


--7
CREATE OR REPLACE TRIGGER TR_seq_Ingredient_ID
BEFORE INSERT ON Ingredient
FOR EACH ROW
BEGIN
  SELECT seq_Ingredient_ID.nextval
  INTO :new.Ingredient_ID
  FROM dual;
END;


--8
CREATE OR REPLACE TRIGGER TR_seq_MenuItemIng_ID
BEFORE INSERT ON MenuItemIng
FOR EACH ROW
BEGIN
  SELECT seq_MenuItemIng_ID.nextval
  INTO :new.MenuItemIng_ID
  FROM dual;
END;


--9
CREATE OR REPLACE TRIGGER TR_seq_Supplier_ID
BEFORE INSERT ON Supplier
FOR EACH ROW
BEGIN
  SELECT seq_Supplier_ID.nextval
  INTO :new.Supplier_ID
  FROM dual;
END;


--10
CREATE OR REPLACE TRIGGER TR_seq_Product_ID
BEFORE INSERT ON SupplierProduct
FOR EACH ROW
BEGIN
  SELECT seq_Product_ID.nextval
  INTO :new.Product_ID
  FROM dual;
END;


--11
CREATE OR REPLACE TRIGGER TR_seq_Order_ID
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
  SELECT seq_Order_ID.nextval
  INTO :new.Order_ID
  FROM dual;
END;


--12
CREATE OR REPLACE TRIGGER TR_seq_Orderline_ID
BEFORE INSERT ON Orderline
FOR EACH ROW
BEGIN
  SELECT seq_Orderline_ID.nextval
  INTO :new.Orderline_ID
  FROM dual;
END;


--------------------------INSERT----------------------------------------
--1
INSERT ALL 
INTO Restaurant_Chain (Name) VALUES ('KFC')
INTO Restaurant_Chain (Name) VALUES ('McDONALD')
SELECT * FROM dual;


--2
INSERT ALL
INTO Store (Store_Name, Chain_ID, Location) VALUES ('McDONALD', 2, 'Thamesmead')
INTO Store (Store_Name, Chain_ID, Location) VALUES ('KFC', 1, 'Thamesmead')
INTO Store (Store_Name, Chain_ID, Location) VALUES ('McDONALD', 2, 'Lewisham')
INTO Store (Store_Name, Chain_ID, Location) VALUES ('KFC', 1, 'Lewisham')
INTO Store (Store_Name, Chain_ID, Location) VALUES ('McDONALD', 2, 'Woolwich')
INTO Store (Store_Name, Chain_ID, Location) VALUES ('KFC', 1, 'Woolwich')
SELECT * FROM dual;

--3
INSERT ALL
INTO Menu (Menu_Name) VALUES ('Chicken Menu')
INTO Menu (Menu_Name) VALUES ('Rice Menu')
INTO Menu (Menu_Name) VALUES ('Noodle Menu')
SELECT * FROM dual;


--4
INSERT ALL
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (1, 1, '11/10/12', '11/10/14', 3)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (3, 1, '11/10/12', '20/10/14', 4)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (5, 2, '11/10/12', '26/10/14', 3)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (1, 3, '11/10/12', '16/10/14', 3)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (3, 3, '11/10/12', '15/10/14', 2)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (4, 1, '11/10/12', NULL, NULL)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (5, 2, '11/10/12', NULL, NULL)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (6, 3, '11/10/12', NULL, NULL)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (2, 3, '11/10/12', NULL, NULL)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (2, 1, '11/10/12', NULL, NULL)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (4, 2, '11/10/12', NULL, NULL)
INTO Store_Menu(Store_ID, Menu_ID, StartDate, EndDate, Rating) VALUES (6, 2, '11/10/12', NULL, NULL)
SELECT * FROM DUAL;


--5
INSERT ALL
INTO MenuSection (SectionName) VALUES ('Appetite')
INTO MenuSection (SectionName) VALUES ('Desert')
INTO MenuSection (SectionName) VALUES ('Starter')
SELECT * FROM DUAL;

--6
INSERT ALL
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Chocolate Pudding', 'British', 5, 2, 1)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Pea and Smoked Bacon Soup', 'British', 5, 3, 2)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Country Mushrooms', 'British', 4, 2, 3)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Fish Pepper Soup', 'Nigeria', 6, 1, 3)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Chin Chin', 'Nigeria', 4, 2, 2)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Custard', 'Nigeria', 5, 3, 1)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Chicken Fried Rice', 'Chinese', 4, 3, 1)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Beef Noodle Soup', 'Chinese', 4, 2, 2)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Chinese Crullers', 'Chinese', 5, 1, 3)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Torta della Nonna', 'Italian', 5, 1, 3)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Garlic Bread', 'Italian', 5, 3, 2)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Cheese Straws', 'Italian', 4, 2, 1)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Avocado and Pilchard Pate', 'French', 5, 1, 3)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('Baked Apple Brie', 'French', 6, 2, 2)
INTO MenuItem (ItemName, Ethnic, ItemPrice, MenuSection_ID, Menu_ID) VALUES ('French Chocolate', 'French', 5, 3, 1)
SELECT * FROM DUAL;


--7
INSERT ALL
INTO Ingredient (IngredientName) VALUES ('Sunflower oil')
INTO Ingredient (IngredientName) VALUES ('Rice')
INTO Ingredient (IngredientName) VALUES ('Chocolate')
INTO Ingredient (IngredientName) VALUES ('Tomatoes')
INTO Ingredient (IngredientName) VALUES ('Bread')
INTO Ingredient (IngredientName) VALUES ('Apple')
INTO Ingredient (IngredientName) VALUES ('Chicken')
INTO Ingredient (IngredientName) VALUES ('Fish')
SELECT * FROM DUAL;


--8
INSERT ALL
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (1, 1, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (3, 1, 2)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (1, 2, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (4, 2, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (1, 3, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (1, 4, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (4, 4, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (4, 5, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (1, 5, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (1, 6, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (1, 7, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (1, 8, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (4, 8, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (5, 9, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (2, 7, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (5, 10, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (7, 11, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (6, 12, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (7, 13, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (7, 14, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (5, 15, 1)
INTO MenuItemIng (Ingredient_ID, MenuItem_ID, IngQuantityUsed) VALUES (6, 7, 1)
SELECT * FROM DUAL;


--9
INSERT ALL 
INTO Supplier(SupplierName) VALUES ('Asda')
INTO Supplier(SupplierName) VALUES ('Tesco')
INTO Supplier(SupplierName) VALUES ('Morrison')
SELECT * FROM DUAL;


--10
INSERT ALL
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (1, 1, 6, NULL)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (2, 1, 7, 0.25)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (1, 2, 5, NULL)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (2, 2, 4, 0.35)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (1, 3, 10, NULL)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (1, 4, 10, 0.35)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (2, 4, 10, NULL)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (1, 5, 15, NULL)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (2, 5, 13.95, 0.25)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (1, 6, 12, NULL)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (2, 6, 11, NULL)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (1, 7, 10, 0.35)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (2, 7, 9.95, NULL)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (1, 8, 13, 0.25)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (2, 8, 14, 0.35)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (3, 1, 11, 0.35)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (3, 2, 12, 0.35)
INTO SupplierProduct(Supplier_ID, Ingredient_ID, Price, Deal_Off) VALUES (2, 3, 11, NULL)
SELECT * FROM DUAL;


--11
INSERT ALL
INTO Orders(Store_ID, PaymentMethod, Order_Date) VALUES (1, 'C', '11/MAR/12')
INTO Orders(Store_ID, PaymentMethod, Order_Date) VALUES (2, 'C', '11/MAR/12')
INTO Orders(Store_ID, PaymentMethod, Order_Date) VALUES (1, 'C', '11/JAN/12')
INTO Orders(Store_ID, PaymentMethod, Order_Date) VALUES (2, 'C', '11/FEB/12')
INTO Orders(Store_ID, PaymentMethod, Order_Date) VALUES (1, 'C', '11/APR/12')
INTO Orders(Store_ID, PaymentMethod, Order_Date) VALUES (2, 'F', '11/FEB/12')
INTO Orders(Store_ID, PaymentMethod, Order_Date) VALUES (3, 'F', '11/FEB/12')
SELECT * FROM DUAL;


--12
INSERT ALL
INTO Orderline(Product_ID, Order_ID, Quantity) VALUES (1, 1, 60)
INTO Orderline(Product_ID, Order_ID, Quantity) VALUES (2, 2, 70)
INTO Orderline(Product_ID, Order_ID, Quantity) VALUES (3, 3, 80)
INTO Orderline(Product_ID, Order_ID, Quantity) VALUES (4, 4, 90)
INTO Orderline(Product_ID, Order_ID, Quantity) VALUES (5, 5, 85)
INTO Orderline(Product_ID, Order_ID, Quantity) VALUES (6, 6, 70)
SELECT * FROM DUAL;



----------------------------------------------- SAMPLE QUERIES -------------------------------------------------------
--shows chains and the store that belongs to the chain with the location of the store.
SELECT Name, Store_Name, Location 
FROM Restaurant_Chain 
INNER JOIN Store 
ON Restaurant_Chain.Chain_ID = Store.Chain_ID
ORDER BY NAME ASC;


SELECT Name, Store_Name, Location 
FROM Restaurant_Chain 
INNER JOIN Store 
ON Restaurant_Chain.Chain_ID = Store.Chain_ID
WHERE Name = 'KFC'
ORDER BY NAME ASC;



SELECT ItemName, Ethnic, ItemPrice, Menu_Name, SectionName
FROM MenuItem
INNER JOIN Menu ON MenuItem.Menu_ID = Menu.Menu_ID
INNER JOIN MenuSection ON MenuItem.MenuSection_ID = MenuSection.MenuSection_ID;


SELECT Store_Name, store.location, Menu_Name
FROM store_menu
INNER JOIN Store ON store_menu.store_id = store.store_id
INNER JOIN Menu ON store_menu.menu_id = menu.menu_id
WHERE Store_Name = 'KFC' AND Location = 'Thamesmead';


SELECT ItemName, Ethnic, ItemPrice, Menu_Name, IngredientName, IngQuantityUsed 
FROM MenuItem
INNER JOIN MenuItemIng ON MenuItem.MenuItem_ID = MenuItemIng.MenuItem_ID
INNER JOIN Ingredient ON MenuItemIng.Ingredient_ID = Ingredient.Ingredient_ID
INNER JOIN Menu ON MenuItem.Menu_ID = menu.menu_id
ORDER BY Menu_Name ASC;


SELECT ItemName, Ethnic, ItemPrice, IngredientName, IngQuantityUsed 
FROM MenuItem
INNER JOIN MenuItemIng ON MenuItem.MenuItem_ID = MenuItemIng.MenuItem_ID
INNER JOIN Ingredient ON MenuItemIng.Ingredient_ID = Ingredient.Ingredient_ID;


SELECT Menu_Name, Store_Name, StartDate, EndDate, Rating
FROM Store_Menu
INNER JOIN Store ON store_menu.store_id = store.store_id
INNER JOIN Menu ON store_menu.menu_id = menu.menu_id
WHERE EndDate IS NULL;



SELECT Menu_Name, Store_Name, StartDate, EndDate, Rating
FROM Store_Menu
INNER JOIN Store ON store_menu.store_id = store.store_id
INNER JOIN Menu ON store_menu.menu_id = menu.menu_id
WHERE EndDate IS NOT NULL;



SELECT SupplierName, IngredientName, Price, Deal_Off 
FROM SupplierProduct
INNER JOIN Ingredient ON SupplierProduct.Ingredient_ID = Ingredient.Ingredient_ID
INNER JOIN Supplier ON SupplierProduct.Supplier_ID = Supplier.supplier_id;



SELECT SupplierName, IngredientName, Price, Deal_Off 
FROM SupplierProduct
INNER JOIN Ingredient ON SupplierProduct.Ingredient_ID = Ingredient.Ingredient_ID
INNER JOIN Supplier ON SupplierProduct.Supplier_ID = Supplier.supplier_id
WHERE Deal_Off IS NULL;



SELECT SupplierName, IngredientName, Price, Deal_Off 
FROM SupplierProduct
INNER JOIN Ingredient ON SupplierProduct.Ingredient_ID = Ingredient.Ingredient_ID
INNER JOIN Supplier ON SupplierProduct.Supplier_ID = Supplier.supplier_id
WHERE Deal_Off IS NOT NULL;



SELECT SupplierName, IngredientName, Price, Deal_Off, Price-(Price*Deal_Off) AS "Deal Price" 
FROM SupplierProduct
INNER JOIN Ingredient ON SupplierProduct.Ingredient_ID = Ingredient.Ingredient_ID
INNER JOIN Supplier ON SupplierProduct.Supplier_ID = Supplier.supplier_id;



SELECT Price, Deal_Off, PaymentMethod, Order_Date, Quantity
FROM Orderlines
INNER JOIN  SupplierProduct ON Orderlines.Product_ID = SupplierProduct.Product_ID
INNER JOIN Orders ON Orderlines.Order_ID = Orders.Order_ID;




SELECT Store_Name, Location, SupplierName, IngredientName, Order_Date, PaymentMethod,  Quantity, Price, Deal_Off 
FROM Store, Supplier, ingredient, Orders, Orderlines, SupplierProduct
WHERE Store.Store_ID = Orders.Store_ID AND Supplier.Supplier_id = SupplierProduct.Supplier_ID 
AND Ingredient.Ingredient_ID = SupplierProduct.Ingredient_ID AND orders.order_id = Orderlines.order_id
AND orderlines.product_id = SupplierProduct.Product_ID;



SELECT Quantity, Price, Price * 0.5 AS "Discount" 
FROM Orderlines
INNER JOIN  SupplierProduct ON Orderlines.Product_ID = SupplierProduct.Product_ID
WHERE Quantity > 70;



SELECT Store_Name, Location, SupplierName, IngredientName, Order_Date, PaymentMethod,  Quantity, Price, Quantity * Price AS "Total Price" 
FROM Store, Supplier, ingredient, Orders, Orderlines, SupplierProduct
WHERE Store.Store_ID = Orders.Store_ID AND Supplier.Supplier_id = SupplierProduct.Supplier_ID 
AND Ingredient.Ingredient_ID = SupplierProduct.Ingredient_ID AND orders.order_id = Orderlines.order_id
AND orderlines.product_id = SupplierProduct.Product_ID;




SELECT Store_Name, Location, SupplierName, IngredientName, Order_Date, PaymentMethod,  Quantity, Price, Quantity * Price AS "Total Price",
Deal_Off, Quantity*(Price-(Price*Deal_Off)) AS "Deal OFF TOTAL"
FROM Store, Supplier, ingredient, Orders, Orderlines, SupplierProduct
WHERE Store.Store_ID = Orders.Store_ID AND Supplier.Supplier_id = SupplierProduct.Supplier_ID 
AND Ingredient.Ingredient_ID = SupplierProduct.Ingredient_ID AND orders.order_id = Orderlines.order_id
AND orderlines.product_id = SupplierProduct.Product_ID;



------------------------------------------------------------------ STORED PROCEDURE --------------------------------------------------------------------------

create or replace PROCEDURE getLocationsByName(
    e_Name IN Restaurant_Chain.Name%TYPE,
    e_disp OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN e_disp FOR SELECT Name, Store_Name, Location 
    FROM Restaurant_Chain 
    INNER JOIN Store 
    ON Restaurant_Chain.Chain_ID = Store.Chain_ID
    WHERE Name = e_Name
    ORDER BY NAME ASC; 
    Commit;
END;



