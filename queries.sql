/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE RIGHT(name,3) = 'mon';
SELECT * from animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-1-1';
SELECT * from animals WHERE neutered = 't' and escape_attempts < 3;
SELECT date_of_birth  from animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts  from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = 't';
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;


-- Create transaction to update species to unspecified
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
-- show that the data is rolled back
SELECT * FROM animals;


-- Create transaction and update species column
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE RIGHT(name,3) = 'mon';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;
-- show that the data is commited
SELECT * FROM animals;

-- Create transaction and update date of birth
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-1-1';
SAVEPOINT FIRSTPOINT;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT FIRSTPOINT;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals
SELECT AVG(weight_kg) FROM animals;


-- Who escapes the most, neutered or not neutered animals
SELECT neutered, MAX(escape_attempts) from animals GROUP BY neutered;


-- What is the minimum and maximum weight of each type of animal
SELECT species,MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;



-- What is the average number of escape attempts per animal type of those born between 1990 and 2000

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-01-01' GROUP BY species;

-- Modify your inserted animals so it includes the species_id value
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon%';

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;

-- Modify your inserted animals to include owner information
UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') 
WHERE name = 'Agumon';

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') 
WHERE name IN ('Gabumon','Pikachu');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') 
WHERE name IN ('Devimon','Plantmon');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') 
WHERE name IN ('Charmander','Squirtle','Blossom');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') 
WHERE name IN ('Angemon','Boarmon');

-- What animals belong to Melody Pond
SELECT owners.full_name as owner,animals.name as animal 
FROM animals 
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT animals.name as animal, species.name as species 
FROM animals 
JOIN species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal
SELECT owners.full_name as owner, animals.name as animal 
FROM animals 
LEFT JOIN owners ON animals.owner_id = owners.id ;

-- How many animals are there per species
SELECT species.name as species, COUNT(*) as count 
FROM animals 
JOIN species ON animals.species_id = species.id 
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT owners.full_name as owner, animals.name as animal_name, species.name as species
FROM owners 
JOIN animals ON owners.id = animals.owner_id 
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Digimon' AND owners.id = 2; 


-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT animals.name as animal_name, owners.full_name as owner
FROM owners 
JOIN animals ON owners.id = animals.owner_id 
WHERE owners.id = 5 AND animals.escape_attempts = 0; 

-- Who owns the most animals
SELECT owners.full_name, COUNT(animals.name)
FROM owners
LEFT JOIN animals ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(animals.name) DESC
LIMIT 1;