

	/*===================================================
	  ALTER TABLE (ADD, RENAME TO)
	  SQLITE MODIFY VE DELETE KOMUTLARINI DOĞRUDAN DESTEKLENMEZ
====================================================*/

--Rename a table
--Add a new column to a table;


/*ALTER TABLE existing_table
RENAME TO new_table  */

ALTER TABLE workers 
RENAME TO people;

/*ALTER TABLE table
ADD COLUMN column_definition; 

	/*vacation_plan2 tablosuna name adında ve DEFAULT değeri noname olan 
	yeni bir sutun ekleyelim */
	
	 ALTER TABLE vacation_plan2 
	 ADD COLUMN lastname  TEXT DEFAULT 'NONAME' ;
	 
	 	 ALTER TABLE vacation_plan2 
	     DROP COLUMN lastname ;
	 
         ALTER TABLE vacation_plan2 
	     DROP COLUMN name ;


	/*===================================================
					Drop table 
====================================================*/

--We use DROP TABLE statement to remove a table in a database

--DROP TABLE table_name;



/*------------------------------------------------------------------------------------------
	/*  UPDATE,DELETE
		-- SYNTAX
		----------
		-- UPDATE tablo_adı
		-- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...  
		-- WHERE koşul;
		
		--DELETE tablo_adı
		--WHERE koşul;
   /*-----------------------------------------------------------------------------------------*/
   
   /*people tablosundaki id=1 olan kaydini 'Ahmet Yılmaz olarak
   güncelleyiniz.*/
   
   SELECT * FROM people;
   
   UPDATE people
   SET  name= 'Ahmet Yilmaz' 
   WHERE id= 1 ; 
   
   SELECT * FROM people;
   
   -- people tablosunda salary sütunu 120000 'den fazla olanlarin salarylarini %10 zam yapacak sorguyu yaziniz
   
   UPDATE people
   SET salary = salary*1.1
   WHERE salary> 120000 ;
   
 SELECT * FROM people;  
 
  --salary sutununa 3000 ek zam yapalim
   UPDATE people
   SET salary = salary+3000 ;
   
   SELECT * FROM people;

 DELETE FROM vacation_plan2
 WHERE employee_id = 3 ;  

select * from vacation_plan2 ;


   
   