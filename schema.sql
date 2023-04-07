/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT primary key NOT NUll,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);
