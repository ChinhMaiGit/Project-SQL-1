-- establish the database
DROP DATABASE IF EXISTS olist;
CREATE DATABASE olist;

-- creating schema 'olist'
CREATE SCHEMA IF NOT EXISTS olist;
SET SCHEMA 'olist';

-- IMPORTING DATA TO OLIST DATABASE

-- The order of importing data should be:
-- geolocation > customers/sellers > orders > order_reviews/order_payments > category_names_english > products > order_items
-- due to the constraints of the foreign keys

-- Create table geolocation
DROP TABLE IF EXISTS geolocation;
CREATE TABLE IF NOT EXISTS geolocation (
	zip_code_prefix INTEGER NOT NULL,
	latitude NUMERIC,
	longitude NUMERIC,
	city TEXT,
	state TEXT
);
COPY geolocation FROM 'E:/Data/Olist/olist_geolocation_dataset.csv' HEADER CSV DELIMITER ',';
--zip_code_prefix has duplicate values for the same zip code prefix, cannot be used for primary key some manipulations are needed,
--will not be connected to other tables since it will cause dupplications when joining

-- Create table customers
DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers (
	customer_id TEXT PRIMARY KEY NOT NULL,
	customer_unique_id TEXT,
	zip_code_prefix INTEGER NOT NULL,
	city TEXT,
	state TEXT
);
COPY customers FROM 'E:/Data/Olist/olist_customers_dataset.csv' HEADER CSV DELIMITER ',';

-- Create table sellers
DROP TABLE IF EXISTS sellers;
CREATE TABLE IF NOT EXISTS sellers (
	seller_id TEXT PRIMARY KEY NOT NULL,
	zip_code_prefix INTEGER,
	city TEXT,
	state TEXT
);
COPY sellers FROM 'E:/Data/Olist/olist_sellers_dataset.csv' HEADER CSV DELIMITER ',';

-- Create table orders
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (
	order_id TEXT PRIMARY KEY NOT NULL,
	customer_id TEXT NOT NULL,
	status TEXT,
	purchase_timestamp TIMESTAMP,
	approval_timestamp TIMESTAMP,
	delivered_carrier_date TIMESTAMP,
	delivered_customer_date TIMESTAMP,
	estimated_delivery_date TIMESTAMP,
	CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
COPY orders FROM 'E:/Data/Olist/olist_orders_dataset.csv' HEADER CSV DELIMITER ',';

-- Create table order_reviews
DROP TABLE IF EXISTS order_reviews;
CREATE TABLE IF NOT EXISTS order_reviews (
	review_id TEXT NOT NULL,
	order_id TEXT NOT NULL,
	rating INTEGER,
	review_title TEXT,
	review_content TEXT,
	creation_timestamp TIMESTAMP,
	answer_timestamp TIMESTAMP,
	CONSTRAINT fk_reviews FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
COPY order_reviews FROM 'E:/Data/Olist/olist_order_reviews_dataset.csv' HEADER CSV DELIMITER ',';

-- Create table order_payments
DROP TABLE IF EXISTS order_payments;
CREATE TABLE IF NOT EXISTS order_payments (
	order_id TEXT NOT NULL,
	payment_sequential INTEGER,
	payment_type TEXT,
	payment_installments INTEGER,
	payment_value NUMERIC,
	CONSTRAINT fk_payments FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
COPY order_payments FROM 'E:/Data/Olist/olist_order_payments_dataset.csv' HEADER CSV DELIMITER ',';

-- Create table category_names_english
DROP TABLE IF EXISTS category_names_english;
CREATE TABLE IF NOT EXISTS category_names_english (
	product_category TEXT PRIMARY KEY NOT NULL,
	product_category_eng TEXT
);
COPY category_names_english FROM 'E:/Data/Olist/product_category_name_translation.csv' HEADER CSV DELIMITER ',';
-- does not contain English name for the category 'pc_gamer', 'portateis_cozinha_e_preparadores_de_alimentos' manual additions are needed

-- Create table products
DROP TABLE IF EXISTS products;
CREATE TABLE IF NOT EXISTS products (
	product_id TEXT PRIMARY KEY NOT NULL,
	product_category TEXT,
	name_length INTEGER,
	description_length INTEGER,
	photos_quantity INTEGER,
	weight_g INTEGER,
	length_cm INTEGER,
	height_cm INTEGER,
	width_cm INTEGER,
	CONSTRAINT fk_cateogry_eng FOREIGN KEY (product_category) REFERENCES category_names_english(product_category)
);
COPY products FROM 'E:/Data/Olist/olist_products_dataset.csv' HEADER CSV DELIMITER ',';

-- Create table order_items
DROP TABLE IF EXISTS order_items;
CREATE TABLE IF NOT EXISTS order_items (
	order_id TEXT NOT NULL,
	item_id TEXT,
	product_id TEXT NOT NULL,
	seller_id TEXT NOT NULL,
	shipping_limit_date TIMESTAMP,
	price NUMERIC,
	freight_value NUMERIC,
	CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products(product_id),
	CONSTRAINT fk_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
	CONSTRAINT fk_sellers FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);
COPY order_items FROM 'E:/Data/Olist/olist_order_items_dataset.csv' HEADER CSV DELIMITER ',';
