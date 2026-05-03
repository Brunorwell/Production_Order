CREATE DATABASE PRODUCTION_ORDER_DATABASE
GO

USE PRODUCTION_ORDER_DATABASE
GO

--TABLES CREATION:

CREATE TABLE product_unity( 
	product_id	char(04),
	product_name		varchar(100),
	constraint pk_product primary key(product_id)
)
GO

CREATE TABLE idiom(
	idiom_id		int not null,
	idiom_name		varchar(15),
	constraint pk_idiom primary key (idiom_id)
)
GO

CREATE TABLE box_register(
	box_id		char(11),
	box_desc	varchar(100),	
	constraint pk_box primary key	(box_id)
)
GO

CREATE TABLE lot_category(
	lot_category_id	int not null,
	lot_cod		char(08),
	constraint pk_category_id primary key (lot_category_id)
)
GO

CREATE TABLE product_weight(
	weight_id	char(12),
	weight_desc	varchar(50),
	box_id		char(11),
	constraint pk_weight_id primary key (weight_id),
	constraint fk_box_id foreign key (box_id) references box_register(box_id)
)
GO

CREATE TABLE product_weight_unity(
	product_id	char(04),
	weight_id	char(12),
	constraint pk_product_weight primary key (product_id, weight_id),
	constraint fk_product_id foreign key (product_id) references product_unity(product_id),
	constraint fk_weight_id foreign key (weight_id) references product_weight(weight_id)
)
GO

CREATE TABLE translation_product(
	product_id			char(04),
	idiom_id			int not null,
	product_name_trans	varchar(50),
	constraint pk_idiom_weight primary key (product_id, idiom_id),
	constraint fk_product_trans	foreign key (product_id) references product_unity(product_id),
	constraint fk_idiom_id  foreign key (idiom_id)  references idiom(idiom_id)
)
GO

CREATE TABLE lot(
	lot_id	int not null,
	lot_number int not null,
	lot_category_id int not null,
	constraint pk_lot_id primary key (lot_id),
	constraint fk_lot_category_id foreign key (lot_category_id) references lot_category(lot_category_id)
)
GO

CREATE TABLE production_order(
	po_id			int not null,
	issue_date		date,
	beginning_date	date,
	delivery_date	date,
	obs				varchar(100),
	lot_id	int not null UNIQUE,
	constraint fk_lot_po foreign key (lot_id) references lot(lot_id),
	constraint pk_po_id primary key (po_id),
)		
GO

CREATE TABLE product_movement(
    product_id  char(04)    not null,
    weight_id   char(12)	not null,
    lot_id      int         not null UNIQUE,
    quantity    int         not null,
    constraint pk_pm primary key (product_id, weight_id, lot_id),
    constraint fk_pwu_pm foreign key (product_id, weight_id) 
        references product_weight_unity(product_id, weight_id),
    constraint fk_lot_pm foreign key (lot_id) references lot(lot_id)
)

CREATE TABLE box_movement(
	box_id	char(11),
	lot_id	int not null,
	quantity int not null,
	constraint fk_box_bm foreign key (box_id) 
		references box_register(box_id),
	constraint fk_lot_bm foreign key (lot_id) 
		references lot(lot_id),
	constraint pk_bm primary key (box_id, lot_id)
)
GO


--DATA INSERTION

INSERT INTO product_unity (product_id, product_name)
	VALUES	('F001', 'FRUTIE SOBREM MORANGO CREMOSO'),
			('F002', 'FRUTIE SOBREM PAVE DE ABACAXI'),
			('F003', 'FRUTIE SOBREM TORTA DE LIMAO'),
			('A001', 'AMORAS'),
			('D001', 'DENTADURAS')
GO

INSERT INTO idiom(idiom_id, idiom_name)
	VALUES	(1, 'ES'),
			(2, 'EN')
GO

INSERT INTO box_register(box_id, box_desc)
	VALUES	('ME0BR257681', 'CX PAP COLOR 12X100G V0'),
			('ME0BR257703', 'CX COLOR DP AUT 24X12X15 V0')
GO

INSERT INTO lot_category(lot_category_id, lot_cod)
	VALUES	(1, 'GOMA'),
			(2,	'GEL'),
			(3, 'CHICLETE')
GO

INSERT INTO product_weight(weight_id, weight_desc, box_id)
	VALUES	('111070F07611', '12X70G', 'ME0BR257681'),
			('113018A00104', '24X12X15G', 'ME0BR257703')
GO

INSERT INTO product_weight_unity(product_id, weight_id)
	VALUES	('A001', '111070F07611'),
			('F001', '113018A00104'),
			('F001', '111070F07611'),
			('F002', '111070F07611'),
			('F002', '113018A00104'),
			('F003', '113018A00104')
GO

INSERT INTO translation_product(product_id, idiom_id, product_name_trans)
	VALUES	('F001', 1, 'FRUTIE POSTRE FRESA CREMOSA'),
			('F001', 2, 'FRUTIE DESSERT CREAMY STRAWBERRY'),
			('F002', 1, 'FRUTIE POSTRE PAVÉ DE PIÑA'),
			('F002', 2, 'FRUTIE DESSERT PINEAPPLE PAVÉ'),
			('F003', 1, 'FRUTIE POSTRE TARTA DE LIMÓN'),
			('F003', 2, 'FRUTIE DESSERT LEMON PIE')
GO

INSERT INTO lot(lot_id, lot_number, lot_category_id)
	VALUES	(1, 446, 1),
			(2, 450, 1),
			(3, 514, 1),
			(4, 994, 1),
			(5, 995, 1)
GO

INSERT INTO production_order(po_id, issue_date, beginning_date, delivery_date, obs, lot_id)
	VALUES	(61549, '12/12/2024', '12/09/2024', '12/15/2024', null, 2),
			(61487, '11/08/2024', '11/11/2024', '11/17/2024', null, 1),
			(61488, '05/03/2026', '05/06/2026', '10/06/2026', null, 3),
			(61489, '05/10/2026', '05/11/2026', '05/15/2026', null, 4),
			(61490, '05/10/2026', '05/11/2026', '05/17/2026', null, 5)
GO

INSERT INTO product_movement(product_id, weight_id, lot_id, quantity)
	VALUES	('A001','111070F07611', 2, 180000),
			('F003','113018A00104', 1, 43200),
			('F001', '113018A00104',3, 1008),
			('F002','111070F07611', 4, 1000),
			('F002','113018A00104', 5, 1000)
GO

INSERT INTO box_movement(box_id, lot_id, quantity)
	VALUES	('ME0BR257703', 3, 500),
			('ME0BR257681', 4, 600),
			('ME0BR257681', 2, 200),
			('ME0BR257703', 1, 150),
			('ME0BR257703', 5, 180)
GO








