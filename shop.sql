-- Previous Code to Create Tables / Previous checkpoint

CREATE TABLE Product (
    Product_id VARCHAR2(20) PRIMARY KEY,
    Product_name VARCHAR2(20) NOT NULL,
    Price NUMBER CHECK (Price > 0)
);

CREATE TABLE Customer (
    Customer_id VARCHAR2(20) PRIMARY KEY,
    Customer_Name VARCHAR2(20) NOT NULL,
    Customer_Tel NUMBER
);

CREATE TABLE Orders (
    Customer_id VARCHAR2(20),
    Product_id VARCHAR2(20),
    Quantity NUMBER,
    Total_amount NUMBER,
    PRIMARY KEY (Customer_id, Product_id),
    FOREIGN KEY (Customer_id)
        REFERENCES Customer(Customer_id),
    FOREIGN KEY (Product_id)
        REFERENCES Product(Product_id)
);

ALTER TABLE Product
ADD Category VARCHAR2(20);

ALTER TABLE Orders
ADD OrderDate DATE DEFAULT SYSDATE;


-- Previous Insertion Code / Previous checkpoint

-- Insert products
INSERT INTO Product (Product_id, Product_name, Category, Price)
VALUES ('P01', 'Samasung Galaxy S20', 'Smartphone', 3299);

INSERT INTO Product (Product_id, Product_name, Category, Price)
VALUES ('P02', 'ASUS Notebook', 'PC', 4599);


-- Insert customers
INSERT INTO Customer (Customer_id, Customer_Name, Customer_Tel)
VALUES ('C01', 'ALI', 71321009);

INSERT INTO Customer (Customer_id, Customer_Name, Customer_Tel)
VALUES ('C02', 'ASMA', 77345823);


-- Insert orders
INSERT INTO Orders (Customer_id, Product_id, OrderDate, Quantity, Total_amount)
VALUES ('C01', 'P02', NULL, 2, 9198);

INSERT INTO Orders (Customer_id, Product_id, OrderDate, Quantity, Total_amount)
VALUES ('C02', 'P01', TO_DATE('28/05/2020', 'DD/MM/YYYY'), 1, 3299);



-- Display all the data of customers / DQL checkpoint


SELECT * 
FROM Customer;

-- Display the product_name and category for products which their price is between 5000 and 10000

SELECT Product_name, Category
FROM Product
WHERE Price BETWEEN 5000 AND 10000;

-- Display all the data of products sorted in descending order of price.

SELECT *
FROM Product
ORDER BY Price DESC;

-- Display the total number of orders, the average amount, the highest total amount and the lower total amountFor each product_id, display the number of orders

SELECT COUNT(*) AS Total_Orders,
       AVG(Total_amount) AS Average_Amount,
       MAX(Total_amount) AS Highest_Amount,
       MIN(Total_amount) AS Lowest_Amount
FROM Orders;

-- Display the customer_id which has more than 2 orders   

SELECT Customer_id
FROM Orders
GROUP BY Customer_id
HAVING COUNT(*) > 2;

-- For each month of the 2020 year, display the number of orders

SELECT EXTRACT(MONTH FROM OrderDate) AS Order_Month,
       COUNT(*) AS Number_of_Orders
FROM Orders
WHERE OrderDate >= DATE '2020-01-01'
  AND OrderDate < DATE '2021-01-01'
GROUP BY EXTRACT(MONTH FROM OrderDate)
ORDER BY Order_Month;

-- For each order, display the product_name, the customer_name and the date of the order

SELECT Product.Product_name,
       Customer.Customer_Name,
       Orders.OrderDate
FROM Orders
JOIN Product
    ON Orders.Product_id = Product.Product_id
JOIN Customer
    ON Orders.Customer_id = Customer.Customer_id;

-- Display all the orders made three months ago 

SELECT *
FROM Orders
WHERE Orderdate >= ADD_MONTHS(SYSDATE, -3)
  AND OrderDate <= SYSDATE;

-- Display customers (customer_id) who have never ordered a product

SELECT Customer_id
FROM Customer
WHERE Customer_id NOT IN (
    SELECT Customer_id
    FROM Orders
    WHERE Customer_id IS NOT NULL
);