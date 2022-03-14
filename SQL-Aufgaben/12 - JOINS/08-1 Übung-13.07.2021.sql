--Aufgabe 1 
USE pro_angSQL

SELECT *
FROM ang;

SELECT *
FROM abt;

SELECT *
FROM pro;

--Verwenden Sie jeweils JOINS, um die folgenden Aufgaben zu lˆsen:
--1. Zeigen Sie alle Mitarbeiter mit zugehˆrigem Abteilungsnamen an.
SELECT an.a_nr, an.name, ab.abt_nr, ab.abt_name
FROM ang AS an INNER JOIN abt AS ab
ON an.abt_nr = ab.abt_nr; 

--2. Zeigen Sie alle Abteilungen und den Namen der Abteilungsleiter an.
SELECT ab.abt_nr, ab.abt_name, ab.abt_leiter, an.name
FROM ang AS an INNER JOIN abt AS ab
ON an.a_nr = ab.abt_leiter;

--3. Wie heiﬂt die Abteilung, in der Mang arbeitet?
SELECT ab.abt_name, an.name AS Mitarbeiter
FROM ang AS an INNER JOIN abt AS ab
ON an.abt_nr = ab.abt_nr
WHERE an.name = 'Mang';

--4. Wie heiﬂt die Abteilungen, in der Mang und Wind arbeiten?
SELECT ab.abt_name, an.name AS Mitarbeiter
FROM ang AS an INNER JOIN abt AS ab
ON an.abt_nr = ab.abt_nr
WHERE an.name IN ('Mang', 'Wind');

--5. Welche Berufe haben die Mitarbeiter in der Abteilung Entwicklung? Jeder Beruf soll nur 
--einmal auftauchen.
SELECT DISTINCT(an.beruf), ab.abt_name
FROM ang AS an INNER JOIN abt AS ab
ON an.abt_nr = ab.abt_nr
WHERE ab.abt_name = 'Entwicklung';

--6. Welche Berufe haben die Abteilungsleiter?
SELECT an.beruf, ab.abt_name, an.name
FROM ang AS an INNER JOIN abt AS ab
ON an.a_nr = ab.abt_leiter;

--ODER
SELECT DISTINCT an.beruf
FROM ang AS an INNER JOIN abt AS ab
ON an.a_nr = ab.abt_leiter;

--7. Wie heiﬂt der Vorgesetzte von Seel?
SELECT an.name AS Mitarbeiter, ang.vorg, ang.name AS Vorgesetzter
FROM ang AS an 
INNER JOIN ang AS ang
ON an.vorg = ang.a_nr
WHERE an.name = 'Seel';

--ODER
SELECT an.name, an.vorg, 
(SELECT name
FROM ang 
WHERE a_nr = an.vorg) AS Vorgesetzter
FROM ang AS an INNER JOIN abt AS ab
ON an.abt_nr = ab.abt_nr
WHERE an.name = 'Seel';

--8. Wie heiﬂen die Mitarbeiter von Paul? 
SELECT ang.vorg, ang.name AS Vorgesetzter, an.name AS Mitarbeiter
FROM ang AS an 
INNER JOIN ang AS ang
ON an.vorg = ang.a_nr
WHERE ang.name = 'Paul' AND an.a_nr != an.vorg;

--ODER
SELECT ang.vorg, ang.name AS Vorgesetzter, an.name AS Mitarbeiter
FROM ang AS an 
INNER JOIN ang AS ang
ON an.vorg = ang.a_nr
WHERE ang.name = 'Paul' AND ang.name != an.name;

--ODER ALS DIE MITARBEITER MIT PAUL IN GELICHER ABTEILUNG
SELECT a1.name AS Vorgesetzter, a2.name AS Mitarbeiter
FROM ang AS a1 
INNER JOIN ang AS a2
ON a1.abt_nr = a2.abt_nr
WHERE a1.name = 'Paul' AND a1.name != a2.name;

--Aufgabe 2 
SELECT *
FROM ang;

SELECT *
FROM abt;

SELECT *
FROM pro;

SELECT *
FROM pro_ang;

--Verwenden Sie jeweils JOINS, um die folgenden Aufgaben zu lˆsen:
--1. Wie heiﬂen die Projekte, an denen Mill arbeitet?
SELECT p.p_name AS Projekt, a.name AS Mitarbeiter 
FROM pro_ang AS pa 
INNER JOIN ang AS a
ON pa.a_nr = a.a_nr
INNER JOIN pro AS p
ON pa.p_nr = p.p_nr
WHERE a.name = 'Mill';

--2. Wie heiﬂen die Projekte, an denen Feld und Kaemp arbeiten?
SELECT p.p_name AS Projekt, an.name AS Mitarbeiter 
FROM pro_ang AS pa 
INNER JOIN ang AS an
ON pa.a_nr = an.a_nr
INNER JOIN pro AS p
ON p.p_nr = pa.p_nr
WHERE an.name = 'Feld' OR an.name = 'Kaemp';

--3. Zeigen Sie alle Projekte an, in denen ein Mitarbeiter mehr als 50% seiner Arbeitszeit 
--verbringt.
SELECT p.p_name AS Projekt, an.name AS Mitarbeiter, pa.proz_arb 
FROM pro_ang AS pa 
INNER JOIN ang AS an
ON pa.a_nr = an.a_nr
INNER JOIN pro AS p
ON p.p_nr = pa.p_nr
WHERE pa.proz_arb > 50;
--ODER
SELECT p.p_name AS Projekt, pa.proz_arb 
FROM pro_ang AS pa 
INNER JOIN pro AS p
ON p.p_nr = pa.p_nr
WHERE pa.proz_arb > 50;
--ODER
SELECT DISTINCT p.p_name AS Projekt
FROM pro_ang AS pa 
INNER JOIN pro AS p
ON p.p_nr = pa.p_nr
WHERE pa.proz_arb > 50;

--4. In welcher Abteilung arbeitet der Projektleiter des Projektes P5?
SELECT ab.abt_name AS Abteilung, p.p_name AS Projekt, an.name AS P_Leiter
FROM pro AS p 
INNER JOIN ang AS an
ON p.p_leiter = an.a_nr
INNER JOIN abt AS ab
ON ab.abt_nr = an.abt_nr
WHERE p.p_name = 'P5';


--5. Wie heiﬂen die Abteilungen, in den Mitarbeiter des Projektes P3 arbeiten? 
SELECT ab.abt_name AS Abteilung, p.p_name AS Projekt, an.name AS Mitarbeiter
FROM pro_ang AS pa 
INNER JOIN ang AS an
ON pa.a_nr = an.a_nr
INNER JOIN pro AS p
ON p.p_nr = pa.p_nr
INNER JOIN abt AS ab
ON ab.abt_nr = an.abt_nr
WHERE p.p_name= 'P3';