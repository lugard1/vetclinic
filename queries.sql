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

------------------------------------------------------------------------------

-- 1. Who was the last animal seen by William Tatcher?

SELECT v.name, a.name, vi.date_of_visits
FROM vets v 
JOIN visits vi ON vi.vets_id = v.id
JOIN animals a ON a.id = vi.animals_id
WHERE vets_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY vi.date_of_visits DESC LIMIT 1;

-- 2. How many different animals did Stephanie Mendez see?
SELECT v.name, COUNT(vi.animals_id)
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
WHERE v.id =  (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
GROUP BY v.name;

-- 3. List all vets and their specialties, including vets with no specialties.
SELECT v.name, s.species_id
FROM vets v
LEFT JOIN specializations s ON v.id = s.vets_id
GROUP BY v.name,s.species_id;

-- 4. List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name, v.name, vi.date_of_visits
FROM visits vi 
JOIN vets v ON vi.vets_id = v.id
JOIN animals a ON vi.animals_id = a.id
WHERE v.id= (SELECT id FROM vets WHERE name = 'Stephanie Mendez') AND vi.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30'
GROUP BY a.name, v.name, vi.date_of_visits;

-- 5. What animal has the most visits to vets?

SELECT a.name, COUNT(vi.animals_id)
FROM visits vi
JOIN animals a ON vi.animals_id = a.id
GROUP BY a.name
ORDER BY COUNT(vi.animals_id) DESC LIMIT 1;

-- 6. Who was Maisy Smith's first visit?

SELECT a.name, vi.date_of_visits, v.name
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
JOIN animals a ON a.id = vi.animals_id
WHERE vets_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY vi.date_of_visits LIMIT 1;

-- 7. Details for most recent visit: animal information, vet information, and date of visit.

SELECT a.name, a.date_of_birth, a.escape_attempts, a.neutered, a.weight_kg,
o.full_name, o.age,
s.name,
v.name, v.age, v.date_of_graduation,
vi.date_of_visits
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
JOIN animals a ON a.id = vi.animals_id
JOIN owners o ON  o.id = a.owner_id
JOIN species s ON s.id = a.species_id
ORDER BY vi.date_of_visits DESC LIMIT 1;

-- 8. How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(vi.vets_id)
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
JOIN animals a ON vi.animals_id = a.id
JOIN specializations s ON vi.vets_id = s.species_id
JOIN species spe ON spe.id = a.species_id
WHERE a.species_id != s.species_id;

-- 9. What specialty should Maisy Smith consider getting? Look for the species she gets the most

SELECT a.name, COUNT(vi.animals_id), spe.name, v.name
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
JOIN animals a ON vi.animals_id = a.id
JOIN species spe ON a.species_id = spe.id
WHERE vi.vets_id =(SELECT id FROM vets WHERE name ='Maisy Smith')
GROUP BY vi.animals_id, a.name, spe.name, v.name
ORDER BY COUNT(vi.animals_id) DESC LIMIT 1;

SELECT COUNT(*) FROM visits WHERE animals_id = 4;
SELECT * FROM visits WHERE vets_id = 2;
SELECT * FROM owners WHERE email = 'owner_18327@mail.com';

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animals_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits WHERE vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners WHERE email = 'owner_18327@mail.com';