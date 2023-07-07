CREATE DATABASE `dz01` ;

CREATE TABLE `dz01`.`phone_base` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Product_name` VARCHAR(45) NOT NULL,
  `Manufacturer` VARCHAR(45) NOT NULL,
  `Product_count` INT NOT NULL,
  `Price`INT NOT NULL,
  PRIMARY KEY (`id`));
  
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Iphone 12 mini','Apple',42,45000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Iphone 14 Pro ','Apple',1,88000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Iphone 8','Apple',82,32000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Iphone14 Pro Max','Apple',1,140000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Samsung Galaxy Note 10 5G','Samsung',1,540000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Samsung Galaxy S23 Ultra','Samsung',1,120000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Samsung Galaxy S8','Samsung',44,28000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Samsung Galaxy Z Fold','Samsung',1,111000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Xiaomi 13 Ultra','Xiaomi',25,132000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Xiaomi POCO Ms','Xiaomi',65,32000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Xiaomi Redmi 8','Xiaomi',57,8000);
INSERT INTO `dz01` (`product_name`,`manufacturer`,`product_count`,`price`) VALUES ('Xiaomi Redmi Note 12 4G','Xiaomi',54,22000);


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
