/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE RIGHT(name,3) = 'mon';
SELECT * from animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-1-1';
SELECT * from animals WHERE neutered = 't' and escape_attempts < 3;
SELECT date_of_birth  from animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts  from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = 't';
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;