-- Star Schema Design
CREATE TABLE dim_date (
  date_id INT PRIMARY KEY,
  full_date DATE NOT NULL,
  year INT NOT NULL,
  month INT NOT NULL,
  day INT NOT NULL
);

CREATE TABLE dim_store (
  store_id INT PRIMARY KEY,
  store_name VARCHAR(100),
  city VARCHAR(100)
);

CREATE TABLE dim_product (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category VARCHAR(50)
);

CREATE TABLE fact_sales (
  sales_id INT PRIMARY KEY,
  date_id INT,
  store_id INT,
  product_id INT,
  units_sold INT,
  unit_price DECIMAL(10,2),
  revenue DECIMAL(12,2),
  FOREIGN KEY(date_id) REFERENCES dim_date(date_id),
  FOREIGN KEY(store_id) REFERENCES dim_store(store_id),
  FOREIGN KEY(product_id) REFERENCES dim_product(product_id)
);
