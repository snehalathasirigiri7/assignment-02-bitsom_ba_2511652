-- Schema Design in 3NF

CREATE TABLE Customers (
  customer_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL
);

CREATE TABLE Products (
  product_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category VARCHAR(100) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE SalesReps (
  sales_rep_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  office_address TEXT NOT NULL
);

CREATE TABLE Orders (
  order_id VARCHAR(10) PRIMARY KEY,
  customer_id VARCHAR(10) NOT NULL,
  order_date DATE NOT NULL,
  sales_rep_id VARCHAR(10) NOT NULL,
  FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY(sales_rep_id) REFERENCES SalesReps(sales_rep_id)
);

CREATE TABLE OrderItems (
  order_id VARCHAR(10) NOT NULL,
  product_id VARCHAR(10) NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY(order_id, product_id),
  FOREIGN KEY(order_id) REFERENCES Orders(order_id),
  FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

-- Inserts (5 each)
INSERT INTO Customers VALUES
('C001','Rohan Mehta','rohan@gmail.com','Mumbai'),
('C002','Priya Sharma','priya@gmail.com','Delhi'),
('C003','Amit Verma','amit@gmail.com','Bangalore'),
('C004','Sneha Iyer','sneha@gmail.com','Chennai'),
('C005','Vikram Singh','vikram@gmail.com','Mumbai');

INSERT INTO Products VALUES
('P001','Laptop','Electronics',55000),
('P002','Mouse','Electronics',800),
('P003','Desk Chair','Furniture',8500),
('P004','Notebook','Stationery',120),
('P005','Headphones','Electronics',3200);

INSERT INTO SalesReps VALUES
('SR01','Deepak Joshi','deepak@corp.com','Mumbai HQ, Nariman Point'),
('SR02','Anita Desai','anita@corp.com','Delhi Office, Connaught Place'),
('SR03','Ravi Kumar','ravi@corp.com','South Zone, MG Road, Bangalore'),
('SR04','Meera Shah','meera@corp.com','Pune Office, FC Road'),
('SR05','Kunal Rao','kunal@corp.com','Hyderabad Business Park');

INSERT INTO Orders VALUES
('ORD1001','C001','2023-05-29','SR01'),
('ORD1002','C002','2023-01-17','SR02'),
('ORD1003','C003','2023-09-16','SR01'),
('ORD1004','C004','2023-11-29','SR01'),
('ORD1005','C005','2023-10-29','SR02');

INSERT INTO OrderItems VALUES
('ORD1001','P001',1),
('ORD1002','P005',1),
('ORD1003','P002',5),
('ORD1004','P004',3),
('ORD1005','P003',2);
