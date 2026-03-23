-- Intentionally denormalized "spreadsheet" table for the fix-it scenario.
-- Replace/extend with your instructor-provided messy table as needed.

CREATE TABLE IF NOT EXISTS orders_denorm (
    id SERIAL PRIMARY KEY,
    customer_name TEXT NOT NULL,
    customer_email TEXT NOT NULL,
    product_sku TEXT NOT NULL,
    product_name TEXT NOT NULL,
    qty INTEGER NOT NULL,
    order_status TEXT NOT NULL
);

INSERT INTO orders_denorm (customer_name, customer_email, product_sku, product_name, qty, order_status)
VALUES
    ('Avery Lopez', 'avery.lopez@example.com', 'SKU-001', 'Widget A', 2, 'CONFIRMED');
