
create table OnlineCustomer
(
	id int primary key,
	name varchar(50),
	status bit
);

create table Product
(
	id int primary key,
	description varchar(max)
);

create table ShoppingCart
(
	id int primary key,
	status bit,
	online_cust_id int foreign key references OnlineCustomer(id)
);

create table ShoppingCartItem
(
	id int primary key,
	quantity int,
	status bit,
	shop_cart_id int foreign key references ShoppingCart(id),
	product_id int foreign key references Product(id)
);

drop table Product;
--Could not drop object 'Product' because it is referenced by a FOREIGN KEY constraint.
