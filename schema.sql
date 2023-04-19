/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY NOT NUll,
    name VARCHAR(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

Alter TABLE animals
  ADD COLUMN species varchar(100);
--------------------------------------------------------
-- create table owners--
CREATE TABLE owners (
    id integer PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    age integer NOT NULL
);

-- create table species--

CREATE TABLE species (
    id integer PRIMARY KEY NOT NULL,
    name VARCHAR(50)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id);

-------------------------------------------------------------------------------------

CREATE TABLE vets(
id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	date_of_graduation DATE NOT NULL,
	PRIMARY KEY(id)
);

--  Create a "join table" called specializations

CREATE TABLE specializations(
species_id INT,
	vets_id INT
);

SELECT * FROM specializations

ALTER TABLE specializations
ADD FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE specializations
ADD FOREIGN KEY (vets_id)
REFERENCES vets(id)
ON DELETE CASCADE;

-- Create a "join table" called visits

CREATE TABLE visits(
animals_id INT,
	vets_id INT
);

ALTER TABLE visits
ADD FOREIGN KEY (animals_id)
REFERENCES animals(id)
ON DELETE CASCADE;

ALTER TABLE visits
ADD FOREIGN KEY (vets_id)
REFERENCES vets(id)
ON DELETE CASCADE;

ALTER TABLE visits
ADD date_of_visits DATE;

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- CREATE INDEXES TO IMPROVE THE PERFORMANCE
CREATE INDEX index_animals_id ON visits(animals_id);
CREATE INDEX index_vets_id ON visits(vets_id);
CREATE INDEX index_owners ON owners(email);
