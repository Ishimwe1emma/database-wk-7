-- ================================
-- 📝 Assignment: Database Design and Normalization
-- ================================

-- ================================
-- Question 1: Achieving 1NF
-- ================================
-- Q1: You are given the following table ProductDetail:
-- OrderID | CustomerName | Products
-- 101     | John Doe     | Laptop, Mouse
-- 102     | Jane Smith   | Tablet, Keyboard, Mouse
-- 103     | Emily Clark  | Phone
-- The Products column contains multiple values, which violates 1NF.
-- Write an SQL query to transform this table into 1NF,
-- ensuring that each row represents a single product for an order.

-- ✅ Answer for Q1:
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- ================================
-- Question 2: Achieving 2NF
-- ================================
-- Q2: You are given the following table OrderDetails, which is already in 1NF:
-- OrderID | CustomerName | Product   | Quantity
-- 101     | John Doe     | Laptop    | 2
-- 101     | John Doe     | Mouse     | 1
-- 102     | Jane Smith   | Tablet    | 3
-- 102     | Jane Smith   | Keyboard  | 1
-- 102     | Jane Smith   | Mouse     | 2
-- 103     | Emily Clark  | Phone     | 1
-- The CustomerName column depends only on OrderID (partial dependency),
-- which violates 2NF. Normalize into 2NF.

-- ✅ Answer for Q2:
-- Step 1: Create Orders table (OrderID → CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderDetails table (OrderID + Product → Quantity)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert values into Orders table
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 4: Insert values into OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
