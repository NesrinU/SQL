USE pro_angSQL
GO

--Aufgabe 1.1
SELECT ang.name,
		ang.abt_nr,
		abt.abt_nr,
		abt.abt_name
FROM ang
INNER JOIN abt
ON ang.abt_nr = abt.abt_nr
		
--Aufgabe 1.2
SELECT abt.abt_name,
		abt.abt_leiter,
		ang.a_nr,
		ang.name
FROM abt
INNER JOIN ang
ON abt.abt_leiter = ang.a_nr

--Aufgabe 1.3
SELECT abt.abt_name,
		abt.abt_nr,
		ang.abt_nr,
		ang.name
FROM ang
INNER JOIN abt
ON ang.abt_nr = abt.abt_nr
WHERE ang.name='Mang'
	
--Aufgabe 1.4
SELECT abt.abt_name,
		abt.abt_nr,
		ang.abt_nr,
		ang.name
FROM ang
INNER JOIN abt
ON ang.abt_nr = abt.abt_nr
WHERE ang.name='Mang'
OR ang.name='Wind'



--Aufgabe 1.6
SELECT abt.abt_name,
		abt.abt_leiter,
		ang.a_nr,
		ang.name,
		ang.beruf
FROM abt
INNER JOIN ang
ON abt.abt_leiter = ang.a_nr

--Aufgabe 1.7
SELECT a.name,
		a.vorg,
		v.a_nr,
		v.name
FROM ang a
INNER JOIN ang v
ON a.vorg = v.A_nr

--Aufgabe 1.8
SELECT a.name,
		a.a_nr,
		v.vorg,
		v.name
FROM ang a
INNER JOIN ang v
ON a.a_nr = v.vorg
WHERE a.name='Paul' AND a.name != v.name;


SELECT a1.name, a2.name
FROM ang AS a1
INNER JOIN ang AS a2
ON a1.abt_nr = a2.abt_nr
WHERE a1.name = 'Paul' AND a1.name != a2.name;

--Aufgabe 2.1
SELECT p.p_beschr,
		p.p_name,
		a.name
FROM pro AS p
INNER JOIN pro_ang AS pa
ON p.p_nr = pa.p_nr
INNER JOIN ang a
ON a.a_nr = pa.a_nr
WHERE a.name='Mill'
	
--Aufgabe 2.2
SELECT p.p_beschr,
		p.p_name,
		a.name
FROM pro AS p
INNER JOIN pro_ang AS pa
ON p.p_nr = pa.p_nr
INNER JOIN ang a
ON a.a_nr = pa.a_nr
WHERE a.name = 'Feld'
OR a.name = 'Kamp'

--Aufgabe 2.2 Alternative
SELECT p.p_beschr,
		p.p_name,
		a.name
FROM pro AS p
INNER JOIN pro_ang AS pa
ON p.p_nr = pa.p_nr
INNER JOIN ang a
ON a.a_nr = pa.a_nr
WHERE a.name IN ('Feld', 'Kamp')

-- logisches UND, alle gleichzeitig am selben Projekt
SELECT pro.p_name
FROM ang 
INNER JOIN pro_ang

ON ang.a_nr = pro_ang.a_nr

INNER JOIN pro

ON pro_ang.p_nr = pro.p_nr

WHERE ang.name IN ('Feld', 'Seel')
GROUP BY pro.p_name
HAVING COUNT(pro.p_name) = 2


--Aufgabe 2.3
SELECT p.p_name,
		p.p_beschr,
		pa.proz_arb,
		a.name
FROM pro AS p
INNER JOIN pro_ang AS pa
ON p.p_nr = pa.p_nr
INNER JOIN ang a
ON pa.a_nr = a.a_nr
WHERE pa.proz_arb > 50

--Aufgabe 2.4
SELECT p.p_name,
		p.p_beschr,
		p.p_leiter,
		abt.abt_name,
		ang.name
FROM pro p
INNER JOIN ang
ON p.p_leiter = ang.a_nr
INNER JOIN abt
ON ang.abt_nr = abt.abt_nr
WHERE p.p_name='P5'


--Aufgabe 2.5
SELECT p.p_name,
		p.p_beschr,
		ang.name,
		abt.abt_name
FROM pro p
INNER JOIN pro_ang pa
ON p.p_nr = pa.p_nr
INNER JOIN ang
ON pa.a_nr = ang.a_nr
INNER JOIN abt
ON abt.abt_nr = ang.abt_nr
WHERE p.p_name = 'P3'
