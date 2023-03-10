/*Queries that provide answers to the questions from all projects.*/
SELECT
  *
from
  animals
WHERE
  RIGHT (name, 3) = 'mon';

SELECT
  *
from
  animals
WHERE
  date_of_birth BETWEEN '2016-1-1' AND '2019-1-1';

SELECT
  *
from
  animals
WHERE
  neutered = 't'
  and escape_attempts < 3;

SELECT
  date_of_birth
from
  animals
WHERE
  name = 'Agumon'
  or name = 'Pikachu';

SELECT
  name,
  escape_attempts
from
  animals
WHERE
  weight_kg > 10.5;

SELECT
  *
from
  animals
WHERE
  neutered = 't';

SELECT
  *
from
  animals
WHERE
  name != 'Gabumon';

SELECT
  *
from
  animals
WHERE
  weight_kg >= 10.4
  and weight_kg <= 17.3;

-- Create transaction to update species to unspecified
BEGIN TRANSACTION;

UPDATE animals
SET
  species = 'unspecified';

SELECT
  *
FROM
  animals;

ROLLBACK;

-- show that the data is rolled back
SELECT
  *
FROM
  animals;

-- Create transaction and update species column
BEGIN TRANSACTION;

UPDATE animals
SET
  species = 'digimon'
WHERE
  RIGHT (name, 3) = 'mon';

UPDATE animals
SET
  species = 'pokemon'
WHERE
  species is NULL;

COMMIT;

-- show that the data is commited
SELECT
  *
FROM
  animals;

-- Create transaction and update date of birth
BEGIN TRANSACTION;

DELETE FROM animals
WHERE
  date_of_birth > '2022-1-1';

SAVEPOINT FIRSTPOINT;

UPDATE animals
SET
  weight_kg = weight_kg * -1;

ROLLBACK TO SAVEPOINT FIRSTPOINT;

UPDATE animals
SET
  weight_kg = weight_kg * -1
WHERE
  weight_kg < 0;

COMMIT;

-- How many animals are there
SELECT
  COUNT(*)
FROM
  animals;

-- How many animals have never tried to escape
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = 0;

-- What is the average weight of animals
SELECT
  AVG(weight_kg)
FROM
  animals;

-- Who escapes the most, neutered or not neutered animals
SELECT
  neutered,
  MAX(escape_attempts)
from
  animals
GROUP BY
  neutered;

-- What is the minimum and maximum weight of each type of animal
SELECT
  species,
  MAX(weight_kg),
  MIN(weight_kg)
FROM
  animals
GROUP BY
  species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000
SELECT
  species,
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth >= '1990-01-01'
  AND date_of_birth <= '2000-01-01'
GROUP BY
  species;

-- Modify your inserted animals so it includes the species_id value
UPDATE animals
SET
  species_id = (
    SELECT
      id
    FROM
      species
    WHERE
      name = 'Digimon'
  )
WHERE
  name LIKE '%mon%';

UPDATE animals
SET
  species_id = (
    SELECT
      id
    FROM
      species
    WHERE
      name = 'Pokemon'
  )
WHERE
  species_id IS NULL;

-- Modify your inserted animals to include owner information
UPDATE animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Sam Smith'
  )
WHERE
  name = 'Agumon';

UPDATE animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Jennifer Orwell'
  )
WHERE
  name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Bob'
  )
WHERE
  name IN ('Devimon', 'Plantmon');

UPDATE animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Melody Pond'
  )
WHERE
  name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Dean Winchester'
  )
WHERE
  name IN ('Angemon', 'Boarmon');

-- What animals belong to Melody Pond
SELECT
  owners.full_name as owner,
  animals.name as animal
FROM
  animals
  JOIN owners ON animals.owner_id = owners.id
WHERE
  owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT
  animals.name as animal,
  species.name as species
FROM
  animals
  JOIN species ON animals.species_id = species.id
WHERE
  species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal
SELECT
  owners.full_name as owner,
  animals.name as animal
FROM
  animals
  LEFT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species
SELECT
  species.name as species,
  COUNT(*) as count
FROM
  animals
  JOIN species ON animals.species_id = species.id
GROUP BY
  species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT
  owners.full_name as owner,
  animals.name as animal_name,
  species.name as species
FROM
  owners
  JOIN animals ON owners.id = animals.owner_id
  JOIN species ON animals.species_id = species.id
WHERE
  species.name = 'Digimon'
  AND owners.id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT
  animals.name as animal_name,
  owners.full_name as owner
FROM
  owners
  JOIN animals ON owners.id = animals.owner_id
WHERE
  owners.id = 5
  AND animals.escape_attempts = 0;

-- Who owns the most animals
SELECT
  owners.full_name,
  COUNT(animals.name)
FROM
  owners
  LEFT JOIN animals ON animals.owner_id = owners.id
GROUP BY
  owners.full_name
ORDER BY
  COUNT(animals.name) DESC
LIMIT
  1;

-- Who was the last animal seen by William Tatcher
SELECT
  animals.name as animal_name
FROM
  visits
  JOIN animals ON animals.id = visits.animals_id
  JOIN vets ON vets.id = visits.vets_id
WHERE
  vets.id = 1
ORDER BY
  visits.visit_date DESC
LIMIT
  1;

-- How many different animals did Stephanie Mendez see?
SELECT
  vets.name,
  COUNT(animals.name)
FROM
  animals
  JOIN visits ON animals.id = visits.animals_id
  JOIN vets ON vets.id = visits.vets_id
WHERE
  vets.id = 3
GROUP BY
  vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT
  vets.name AS vets_name,
  species.name
FROM
  vets
  LEFT JOIN specializations ON vets.id = specializations.vets_id
  LEFT JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
  animals.name AS animal_name,
  vets.name AS vets_name
FROM
  animals
  JOIN visits ON animals.id = visits.animals_id
  JOIN vets ON visits.vets_id = vets.id
WHERE
  vets.id = 3
  AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT
  animals.name,
  COUNT(animals.name)
FROM
  animals
  JOIN visits ON animals.id = visits.animals_id
GROUP BY
  animals.name
ORDER BY
  COUNT(animals.name) DESC
LIMIT
  1;

-- Who was Maisy Smith's first visit?
SELECT
  animals.name,
  visits.visit_date
FROM
  animals
  JOIN visits ON animals.id = visits.animals_id
  JOIN vets ON vets.id = visits.vets_id
WHERE
  vets.id = 2
ORDER BY
  visits.visit_date ASC
LIMIT
  1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  *
FROM
  animals
  JOIN visits ON animals.id = visits.animals_id
  JOIN vets ON vets.id = visits.vets_id
ORDER BY
  visits.visit_date DESC
LIMIT
  1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
  COUNT(visits.id) as count
FROM
  visits
  LEFT JOIN animals ON visits.animals_id = animals.id
  LEFT JOIN vets ON visits.vets_id = vets.id
  LEFT JOIN specializations ON specializations.species_id = animals.species_id
  AND specializations.vets_id = vets.id
WHERE
  specializations.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most
SELECT
  species.name as species
FROM
  animals
  JOIN visits ON animals.id = visits.animals_id
  JOIN vets ON vets.id = visits.vets_id
  JOIN species ON species.id = animals.species_id
WHERE
  vets.id = 2
GROUP BY
  species.name
ORDER BY
  COUNT(species.name) DESC
LIMIT
  1;