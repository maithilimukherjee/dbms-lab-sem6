CREATE TABLE Client_Master_001(
Client_no varchar2(6) PRIMARY KEY check(Client_no like 'C%'),
Name varchar2(20) NOT NULL,
City varchar2(15),
Pincode number(8),
State varchar2(15),
Bal_due number(10,2));

CREATE TABLE product_master_001(
Product_no varchar2(6) PRIMARY KEY check(Product_no like 'P%'),
Description varchar2(15) NOT NULL,
Profit_percent number(4,2) NOT NULL,
Unit_measure varchar2(10) NOT NULL,
Qty_on_hand number(8) NOT NULL,
Reorder_lvl number(8) NOT NULL,
Sell_price number(8,2) NOT NULL check(Sell_price>0),
Cost_price number(8,2) NOT NULL check(Cost_price>0));


CREATE TABLE salesman_master_001(
Salesman_no varchar2(6) PRIMARY KEY check(Salesman_no like 'S%'),
Salesman_name varchar2(20) NOT NULL,
Address1 varchar2(10) NOT NULL,
Address2 varchar2(20),
City varchar2(20),
Pincode number(7),
State varchar2(20),
Sal_amt number(8,2) NOT NULL check(Sal_amt>0),
Tgt_to_get number(6,2) NOT NULL check(Tgt_to_get>0),
Ytd_sales number(6,2) NOT NULL,
Remarks varchar2(20));

CREATE TABLE sales_order_001(
Order_no varchar2(6) PRIMARY KEY check(Order_no like 'O%'),
Order_date date,
Client_no varchar2(6) references Client_Master_001(Client_no),
Dely_address varchar2(25),
Salesman_no varchar2(6) references salesman_master_001(Salesman_no),
Dely_type char(1) default('F') check (Dely_type in ('P', 'F')),
Billed_yn char(1),
Dely_date date,
Order_status varchar2(10) check (Order_status in ('in process','fulfilled','backorder','cancelled')),
check(Dely_date>Order_date));

CREATE TABLE sales_order_details_001(
Order_no varchar2(6) references sales_order_001(Order_no),
Product_no varchar2(6) references product_master_001(Product_no),
Qty_ordered number(8),
Qty_Disp number(8),
Product_rate number(10,2),
PRIMARY KEY(Order_no, Product_no),
FOREIGN KEY(Order_no) references sales_order_001(Order_no),
FOREIGN KEY(Product_no) references product_master_001(Product_no));

INSERT INTO Client_Master_001 VALUES
('&Client_no', '&Name', '&City', &Pincode, '&State', &Baldue);

INSERT INTO product_master_001 values('P03453',	'Shirts',	6,	'Piece',	150,	50,	500,	350);
INSERT INTO product_master_001 values('P06734',	'Cotton Jeans',	5,	'Piece',	100,	20,	600,	450);
INSERT INTO product_master_001 values('P07865',	'Jeans',	5,	'Piece',	100,	20,	750,	500);
INSERT INTO product_master_001 values('P07868',	'Trousers',	2,	'Piece',	150,	50,	850,	550);
INSERT INTO product_master_001 values('P07885',	'PuM-Overs',	2.5,	'Piece',	80,	30,	700,	450);
INSERT INTO product_master_001 values('P07965',	'Denim Shirts',	4,	'Piece',	100,	40,	350,	250);
INSERT INTO product_master_001 values('P07975',	'Lyers Tops',	5,	'Piece',	70,	30,	300,	175);
INSERT INTO product_master_001 values('P08865',	'Skirts',	5,	'Piece',	75,	30,	450,	300);

INSERT INTO salesman_master_001 values('S00001','Aman','A/14', 'Worli','Mumbai', 400002,'Maharashtra' , 3000, 100, 50 ,'Good');
INSERT INTO salesman_master_001 values('S00002', 'Omkar', '65','Nariman','Mumbai',400001,'Maharashtra', 3000 ,200 ,100 ,'Good');
INSERT INTO salesman_master_001 values('S00003' ,'Raj' ,'P-7','Bandra', 'Mumbai' ,400032 ,'Maharashtra',3000, 200, 100, 'Good');
INSERT INTO salesman_master_001 values('S00004','Ashish','A/5','Juhu' ,'Mumbai',400044,'Maharashtra',3500 ,200, 150 ,'Good');

INSERT INTO sales_order_001
VALUES ('O19001',
        TO_DATE('12-06-2004','DD-MM-YYYY'),
        'C00001',
        'ABC',
        'S00001',
        'F',
        'N',
        TO_DATE('20-07-2004','DD-MM-YYYY'),
        'in process');

INSERT INTO sales_order_001
VALUES ('O19002',
        TO_DATE('27-06-2002','DD-MM-YYYY'),
        'C00002',
        'CDE',
        'S00001',
        'P',
        'N',
        TO_DATE('25-06-2004','DD-MM-YYYY'),
        'cancelled');

INSERT INTO sales_order_001
VALUES ('O46865',
        TO_DATE('20-02-2002','DD-MM-YYYY'),
        'C00003',
        'CDE',
        'S00003',
        'F',
        'Y',
        TO_DATE('18-02-2004','DD-MM-YYYY'),
        'fulfilled');

INSERT INTO sales_order_001
VALUES ('O19003',
        TO_DATE('07-04-2002','DD-MM-YYYY'),
        'C00003',
        'PQR',
        'S00001',
        'F',
        'Y',
        TO_DATE('03-04-2004','DD-MM-YYYY'),
        'fulfilled');

INSERT INTO sales_order_001
VALUES ('O46866',
        TO_DATE('20-05-2002','DD-MM-YYYY'),
        'C00004',
        'CCU',
        'S00001',
        'P',
        'N',
        TO_DATE('22-05-2004','DD-MM-YYYY'),
        'fulfilled');

INSERT INTO sales_order_001
VALUES ('O19008',
        TO_DATE('26-07-2002','DD-MM-YYYY'),
        'C00004',
        'IXB',
        'S00004',
        'F',
        'N',
        TO_DATE('24-05-2004','DD-MM-YYYY'),
        'in process');


