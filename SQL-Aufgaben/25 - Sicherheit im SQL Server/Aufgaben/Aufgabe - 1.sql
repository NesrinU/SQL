--Aufgabe 1
--Verwenden Sie für die folgenden Aufgaben sowohl das SSMS als auch TSQL.

--1.	Erstellen Sie auf SQLSRV1 die SQL-Logins SecAdmin1, SecAdmin2 und SecAdmin3.
CREATE LOGIN SecAdmin1
WITH PASSWORD = '057143',
CHECK_POLICY = OFF;
GO
CREATE LOGIN SecAdmin2
WITH PASSWORD = '057143',
CHECK_POLICY = OFF;
GO
CREATE LOGIN SecAdmin3
WITH PASSWORD = '057143',
CHECK_POLICY = OFF;

--2.	Erstellen Sie die beiden Serverrollen LoginAdmins und DatabaseAdmins.
CREATE SERVER ROLE LoginAdmins;
GO
CREATE SERVER ROLE DatabaseAdmins;

--3.	Sehen Sie sich an, welche Berechtigungen Sie auf Serverebene erteilen können. Ein Blick auf die anderen sicherungsfähigen Elemente kann auch nicht schaden, auch wenn Sie noch nicht alle Objekte kennen.
--4.	Sorgen Sie dafür, dass die Mitglieder der Rolle LoginAdmins Anmeldungen verwalten können. 
--5.	Erteilen Sie den Mitgliedern der Rolle DatabaseAdmins das Recht Datenbanken zu verwalten.
--6.	Fügen Sie den Benutzer SecAdmin1 der Rolle LoginAdmins hinzu und den Benutzer SecAdmin2 der Rolle DatabaseAdmins.
--7.	Erteilen Sie dem Benutzer SecAdmin3 das Recht die Rolle DatabaseAdmins zu verwalten.
--8.	Testen Sie, ob die erteilten Berechtigungen funktionieren.
--9.	Lassen Sie alle Serverprinzipale anzeigen.
--10.	Lassen Sie alle SQL-Anmeldungen anzeigen.
--11.	Lassen Sie die Berechtigungen der Rolle DatabaseAdmins anzeigen.
--12.	Prüfen Sie, welche Berechtigungen die Rolle SecurityAdmins hat.
--13.	Fügen Sie den SQL-Benutzer SecAdmin3 auch der Rolle LoginAdmins hinzu, testen Sie die neue Berechtigung.
--14.	Sorgen Sie dafür, dass der Benutzer SecAdmin3, den Benutzer SecAdmin2 nicht verwalten kann.
--15.	Testen Sie erneut die Berechtigungen.
--16.	Verweigern Sie dem Benutzer SecAdmin3 das Recht, sich am SQL-Server anzumelden.
