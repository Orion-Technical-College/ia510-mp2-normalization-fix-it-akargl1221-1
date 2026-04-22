-- Your normalized schema + migration from `before.sql`.
-- Starter placeholder: valid SQL so CI stays green; replace with your real DDL/DML.
--==========================
-- So I  took my ddl scema from ia510-mp1 and normallized it.  Only ORDERS and ORDER_LINE needed to be fixed.
-- Removed TotalAmount from ORDERS and LineTotal from ORDER_LINE.  These can be derived via query.
-- I also removed WarehouseID from the ORDER_LINES table since it can be derived from the ORDERS table.
-- Then I added the query to find TotalAmount and LineTotal at the end of the file.
--==========================

-- =========================
-- CUSTOMER
-- =========================
CREATE TABLE CUSTOMER (
    CustomerID INT PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Email VARCHAR(150),
    Region VARCHAR(50)
);

-- =========================
-- SUPPLIER
-- =========================
CREATE TABLE SUPPLIER (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Email VARCHAR(150),
    PaymentTerms VARCHAR(50)
);

-- =========================
-- SALES_REP
-- =========================
CREATE TABLE SALES_REP (
    SalesRepID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(150),
    Region VARCHAR(50)
);

-- =========================
-- WAREHOUSE
-- =========================
CREATE TABLE WAREHOUSE (
    WarehouseID VARCHAR(10) PRIMARY KEY,
    WarehouseName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    CapacityUnits INT
);

-- =========================
-- PRODUCT
-- =========================
CREATE TABLE PRODUCT (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    ListPrice NUMERIC(10,2),
    SupplierID INT NOT NULL,
    CONSTRAINT fk_product_supplier
        FOREIGN KEY (SupplierID)
        REFERENCES SUPPLIER(SupplierID)
);

-- =========================
-- ORDERS
-- =========================
CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    SalesRepID INT NOT NULL,
    WarehouseID VARCHAR(10) NOT NULL,
    OrderDate DATE,
    Status VARCHAR(30),
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (CustomerID)
        REFERENCES CUSTOMER(CustomerID),
    CONSTRAINT fk_orders_salesrep
        FOREIGN KEY (SalesRepID)
        REFERENCES SALES_REP(SalesRepID),
    CONSTRAINT fk_orders_warehouse
        FOREIGN KEY (WarehouseID)
        REFERENCES WAREHOUSE(WarehouseID)
);

-- =========================
-- ORDER_LINE
-- =========================
CREATE TABLE ORDER_LINE (
    OrderLineID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice NUMERIC(10,2),
    CONSTRAINT fk_orderline_order
        FOREIGN KEY (OrderID)
        REFERENCES ORDERS(OrderID),
    CONSTRAINT fk_orderline_product
        FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID),
);

-- =========================
-- INVENTORY
-- =========================
CREATE TABLE INVENTORY (
    InventoryID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    WarehouseID VARCHAR(10) NOT NULL,
    QuantityOnHand INT,
    ReorderPoint INT,
    LastRestockedDate DATE,
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID),
    CONSTRAINT fk_inventory_warehouse
        FOREIGN KEY (WarehouseID)
        REFERENCES WAREHOUSE(WarehouseID),
    CONSTRAINT uq_inventory_product_warehouse
        UNIQUE (ProductID, WarehouseID)
);

--How to find TotalAmount that was in ORDERS Derived via query
SELECT OrderID, SUM(LineTotal) AS TotalAmount
FROM ORDER_LINE
GROUP BY OrderID;

--How to find LineTotal that was in ORDER_LINE Derived via query
SELECT OrderLineID, Quantity * UnitPrice AS LineTotal
FROM ORDER_LINE;


