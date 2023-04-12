/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name !='Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3; 
SELECT *FROM animals WHERE species = 'unspecified';

-- start transaction--

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
--ROLLBACK transaction--
ROLLBACK;
SELECT * FROM animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon

UPDATE animals SET species = 'digimon' WHERE name like '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Update animals SET species = 'pokemon' WHERE species is NULL;

-- Commit the transaction

COMMIT;

-- Verify the change after the commit

SELECT * FROM animals;

-- start a transaction

BEGIN;
-- delete all records in animal table.
DELETE FROM animals;
-- verify that records are deleted.

SELECT * FROM animals;

-- ROLLBACK transaction

ROLLBACK;

-- verify that records are reset back to default
SELECT * FROM animals;

--begin a transaction

BEGIN;
--Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT save;

-- Update all animals' weight to be their weight multiplied by -1.

UPDATE animals SET weight_kg = (weight_kg * -1);

--rollback to savepoint save

ROLLBACK TO save;

-- Update all animals' weights that are negative to be their weight multiplied by -1.

UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;

--commit the transaction

COMMIT;

--query to count how many animals are there

SELECT COUNT(*) FROM animals;

--query to count how many animals have never tried to escape

SELECT COUNT(*)FROM animals WHERE escape_attempts = 0;

--query to calculate the average of weights for animals

SELECT AVG(weight_kg) FROM animals;

--query that shows Who escapes the most, neutered or not neutered animals

SELECT neutered, AVG(escape_attempts) AS escapes FROM animals GROUP BY neutered;

--query that shows the minimum and maximum weight of each type of animal.

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- query that shows the average number of escape attempts per animal type of those born between 1990 and 2000

SELECT species, AVG(escape_attempts) AS escapes FROM animals WHERE date_of_birth  BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- ---------------------------------------------------------------------------------------------------------

-- Write queries (using JOIN) to answer the following questions --

-- What animals belong to Melody Pond?

SELECT animals.name 
FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name 
FROM animals 
INNER JOIN species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name 
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id 
ORDER BY owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(animals.id) AS count 
FROM species 
LEFT JOIN animals ON species.id = animals.species_id 
GROUP BY species.id;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name 
FROM animals 
INNER JOIN species ON animals.species_id = species.id 
INNER JOIN owners ON animals.owner_id = owners.id 
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name 
FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.id) AS count 
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id 
GROUP BY owners.id 
ORDER BY count DESC 
LIMIT 1;









-- query update--

-- SELECT animals.name
-- FROM animals
-- JOIN owners ON animals.owner_id = owners.id
-- WHERE owners.full_name = 'Melody Pond';

-- SELECT animals.name
-- FROM animals
-- JOIN species ON animals.species_id = species.id
-- WHERE species.name = 'Pokemon';

-- SELECT owners.full_name, animals.name
-- FROM owners
-- LEFT JOIN animals ON owners.id = animals.owner_id;

-- SELECT species.name, COUNT(*) AS count
-- FROM animals
-- JOIN species ON animals.species_id = species.id
-- GROUP BY species.name;

-- SELECT animals.name
-- FROM animals
-- JOIN species ON animals.species_id = species.id
-- JOIN owners ON animals.owner_id = owners.id
-- WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- SELECT animals.name
-- FROM animals
-- JOIN owners ON animals.owner_id = owners.id
-- LEFT JOIN escapes ON animals.id = escapes.animal_id
-- WHERE owners.full_name = 'Dean Winchester' AND escapes.animal_id IS NULL;

-- SELECT owners.full_name, COUNT(*) AS count
-- FROM animals
-- JOIN owners ON animals.owner_id = owners.id
-- GROUP BY owners.full_name
-- ORDER BY count DESC
-- LIMIT 1;
