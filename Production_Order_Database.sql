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

CREATE TABLE lot_code(
	lot_cod_id	int not null,
	lot_cod		char(04),
	constraint pk_lot_cod primary key (lot_cod_id)
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

CREATE TABLE translation_weight(
	weight_id			char(12),
	idiom_id			int not null,
	weight_desc_trans	varchar(50),
	constraint pk_idiom_weight primary key (weight_id, idiom_id),
	constraint fk_weight_trans	foreign key (weight_id) references product_weight(weight_id),
	constraint fk_idiom_id  foreign key (idiom_id)  references idiom(idiom_id)
)
GO

CREATE TABLE lot(
	lot_id	int not null,
	lot_number int not null,
	lot_cod_id int not null,
	constraint pk_lot_id primary key (lot_id),
	constraint fk_lot_cod_id foreign key (lot_cod_id) references lot_code(lot_cod_id)
)
GO

CREATE TABLE production_order(
	po_id			int not null,
	issue_date		date,
	beginning_date	date,
	delivery_date	date,
	total_2_to_one	int not null,
	obs				varchar(100),
	weight_id	char(12),
	lot_id	int not null,
	constraint pk_po_id primary key (po_id), 
	constraint fk_product_weight_po foreign key (weight_id) references product_weight(weight_id),
	constraint fk_lot_po foreign key (lot_id) references lot(lot_id)
)		
GO

CREATE TABLE product_movement(
	product_id	char(04),
	lot_id	int not null,
	quantity int not null,
	constraint fk_pro_pm foreign key (product_id) references product_unity(product_id),
	constraint fk_lot_pm foreign key (lot_id) references lot(lot_id),
	constraint pk_pk primary key (product_id)
)
GO

CREATE TABLE box_movement(
	box_id		char(11),
	lot_id	int not null,
	quantity int not null,
	po_id			int not null,
	constraint fk_box_bm foreign key (box_id) references box_register(box_id),
	constraint fk_lot_bm foreign key (lot_id) references lot(lot_id),
	constraint pk_bm primary key (box_id),
	constraint fk_po_bx foreign key (po_id) references production_order(po_id)
)
GO


--DATA INSERTION

INSERT INTO product_unity (product_id, product_name)
	VALUES	('F005', 'FRUTIE SOBREM MORANGO CREMOSO'),
			('F013', 'FRUTIE SOBREM PAVE DE ABACAXI'),
			('F014', 'FRUTIE SOBREM TORTA DE LIMAO'),
			('A008', 'AMORAS 1,55G'),
			('D017', 'DENTADURAS 5,5G M3')
GO

INSERT INTO idiom(idiom_id, idiom_name)
	VALUES	(1, 'ES'),
			(2, 'EN')
GO

INSERT INTO box_register(box_id, box_desc)
	VALUES	('ME0BR257681', 'CX PAP COLOR 12X100G V0'),
			('ME0BR257703', 'CX COLOR DP AUT 24X12X15 V0')
GO

INSERT INTO lot_code(lot_cod_id, lot_cod)
	VALUES	(1, 'GAMO'),
			(2,	'GFRS'),
			(3, 'CX')
GO

INSERT INTO product_weight(weight_id, weight_desc, box_id)
	VALUES	('111070F07611', 'FRUTIE SOBREMESAS 12X70G', 'ME0BR257681'),
			('113018A00104', 'AMORAS 24X12X15G', 'ME0BR257703')
GO

INSERT INTO product_weight_unity(product_id, weight_id)
	VALUES	('A008', '113018A00104'),
			('F005', '111070F07611'),
			('F013', '111070F07611'),
			('F014', '111070F07611')
GO

INSERT INTO translation_weight(weight_id, idiom_id, weight_desc_trans)
	VALUES	('113018A00104', 1, 'GOMA MORAS 15GX12X24'),
			('111070F07611', 1, 'POSTRE FRUTIE 70GX12'),
			('113018A00104', 2, 'BLACKBERRY GUMMIES 15G 12CT X 24PK'),
			('111070F07611', 2, 'FRUTIE DESSERTS 70G 12CT')
GO

INSERT INTO lot(lot_id, lot_number, lot_cod_id)
	VALUES	(1, 446, 2),
			(2, 450, 1),
			(3, 514, 3),
			(4, 994, 3)
GO

INSERT INTO production_order(po_id, issue_date, beginning_date, delivery_date, total_2_to_one, obs, weight_id, lot_id)
	VALUES	(61549, '12/12/2024', '12/09/2024', '12/15/2024', 180000, null, '113018A00104', 2),
			(61487, '11/08/2024', '11/11/2024', '11/17/2024', 43200, null, '111070F07611', 1)
GO

INSERT INTO product_movement(product_id, lot_id, quantity)
	VALUES	('A008', 2, 32400),
			('F005', 1, 1008),
			('F013', 1, 1008),
			('F014', 1, 1008)
GO

INSERT INTO box_movement(box_id, lot_id, quantity, po_id)
	VALUES	('ME0BR257703', 3, 3600, 61549),
			('ME0BR257681', 4, 7500, 61487)
GO








