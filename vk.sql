DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

-- по возможности можно статью которая в подробностя обесняте про INDEX и  FOREIGN KEY не совсем в них разобрался

-- Написать скрипт, добавляющий в созданную БД vk 2-3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей) (CREATE TABLE)
-- 1)

DROP TABLE IF EXISTS stickers;
CREATE TABLE stickers (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	`new` VARCHAR(200),
        popular VARCHAR(200),
	animated VARCHAR(200),
        style VARCHAR(200),
        `free`VARCHAR(200) UNIQUE,
        my_stickers VARCHAR(200) UNIQUE,
    
    INDEX stickers_popular_my_sticker(popular, my_stickers),
    
   FOREIGN KEY(my_stickers) REFERENCES users(id)
    
) COMMENT 'стикеры';

-- 2)
DROP TABLE IF EXISTS music ;
CREATE TABLE music (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name_of_the_track VARCHAR(50),
	artist_name VARCHAR(50),
    track_length TIME NOT NULL,
    
	INDEX music_name_of_the_track_track_length(name_of_the_track, track_length),
    
     FOREIGN KEY(music) REFERENCES users(id)
     ) COMMENT 'музыка';
     -- Заполнить 2 таблицы БД vk данными (по 10 записей в каждой таблице) (INSERT)
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Thunder','Image Dragons', '00:3:07');
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Believer','Image Dragons', '00:3:24');
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Demons','Image Dragons', '00:2:58');
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Whore','In This Moment', '00:4:05');
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Blood','In This Moment', '00:3:27');
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Big_bad_Wolf','In This Moment', '00:5:10');
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Complicated','Avril Lavigne', '00:4:04');
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Hot','Avril Lavigne', '00:3:22');
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Smile','Avril Lavigne', '00:3:29');
INSERT INTO `music` (`name_of_the_track`,`artist_name`,`track_length`) VALUES ('Innocence','Avril Lavigne', '00:3:25');





DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамиль', -- COMMENT на случай, если имя неочевидное
    email VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100), -- 123456 => vzx;clvgkajrpo9udfxvsldkrn24l5456345t
	phone BIGINT UNSIGNED UNIQUE, 
	
    INDEX users_firstname_lastname_idx(firstname, lastname)
) COMMENT 'юзеры';

-- Заполнить 2 таблицы БД vk данными (по 10 записей в каждой таблице) (INSERT)

INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Almund','Farthing','almundFarthing@gmail.com','1224qwe','45313455');
INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Merton','Bluett', 'aertonBluett@gmail.com','qwe1234','51243212');
INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Torr','Gomer','TorrGomer@gmail.com','41245qsd','9523451');
INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Clover','Blood','CloverBloodGmail.com','45fggs','5213653');
INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Orva','Boone','OrvaBoone@gmail.com','gsdfg543','845342');
INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Mercia','Broadway','MerciaBroadway@gmail.com','fsaddf2331','6451235');
INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Kimball','Bready','KimballBready@gmail.com','412341das','412441233');
INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Tracy','Colden','TracyColden@gmail.com','qwee123','45124556');
INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Lois','Farran','LoisFarran@gmail.com','`123qwera','759312304');
INSERT INTO `users` (`firstname `,`lastname` , `email`,`password_hash`,`phone`) VALUES ('Fancy','Croke','FancyCroke@gmail.com','123qwer34','895455678');

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown C(100)
	
    -- , FOREIGN KEY (photo_id) REFERENCES media(id) -- пока рано, т.к. таблицы media еще нет
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE CASCADE -- (значение по умолчанию)
    ON DELETE RESTRICT; -- (значение по умолчанию)

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- можно будет даже не упоминать это поле при вставке

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL, -- изменили на составной ключ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'), # DEFAULT 'requested',
    -- `status` TINYINT(1) UNSIGNED, -- в этом случае в коде хранили бы цифирный enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP, -- можно будет даже не упоминать это поле при обновлении
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)-- ,
    -- CHECK (initiator_user_id <> target_user_id)
);
-- чтобы пользователь сам себе не отправил запрос в друзья
-- ALTER TABLE friend_requests 
-- ADD CHECK(initiator_user_id <> target_user_id);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	
	INDEX communities_name_idx(name), -- индексу можно давать свое имя (communities_name_idx)
	FOREIGN KEY (admin_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- чтобы не было 2 записей о пользователе и сообществе
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
    name VARCHAR(255), -- записей мало, поэтому в индексе нет необходимости
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body TEXT,
    filename VARCHAR(255),
    -- file BLOB,    	
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()

    -- PRIMARY KEY (user_id, media_id) – можно было и так вместо id в качестве PK
  	-- слишком увлекаться индексами тоже опасно, рациональнее их добавлять по мере необходимости (напр., провисают по времени какие-то запросы)  

/* намеренно забыли, чтобы позднее увидеть их отсутствие в ER-диаграмме
    , FOREIGN KEY (user_id) REFERENCES users(id)
    , FOREIGN KEY (media_id) REFERENCES media(id)
*/
);

ALTER TABLE vk.likes 
ADD CONSTRAINT likes_fk 
FOREIGN KEY (media_id) REFERENCES vk.media(id);

ALTER TABLE vk.likes 
ADD CONSTRAINT likes_fk_1 
FOREIGN KEY (user_id) REFERENCES vk.users(id);

ALTER TABLE vk.profiles 
ADD CONSTRAINT profiles_fk_1 
FOREIGN KEY (photo_id) REFERENCES media(id);

/* 4.* Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = true).
 При необходимости предварительно добавить такое поле в таблицу profiles со значением по умолчанию = false (или 0) (ALTER TABLE + UPDATE) 
 */
 ALTER TABLE profiles ADD is_active BIT DEFAULT false NULL;
 
 UPDATE profiles
SET is_active = 1
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5)) < 18
;
ALTER TABLE profiles ADD age bigint(5);
UPDATE profiles
SET age = YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5))
;

 
 
 --  Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) (DELETE)
 UPDATE messages
	SET created_at='2043-04-13 00:12:05'
	WHERE id = 12;

DELETE FROM messages
WHERE created_at > now()
