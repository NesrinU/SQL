USE pro_angSQL;

SELECT * INTO #ang1 FROM ang WHERE abt_nr = 2;

USE tempdb;
SELECT * FROM #ang1;

USE pro_angSQL;
GO
CREATE VIEW vwEntwickler AS 
SELECT * FROM ang WHERE abt_nr = 3;

BEGIN TRAN
INSERT INTO vwEntwickler (a_nr, name, abt_nr)
VALUES 
(772, 'Gauss', 2);

SELECT * FROM vwEntwickler;

SELECT * FROM ang;
ROLLBACK

ALTER VIEW vwEntwickler AS 
SELECT * FROM ang WHERE abt_nr = 3 WITH CHECK OPTION;


