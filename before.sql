-- Intentionally denormalized "spreadsheet" table for the fix-it scenario.
-- Replace/extend with your instructor-provided messy table as needed.

DROP TABLE IF EXISTS orders_denorm CASCADE;

CREATE TABLE IF NOT EXISTS orders_denorm (
    orderid TEXT PRIMARY KEY,
    customer_name TEXT NOT NULL,
    customer_email TEXT NOT NULL,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    qty INTEGER NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL,
    warehouse_name TEXT NOT NULL,
    sales_rep_name TEXT NOT NULL
);

INSERT INTO orders_denorm (orderid, customer_name, customer_email, product_name, category, qty, unit_price, warehouse_name, sales_rep_name)
VALUES
    ('O-1001', 'Acme Corp', 'acme@acme.com', 'Hex Bolt M8', 'Fastener', 500, 0.12, 'Pacific Northwest', 'Sarah Chen'),
    ('O-1001', 'Acme Corp', 'acme@acme.com', 'Lock Washer', 'Fastener', 500, 0.08, 'Pacific Northwest', 'Sarah Chen'),
    ('O-1002', 'BuildRight', 'br@build.com', 'Power Drill', 'Tools', 10, 89.99, 'Mountain West', 'Mike Torres'),
    ('O-1003', 'Acme Corp', 'acme@acme.com', 'Hex Bolt M8', 'Fastener', 200, 0.12, 'Southwest', 'Sarah Chen'),
    ('O-1004', 'SteelWorks', 'sw@steel.com', 'Steel Pipe', 'Material', 50, 24.50, 'Mountain West', 'Mike Torres'),
    ('O-1005', 'BuildRight', 'br@build.com', 'Hex Bolt M8', 'Fastener', 300, 0.12, 'Pacific Northwest', 'Lisa Park');
