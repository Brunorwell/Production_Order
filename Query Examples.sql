USE PRODUCTION_ORDER_DATABASE
GO

--Functionality of the associative table PRODUCT_WEIGHT_UNITY:
SELECT pu.product_id as 'product_id', pu.product_name 'Associate product', pwu.weight_id
FROM production_order as PO
	INNER join product_weight as PW
		on PO.weight_id = PW.weight_id
	INNER JOIN product_weight_unity as pwu
		on pwu.weight_id = pw.weight_id
	INNER JOIN product_unity as pu
		on pu.product_id = pwu.product_id

--This query simulates the generation of a label:
SELECT PW.weight_desc AS 'Portuguese name', TW.weight_desc_trans AS 'Spanish name', LC.lot_cod + CAST(L.lot_number AS varchar) AS 'LOT', PO.weight_id AS 'Code of the Product', PO.po_id AS 'PO', DATEADD(MONTH, 18, po.beginning_date) as 'EXPIRATION DATE'
FROM production_order AS PO
	INNER JOIN product_weight AS PW
		ON PO.weight_id = PW.weight_id
	INNER JOIN translation_weight as TW
		ON TW.weight_id = PW.weight_id
	INNER JOIN idiom AS I
		ON I.idiom_id = TW.idiom_id
	INNER JOIN lot as L
		ON L.lot_id = PO.lot_id
	INNER JOIN lot_code AS LC
		ON L.lot_cod_id = LC.lot_cod_id
WHERE I.idiom_name = 'ES'

--Production order generation:
SELECT PO.po_id AS 'PRODUCT_ORDER', PO.issue_date AS 'ISSUE DATE', PW.weight_desc AS 'PRODUCT', PW.weight_id AS 'CODE', LC.lot_cod + CAST(L.lot_number AS varchar) AS 'LOT', PO.beginning_date AS 'START DATE', PO.delivery_date AS 'DELIVERY DATE', PO.obs AS 'OBS', PM.product_id AS 'UNITY PRODUCT CODE', PM.quantity AS 'QUANTITY OF PRODUCTS', BX.box_id AS 'BOX CODE', BX.quantity AS 'QUANTITY OF BOXES'
FROM production_order AS PO
	INNER JOIN product_weight AS PW
		ON PO.weight_id = PW.weight_id
	INNER JOIN lot AS L
		ON PO.lot_id = L.lot_id
	INNER JOIN lot_code AS LC
		ON L.lot_cod_id = LC.lot_cod_id
	INNER JOIN product_movement as PM
		ON PM.lot_id = PO.lot_id
	INNER JOIN box_movement AS BX
		ON BX.po_id = PO.po_id