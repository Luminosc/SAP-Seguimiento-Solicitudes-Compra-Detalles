Cliente MDA
MDA47
Solicitud para reporte de seguimiento para Solicitudes de compra.
Versión con datos completos.
En Nuestros documentos General>Fernando Orozco 2024-12-02
En el servidor del cliente Seguimiento SC Detalle


SELECT T1.DocEntry AS IDSoliciudCompra, T1.ItemCode, T1.Dscription, T1.Quantity , T1.Price , T1.LineStatus,

            T2.DocEntry AS IDOfertaCompra, T2.Quantity , T2.Price, T2.LineStatus,

            T3.DocEntry AS IDOrdenDeCompra, T3.Quantity, T3.Price, T3.LineStatus,

           T4.DocEntry AS IDEntregaMercancia, T4.Quantity , T4.Price, T4.LineStatus,

            T5.DocEntry AS IDFacturaProvedor, T5.Quantity , T5.Price, T5.LineStatus

FROM PRQ1 T1 --Solicitud De Compra
FULL OUTER JOIN PQT1 T2 -- Oferta de Compra
ON T1.DocEntry = T2.BaseEntry AND T1.objType = T2.BaseType  AND T1.LineNum = T2.LineNum
FULL OUTER JOIN POR1 T3 --Orden de Compra
ON T1.DocEntry = T3.BaseEntry AND T1.objType = T3.BaseType  AND T1.LineNum = T3.LineNum AND T3.LineStatus = 'C' AND T3.TrgetEntry IS NOT NULL
OR T2.DocEntry = T3.BaseEntry AND T2.objType = T3.BaseType  AND T1.LineNum = T3.LineNum AND T3.LineStatus = 'C' AND T3.TrgetEntry IS NOT NULL
OR T1.DocEntry = T3.BaseEntry AND T1.objType = T3.BaseType  AND T1.LineNum = T3.LineNum AND T3.LineStatus = 'O'
OR T2.DocEntry = T3.BaseEntry AND T2.objType = T3.BaseType  AND T1.LineNum = T3.LineNum AND T3.LineStatus = 'O'
FULL OUTER JOIN PDN1 T4 --Entrega Mercancia
ON T3.DocEntry = T4.BaseEntry AND T3.objType = T4.BaseType AND T3.LineNum = T4.LineNum AND T4.LineStatus = 'C' AND T4.TrgetEntry IS NOT NULL AND T4.TargetType <> 21
OR T2.DocEntry = T4.BaseEntry AND T2.objType = T4.BaseType AND T2.LineNum = T4.LineNum AND T4.LineStatus = 'C' AND T4.TrgetEntry IS NOT NULL AND T4.TargetType <> 21
OR T1.DocEntry = T4.BaseEntry AND T1.objType = T4.BaseType AND T1.LineNum = T4.LineNum AND T4.LineStatus = 'C' AND T4.TrgetEntry IS NOT NULL AND T4.TargetType <> 21
OR T3.DocEntry = T4.BaseEntry AND T3.objType = T4.BaseType AND T3.LineNum = T4.LineNum AND T4.LineStatus = 'O'
OR T2.DocEntry = T4.BaseEntry AND T2.objType = T4.BaseType AND T2.LineNum = T4.LineNum AND T4.LineStatus = 'O'
OR T1.DocEntry = T4.BaseEntry AND T1.objType = T4.BaseType AND T1.LineNum = T4.LineNum AND T4.LineStatus = 'O'
FULL OUTER JOIN PCH1 T5 --Factura Provedor 
ON T4.DocEntry = T5.BaseEntry AND T4.objType = T5.BaseType AND T5.BaseType <> 18 AND T5.TargetType<> 18 AND T4.LineNum = T5.LineNum AND T5.LineStatus = 'C' AND T5.TrgetEntry IS NOT NULL
OR T3.DocEntry = T5.BaseEntry AND T3.objType = T5.BaseType AND T5.BaseType <> 18 AND T5.TargetType<> 18 AND T3.LineNum = T5.LineNum AND T5.LineStatus = 'C' AND T5.TrgetEntry IS NOT NULL
OR T2.DocEntry = T5.BaseEntry AND T2.objType = T5.BaseType AND T5.BaseType <> 18 AND T5.TargetType<> 18 AND T2.LineNum = T5.LineNum AND T5.LineStatus = 'C' AND T5.TrgetEntry IS NOT NULL
OR T4.DocEntry = T5.BaseEntry AND T4.objType = T5.BaseType AND T5.BaseType <> 18 AND T5.TargetType<> 18 AND T4.LineNum = T5.LineNum AND T5.LineStatus = 'O'
OR T3.DocEntry = T5.BaseEntry AND T3.objType = T5.BaseType AND T5.BaseType <> 18 AND T5.TargetType<> 18 AND T3.LineNum = T5.LineNum AND T5.LineStatus = 'O'
OR T2.DocEntry = T5.BaseEntry AND T2.objType = T5.BaseType AND T5.BaseType <> 18 AND T5.TargetType<> 18 AND T2.LineNum = T5.LineNum AND T5.LineStatus = 'O'
WHERE T1.DocEntry = [%0]
ORDER BY T1.DocEntry, T2.DocEntry, T2.baseLine, T3.DocEntry, T3.BaseLine, T4.DocEntry, T4.BaseLine, T5.DocEntry, T5.BaseLine