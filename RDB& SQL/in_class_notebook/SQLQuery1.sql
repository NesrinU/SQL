use deneme5

select * from kisi

insert into kisi ( [isim], [soyisim], [dogumtarihi]) values('ali', 'cevik', '01-01-1978');

insert into kisi ( [isim], [soyisim], [dogumtarihi]) values('semih', 'cinar', '01-01-1978');

select * from kisi;

delete from kisi
 where ID= 2;

 insert into kisi ( [isim], [soyisim], [dogumtarihi]) values('semih', 'cinar', '01-01-1978');

 truncate table kisi;    -- bu da siliyor ama idyi sifirliyor delete sifirlamiyor



  insert into kisi ( [isim], [soyisim], [dogumtarihi]) values('semih', 'cinar', '01-01-1978');

  select * from kisi;

  select * from diabetes

  update diabetes
  SET Age = 55 
  where Age= 50
