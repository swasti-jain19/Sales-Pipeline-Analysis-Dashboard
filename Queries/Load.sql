CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY,
    account_name TEXT,
    sector TEXT,
    year_established INTEGER,
    revenue TEXT,
    employees INTEGER,
    office_location TEXT,
    subsidiary_of TEXT
);
	
-- COPY command (after saving as CSV)
COPY accounts FROM 'C:\DA\Projects\PowerBi\Sales Pipeline Analysis\Data\accounts.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    series TEXT,
    sales_price TEXT
);
	
COPY products FROM 'C:\DA\Projects\PowerBi\Sales Pipeline Analysis\Data\products.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE sales_pipeline (
    opportunity_id TEXT PRIMARY KEY,
    agent_id INTEGER,
    product_id INTEGER,
    account_id INTEGER,
    deal_stage TEXT,
    engage_date DATE,
    close_date DATE,
    close_value TEXT,
	FOREIGN KEY (agent_id) REFERENCES sales_teams(agent_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

COPY sales_pipeline FROM 'C:\DA\Projects\PowerBi\Sales Pipeline Analysis\Data\sales_pipeline.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE sales_teams (
    agent_id INTEGER PRIMARY KEY,
    sales_agent TEXT,
    manager TEXT,
    regional_office TEXT
);

COPY sales_teams FROM 'C:\DA\Projects\PowerBi\Sales Pipeline Analysis\Data\sales_teams.csv' DELIMITER ',' CSV HEADER;