UPDATE products
SET sales_price = REGEXP_REPLACE(sales_price, '[^0-9.]', '', 'g');

ALTER TABLE products
ALTER COLUMN sales_price TYPE NUMERIC USING sales_price::NUMERIC;

UPDATE accounts
SET revenue = REGEXP_REPLACE(revenue, '[^0-9.]', '', 'g');

ALTER TABLE accounts
ALTER COLUMN revenue TYPE NUMERIC USING revenue::NUMERIC;

UPDATE sales_pipeline
SET close_value = REGEXP_REPLACE(close_value, '[^0-9.]', '', 'g');

ALTER TABLE sales_pipeline
ALTER COLUMN close_value TYPE NUMERIC USING close_value::NUMERIC;

select * from sales_pipeline