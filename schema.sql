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
