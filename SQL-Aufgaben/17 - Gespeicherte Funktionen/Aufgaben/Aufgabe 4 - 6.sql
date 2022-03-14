--Aufgabe 4
--Erstellen Sie in der TeachSQL-Datenbank eine Funktion, welche von zwei übergebenen integer-Zahlen den größten gemeinsamen Teiler ausrechnet. Einen entsprechenden Algorithmus finden Sie hier:
--public int berechneGgt(int _zahl1, int _zahl2)
--{
--int zahl1 = _zahl1;
--int zahl2 = _zahl2;
--//Diese Variable wird bei Wertzuweisungen zwischen den Zahlen benutzt
--int temp = 0;
--//Der Rückgabewert zweier gegebener Zahlen.
--int ggt = 0;//Solange der Modulo der zwei zahlen nicht 0 ist,
--//werden Zuweisungen entsprechend demEuklidischen Algorithmus ausgeführt.
--while (zahl1 % zahl2 != 0)
--{
--temp = zahl1 % zahl2;
--zahl1 = zahl2;
--zahl2 = temp;
--}
 
--ggt = zahl2;
 
--return ggt;
 
--}

CREATE FUNCTION fn_EBOB(@zahl1 INT, @zahl2 INT)
RETURNS INT 
AS
	BEGIN
	DECLARE @ebob INT
	WHILE @zahl1>@zahl2
		BEGIN
		IF @zahl1 % @zahl2 = 0
			SELECT @ebob = @zahl2
		ELSE IF @zahl1 % @zahl2 != 0
			SELECT @zahl2 % (@zahl1%@zahl2)
		END

	END;

SELECT dbo.fn_EBOB(75,9);

  i = 1
    ebob = 1
    while (i <= sayı1 and i <= sayı2):
        if not sayı1 % i and not sayı2 % i :
            ebob = i
        i += 1
 
    return ebob

 
print("Ebob: ",ebob_bulma(sayı1,sayı2))


--Aufgabe 5
--Erstellen Sie eine Funktion, welche das kleinste gemeinsame Vielfache von zwei Zahlen berechnet. 
--Dieses berechnet sich nach folgender Definition:
--Ein kleinstes gemeinsames Vielfaches von zwei Zahlen ist das Produkt der beiden Zahlen durch deren größten gemeinsamen Teiler. 
 
def ekok_bulma(sayı1, sayı2):
    return sayı1 * sayı2 / ebob_bulma(sayı1,sayı2)
 
sayı1 = int(input("Sayı1: "))
sayı2 = int(input("Sayı2: "))

print("Ekok: ",ekok_bulma(sayı1,sayı2))
--Aufgabe 6
--Erstellen Sie eine Funktion fn_Between, welche drei Kommazahlen entgegennimmt. Die ersten beiden Zahlen sind die Intervallgrenzen (z.B. 1.2 und 4.723) und die dritte Zahl ist entweder innerhalb dieses Intervalls (z.B. 2.3) oder nicht innerhalb des Intervalls (z.B. 7).  Wenn die dritte Zahl innerhalb des Intervalls ist, soll true, ansonsten false  als bit-Datentyp zurückgegeben werden (Stichwort Bool’scher Wert in SQL).
