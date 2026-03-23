## Anomaly Analysis
Below are examples of Insert, Update, and Delete anomalies identified from orders_flat.csv.
1. Insert Anomaly
An insert anomaly occurs when certain data cannot be inserted without the presence of other unrelated data.
Example: To add a new product (e.g., P009 – Office Lamp), you cannot insert it into the orders_flat.csv table unless there is also a corresponding order, customer, and sales rep.

The table structure forces product details to be stored only along with an order.
Since products are not stored independently, new products cannot be added without creating a fake order.
Any existing row shows this coupling. For example:
ORD1037,C002,Priya Sharma,priya@gmail.com,Delhi,P007,Pen Set,Stationery,250,2,2023-03-06,SR03,Ravi Kumar,ravi@corp.com,"South Zone, MG Road, Bangalore - 560001"
Here, the product (P007) can only exist because an order exists. This reflects the insert anomaly.

2. Update Anomaly
An update anomaly occurs when the same data item is duplicated across multiple rows, requiring repeated updates; inconsistent updates lead to data inconsistency.
Example: Customer Neha Gupta (C006) appears in many rows:

Row sample: ORD1153, ORD1118, ORD1083, ORD1009, ORD1099, etc.
If Neha Gupta changes her email from neha@gmail.com to something else, the update must be made in all rows; otherwise inconsistencies arise.
Specific Rows Affected:
ORD1153,C006,Neha Gupta,neha@gmail.com,Delhi,P007,Pen Set,Stationery,250,3,2023-02-14,SR01,Deepak Joshi,deepak@corp.com,"Mumbai HQ, Nariman Point, Mumbai - 400021"
ORD1118,C006,Neha Gupta,neha@gmail.com,Delhi,P007,Pen Set,Stationery,250,5,2023-11-10,SR02,Anita Desai,anita@corp.com,"Delhi Office, Connaught Place, New Delhi - 110001"
ORD1083,C006,Neha Gupta,neha@gmail.com,Delhi,P007,Pen Set,Stationery,250,2,2023-07-03,SR01,Deepak Joshi,deepak@corp.com,"Mumbai HQ, Nariman Point, Mumbai - 400021"
ORD1009,C006,Neha Gupta,neha@gmail.com,Delhi,P005,Headphones,Electronics,3200,4,2023-01-23,SR02,Anita Desai,anita@corp.com,"Delhi Office, Connaught Place, New Delhi - 110001"
The email is repeated in multiple rows → update anomaly.


3. Delete Anomaly

A delete anomaly occurs when deleting a record unintentionally deletes other valuable information.
Example: Product P004 – Notebook exists only in some customer orders. If we delete ALL rows that correspond to a particular order, we may accidentally lose product information if it appears nowhere else.
Consider row:
ORD1027,C002,Priya Sharma,priya@gmail.com,Delhi,P004,Notebook,Stationery,120,4,2023-11-02,SR02,Anita Desai,anita@corp.com,"Delhi Office, Connaught Place, New Delhi - 110001"

If this were the only row containing product P004, deleting this order would remove all record of Notebook—its name, category, and price.
Actual Rows Involving P004:

ORD1027 (Priya Sharma)
ORD1133 (Rohan Mehta)
ORD1021 (Kavya Rao)
ORD1049 (Arjun Nair)
If all P004-related orders are deleted, the system loses all knowledge of the Notebook product.
This demonstrates a delete anomaly.
These anomalies show why normalization (splitting into Customers, Orders, Products, Sales Reps, etc.) is necessary to reduce redundancy and improve data integrity.

## Normalization Justification

Keeping everything in a single flat table may seem simpler at first, but the orders_flat.csv dataset clearly demonstrates how this approach leads to significant data quality and maintenance issues. The presence of repeated customer details, product information, and sales representative data across hundreds of rows introduces redundancy. For example, customer Neha Gupta (C006) appears in multiple rows, each duplicating her name, email, and city. Any update to her email would require modifying many rows, creating a high risk of inconsistencies—one of the most common update anomalies.
Similarly, product details such as P004 – Notebook, including its name, category, and unit price, are repeated every time the product appears in an order. If the price changes, all related rows must be updated manually, inviting data errors. Delete anomalies also arise: removing a single order could unintentionally erase the only reference to a product or sales representative.
Normalization resolves these issues by organizing data into separate, related tables. Each real-world entity—customers, products, sales representatives, orders, and items—is stored once, eliminating redundancy. This structure ensures consistency, improves update efficiency, reduces storage waste, and enforces referential integrity through primary–foreign key relationships. Far from over-engineering, normalization is essential for maintaining accurate, scalable, and reliable systems. It transforms the flat, error-prone structure into a well-organized, maintainable database model suitable for real business operations.

