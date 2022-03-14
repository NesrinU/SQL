-- Aufgabe 3
USE TeachSQL;
GO

-- Tabelle erstellen
CREATE TABLE CrazyTable
(
	ID INT PRIMARY KEY NOT NULL,
	Daten NVARCHAR(MAX) NOT NULL
);
GO

-- Einfügen von Werten
INSERT INTO CrazyTable
VALUES
(1,  'blabla Nr. 1'),
(2,  'blabla Nr. 2'),
(3,  'blabla Nr. 3'),
(4,  'blabla Nr. 4'),
(5,  'blabla Nr. 5'),
(6,  'blabla Nr. 6'),
(7,  'blabla Nr. 7'),
(8,  'blabla Nr. 8'),
(9,  'blabla Nr. 9'),
(10, 'blabla Nr. 10'),
(11, 'blabla Nr. 11');
GO

SELECT * FROM CrazyTable
ORDER BY ID;

GO

SELECT * FROM sys.messages;
GO


-- Trigger erstellen
CREATE TRIGGER tr_Crazy
ON CrazyTable
INSTEAD OF INSERT, DELETE
AS
	BEGIN
		-- Delete oder Insert?
		DECLARE @art INT = (SELECT COUNT(*) FROM deleted);


		-- Insert
		IF @art = 0
			BEGIN
				UPDATE CrazyTable
				SET ID = ID + 1;
				INSERT INTO CrazyTable
				SELECT 1, i.Daten FROM inserted i;
			END

		-- Delete
		ELSE
			BEGIN
				DECLARE @löschpunkt INT = (SELECT ID FROM deleted);
				
				DELETE FROM CrazyTable
				WHERE ID = @löschpunkt;

				UPDATE CrazyTable
				SET ID = ID - 1
				WHERE ID > @löschpunkt;
			END
	RETURN
	END;
GO

-- testen
SELECT * FROM CrazyTable;

INSERT INTO CrazyTable(Daten)
VALUES
('Blubbblubb');

SELECT * FROM CrazyTable;

DELETE FROM CrazyTable
WHERE ID = 7;

SELECT * FROM CrazyTable;

DELETE FROM CrazyTable
WHERE ID BETWEEN 4 AND 7;

INSERT CrazyTable(Daten)
VALUES ('Holla'),
		('die'),
		('Waldfee');




-- geht das?
TRUNCATE TABLE CrazyTable;

SELECT * FROM CrazyTable;

INSERT INTO CrazyTable(Daten)
VALUES
('Blubbblubb');

SELECT * FROM CrazyTable;
GO


-- Hansberg
CREATE OR ALTER TRIGGER tr_ct_insert
ON CrazyTable
INSTEAD OF INSERT, DELETE
AS
BEGIN
    DECLARE @del_count INT = (SELECT COUNT(*) FROM deleted);
    DECLARE @id INT;

 

    IF @del_count = 0
    BEGIN
        DECLARE @count INT = (SELECT COUNT(*) FROM inserted);
        DECLARE @i INT = 1;
        DECLARE @name NVARCHAR(MAX);

 

        IF @count != (SELECT COUNT(DISTINCT(ID)) FROM inserted)
            THROW 55555, 'Die IDs der neuen Einträge müssen eindeutig sein', 1;
        
        UPDATE CrazyTable SET ID = ID + @count;
        
        SELECT * INTO inserted_temp FROM inserted;
        
        WHILE @i <= @count
        BEGIN
            SELECT TOP 1 @id = ID, @name = name FROM inserted_temp ORDER BY ID;
            INSERT INTO CrazyTable VALUES (@i, @name);
            DELETE FROM inserted_temp WHERE ID = @id;
            SET @i += 1;
        END

 

        DROP TABLE inserted_temp;
    END
    ELSE
    BEGIN
        SELECT * INTO deleted_temp FROM deleted;

 

        WHILE @del_count > 0
        BEGIN
            SELECT TOP 1 @id = ID, @name = name FROM deleted_temp ORDER BY ID DESC;

 

            DELETE CrazyTable WHERE ID = @id;
            UPDATE CrazyTable SET ID = ID - 1 WHERE ID > @id;
                       
            DELETE FROM deleted_temp WHERE ID = @id;
            SET @del_count -= 1;
        END

 

        DROP TABLE deleted_temp;
    END
END;
