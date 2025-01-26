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

