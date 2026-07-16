-- SQL Test Data Validation — Schema and Sample Data
-- Run this entire script to build the database from scratch

PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_name TEXT,
    price REAL,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Sample data (includes intentional issues for validation queries to catch)
INSERT INTO customers VALUES (1, 'Amara Perera', 'amara@email.com');
INSERT INTO customers VALUES (2, 'Nadeesha Silva', NULL);
INSERT INTO customers VALUES (3, 'Kasun Fernando', 'kasun@email.com');

INSERT INTO orders VALUES (101, 1, '2026-07-01', 45.00);
INSERT INTO orders VALUES (102, 2, '2026-07-02', 30.00);
INSERT INTO orders VALUES (103, 1, '2026-07-03', 999.00);
INSERT INTO orders VALUES (104, 99, '2026-07-04', 20.00);

INSERT INTO order_items VALUES (1, 101, 'Book', 15.00, 3);
INSERT INTO order_items VALUES (2, 102, 'Pen', 10.00, 3);
INSERT INTO order_items VALUES (3, 103, 'Laptop', 300.00, 1);
