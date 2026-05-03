USE PRODUCTION_ORDER_DATABASE
GO

--Functionality of the associative table PRODUCT_WEIGHT_UNITY:

SELECT pu.product_id, pu.product_name 'Product Name', pw.weight_id, pw.weight_desc 'Weight description'
FROM product_weight_unity AS pwu
    INNER JOIN product_unity AS pu
        ON pu.product_id = pwu.product_id
    INNER JOIN product_weight AS pw
        ON pw.weight_id = pwu.weight_id
WHERE pu.product_id like 'F%'

SELECT * FROM product_weight_unity WHERE product_id like 'F%'

--This query simulates the generation of a label:
SELECT PO.po_id, PO.lot_id, PU.product_name AS 'Portuguese Name', TP.product_name_trans, PM.quantity
FROM production_order as PO
	INNER JOIN lot as L
		ON L.lot_id = PO.lot_id
	INNER JOIN product_movement AS PM
		ON PM.lot_id = L.lot_id
	INNER JOIN product_unity as PU
		ON PU.product_id = PM.product_id
	INNER JOIN translation_product  AS TP
		ON TP.product_id = PU.product_id


--Production order generation:
SELECT PO.po_id AS 'Product Order', PO.issue_date AS 'Issue dade', PO.beginning_date AS 'Start date', PO.delivery_date AS 'Delivery Date', PU.product_name AS 'Product Name', PM.quantity AS 'Quantity of products', PW.weight_desc AS 'Weight Description',BR.box_desc, BM.quantity AS 'Box Quantity', L.lot_number AS 'Lot Number', LC.lot_cod AS 'Lot Code'
FROM production_order AS PO
	INNER JOIN lot AS L
		ON PO.lot_id = L.lot_id  
	INNER JOIN product_movement as PM -- Quantidade de produtos
		ON L.lot_id = PM.lot_id
	INNER JOIN product_unity as PU -- Descrição do produto
		ON PM.product_id = PU.product_id
	INNER JOIN product_weight as PW -- Descrição do peso
		ON PM.weight_id = PW.weight_id
	INNER JOIN box_movement as BM -- Quantidade de embalagens
		ON L.lot_id = BM.lot_id
	INNER JOIN box_register AS BR -- Descrição da Embalagem
		ON BM.box_id = BR.box_id 
	INNER JOIN lot_category AS LC -- Descrição do Lote
		ON L.lot_category_id = LC.lot_category_id