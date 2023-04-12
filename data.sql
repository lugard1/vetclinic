/* Populate database with sample data. */

INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg) 
                    VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23),
                           (2, 'Gabumon', '2018-11-15', 2, true, 8),
                           (3, 'Pikachu', '2021-01-07', 1, false, 15.04),
                           (4, 'Devimon', '2017-05-12', 5, true, 11),
                           (5, 'Charmander', '2020-02-08', 0, false, -11),
                           (6, 'Plantmon', '2021-11-15', 2, true, -5.7),
                           (7, 'Squirtle', '1993-04-02',3, false, -12.13),
                           (8, 'Angemon', '2005-06-12', 1, true, -45),
                           (9, 'Boarmon', '2005-06-07', 7, true, 20.4),
                           (10, 'Blossom', '1998-10-13',3, true, 17),
                           (11, 'Ditto', '2022-05-14', 4, true, 22);

---------------------------------------------------------------------------------

INSERT INTO owners (full_name, age)
VALUES   ('Sam Smith', 34),
         ('Jennifer Orwell', 19),
         ('Bob', 45),
         ('Melody Pond', 77),
         ('Dean Winchester', 14),
         ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES   ('Pokemon'),
         ('Digimon');

-- Modify inserted animals so it includes the species_id value --
UPDATE animals SET species_id = 2 WHERE name like '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

-- Modify inserted animals to include owner information (owner_id) --

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';





-- Add the species_id column to the animals table
-- ALTER TABLE animals ADD COLUMN species_id INTEGER;

-- Update the species_id values based on the animal names
-- UPDATE animals SET species_id =
--   CASE
--     WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
--     ELSE (SELECT id FROM species WHERE name = 'Pokemon')
--   END;

-- Add the owner_id column to the animals table
-- ALTER TABLE animals ADD COLUMN owner_id INTEGER;

-- Update the owner_id values based on the provided owner-animal relationships
-- UPDATE animals SET owner_id =
--   (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
  
-- UPDATE animals SET owner_id =
--   (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
  
-- UPDATE animals SET owner_id =
--   (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
  
-- UPDATE animals SET owner_id =
--   (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
  
-- UPDATE animals SET owner_id =
--   (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
