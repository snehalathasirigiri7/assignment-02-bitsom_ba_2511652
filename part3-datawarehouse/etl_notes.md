## ETL Decisions

### Decision 1 — Standardizing Date Formats
Problem: The raw CSV had inconsistent date formats (DD/MM/YYYY, YYYY-MM-DD, MM-DD-YYYY).
Resolution: All dates were parsed and converted into ISO format (YYYY-MM-DD) before loading into dim_date.

### Decision 2 — Fixing NULL and Missing Store Cities
Problem: Several rows had missing city values.
Resolution: These were corrected using store_name mappings or filled with the correct city from other matching transactions.

### Decision 3 — Normalizing Product Categories
Problem: Categories like "electronics", "Electronics", "Groceries", "Grocery" were inconsistent.
Resolution: All categories were normalized to title case (Electronics, Clothing, Grocery) before loading into dim_product.
