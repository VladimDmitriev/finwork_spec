# Создание бд
CREATE DATABASE friendsOfMan;
USE friendsOfMan;

# Создание таблиц
CREATE TABLE classOfAnimals (
  id INT PRIMARY KEY AUTO_INCREMENT,
  species VARCHAR(20)
);

INSERT INTO classOfAnimals (species) VALUES ('Домашние'), ('Вьючные');

CREATE TABLE pack_animals (
  id INT,
  genusName VARCHAR(20),
  FOREIGN KEY (id) REFERENCES classOfAnimals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pack_animals (id, genusName) 
  VALUES (6, 'Лошади'), (6, 'Верблюды'), (6, 'Ослы');

ALTER TABLE pack_animals ADD genus_id INT PRIMARY KEY AUTO_INCREMENT;

CREATE TABLE pets (
  id INT PRIMARY KEY AUTO_INCREMENT,
  genusName VARCHAR(20),
  class_id INT,
  FOREIGN KEY (class_id) REFERENCES classOfAnimals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pets (genusName, class_id)
  VALUES ('Кошки', 5),
  ('Собаки', 5),
  ('Хомяки', 5);

# Создание и заполнение низкоуровневых таблиц
CREATE TABLE cats 
(       
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(20), 
    birthday DATE,
    commands VARCHAR(50),
    genus_id int,
    Foreign KEY (genus_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO cats (name, birthday, commands, genus_id)
  VALUES
  ('Рекс', '2019-05-30', 'домой, рядом, где мышь', 1),
  ('Мурка', '2023-02-15', 'нельзя, еда', 1),
  ('Мойша', '2020-08-25', 'кто украл, где спрятал', 1);

CREATE TABLE dogs 
(       
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(20), 
    birthday DATE,
    commands VARCHAR(50),
    genus_id int,
    Foreign KEY (genus_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO dogs (name, birthday, commands, genus_id)
  VALUES
  ('Майор', '2016-03-15', 'сидеть, рядом, искать, фу, чужой', 2),
  ('Джек', '2023-04-23', 'место, гулять, домой', 2),
  ('Дора', '2020-08-25', 'сидеть, лежать, аппорт, след, фас, фу, голос', 2);

CREATE TABLE hamsters 
(       
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(20), 
    birthday DATE,
    commands VARCHAR(50),
    genus_id int,
    Foreign KEY (genus_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO hamsters (name, birthday, genus_id)
  VALUES
  ('Панда', '2024-03-15', 3),
  ('Ленивец', '2023-04-23', 3),
  ('Медичи', '2023-08-25', 3);

CREATE TABLE horses 
(       
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(20), 
    birthday DATE,
    commands VARCHAR(50),
    genus_id int,
    Foreign KEY (genus_id) REFERENCES pack_animals (genus_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO horses (name, birthday, commands, genus_id)
  VALUES 
  ('Гром', '2020-01-12', 'бегом, шагом', 1),
  ('Закат', '2017-03-12', "бегом, шагом, хоп", 1),  
  ('Байкал', '2016-07-12', "бегом, шагом, хоп, брр", 1), 
  ('Молния', '2020-11-10', "бегом, шагом, хоп", 1);

CREATE TABLE donkeys 
(       
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(20), 
    birthday DATE,
    commands VARCHAR(50),
    genus_id int,
    Foreign KEY (genus_id) REFERENCES pack_animals (genus_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO donkeys (name, birthday, commands, genus_id)
  VALUES
  ('Первый', '2019-04-10', 'но, стой, лево, право', 3),
  ('Второй', '2020-03-12', 'но, стой, лево, право', 3),  
  ('Третий', '2021-07-12', 'но, стой, лево, право, назад', 3), 
  ('Четвертый', '2023-12-10', 'но, стой, назад', 3);

CREATE TABLE camels 
(       
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(20), 
    birthday DATE,
    commands VARCHAR(50),
    genus_id int,
    Foreign KEY (genus_id) REFERENCES pack_animals (genus_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO camels (name, birthday, commands, genus_id)
  VALUES
  ('Горбатый', '2022-04-10', 'вернись', 2),
  ('Самец', '2019-03-12', 'остановись', 2),  
  ('Сифон', '2015-07-12', 'повернись', 2), 
  ('Борода', '2022-12-10', 'улыбнись', 2);

# Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
# питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.

SET SQL_SAFE_UPDATES = 0;
DELETE FROM camels;

SELECT Name, Birthday, Commands FROM horses
UNION SELECT  Name, Birthday, Commands FROM donkeys;

# Создать новую таблицу “молодые животные” в которую попадут все
# животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
# до месяца подсчитать возраст животных в новой таблице

CREATE TEMPORARY TABLE animals AS 
SELECT *, 'Лошади' as genus FROM horses
UNION SELECT *, 'Ослы' AS genus FROM donkeys
UNION SELECT *, 'Собаки' AS genus FROM dogs
UNION SELECT *, 'Кошки' AS genus FROM cats
UNION SELECT *, 'Хомяки' AS genus FROM hamsters;

CREATE TABLE yang_animal AS
SELECT name, birthday, commands, genus, TIMESTAMPDIFF(MONTH, birthday, CURDATE()) AS age_in_month
FROM animals WHERE birthday BETWEEN ADDDATE(curdate(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);
 
SELECT * FROM yang_animal;

# Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую
# принадлежность к старым таблицам. В файл скрипта добавлены команды объединения таблиц.
# После выполнения скрипта, получаем итоговую таблицу.

SELECT h.name, h.birthday, h.commands, pa.genusName, ya.age_in_month 
FROM horses h
LEFT JOIN yang_animal ya ON ya.name = h.name
LEFT JOIN pack_animals pa ON pa.genus_id = h.genus_id
UNION 
SELECT d2.name, d2.birthday, d2.commands, pa.genusName, ya.age_in_month 
FROM donkeys d2 
LEFT JOIN yang_animal ya ON ya.name = d2.name
LEFT JOIN pack_animals pa ON pa.genus_id = d2.genus_id
UNION
SELECT c.name, c.birthday, c.commands, p.genusName, ya.age_in_month 
FROM cats c 
LEFT JOIN yang_animal ya ON ya.name = c.name
LEFT JOIN pets p ON p.id = c.genus_id
UNION
SELECT d.name, d.birthday, d.commands, p2.genusName, ya.age_in_month 
FROM dogs d 
LEFT JOIN yang_animal ya ON ya.name = d.name
LEFT JOIN pets p2 ON p2.id = d.genus_id
UNION
SELECT hm.name, hm.birthday, hm.commands, p3.genusName, ya.age_in_month 
FROM hamsters hm
LEFT JOIN yang_animal ya ON ya.Name = hm.Name
LEFT JOIN pets p3 ON p3.id = hm.genus_id;

