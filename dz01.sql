-- Напишите SELECT-запрос, который выводит название товара, производителя и цену для товаров, количество которых превышает 2
SELECT  product_name, manufacturer 
from  dz01
where product_count  > 2 ;

-- Выведите SELECT-запросом весь ассортимент товаров марки “Samsung”
select * from dz01
where manufacturer = "Samsung";

-- * Товары, в которых есть упоминание "Iphone"
select * from dz01 
where product_name
like '%Iphone%';

--  Товары, в которых есть упоминание "Samsung"
select * from dz01 
where product_name
like '%Samsung%';

-- Товары, в названии которых есть ЦИФРЫ
select * from dz01 
where product_name
regexp	"[0-9]";

-- Товары, в названии которых есть ЦИФРА "8"
select * from dz01 
where product_name
regexp	"[8]";
