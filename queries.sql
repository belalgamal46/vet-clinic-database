/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE RIGHT(name,3) = 'mon';
SELECT * from animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-1-1';
SELECT * from animals WHERE neutered = 't' and escape_attempts < 3;
SELECT date_of_birth  from animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts  from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = 't';
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;


/*Create transaction to update species to unspecified*/
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
/*show that the data is rolled back*/
SELECT * FROM animals;


/*Create transaction and update species column*/
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE RIGHT(name,3) = 'mon';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;
/*show that the data is commited*/
SELECT * FROM animals;

/*Create transaction and update date of birth*/
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-1-1';
SAVEPOINT FIRSTPOINT;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT FIRSTPOINT;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/*How many animals are there*/
SELECT COUNT(*) FROM animals;

/*How many animals have never tried to escape*/
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/*What is the average weight of animals*/
SELECT AVG(weight_kg) FROM animals;


/*Who escapes the most, neutered or not neutered animals*/
SELECT neutered, MAX(escape_attempts) from animals GROUP BY neutered;


/*What is the minimum and maximum weight of each type of animal*/
SELECT species,MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;



/*What is the average number of escape attempts per animal type of those born between 1990 and 2000*/

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-01-01' GROUP BY species;

