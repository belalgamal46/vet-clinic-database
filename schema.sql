/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  date_of_birth date,
  escape_attempts INT,
  neutered boolean,
  weight_kg decimal,
  species_id INT REFERENCES species(id),
  owner_id INT REFERENCES owners(id),
  PRIMARY KEY(id)
  );

  CREATE TABLE owners(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(250),
  age INT,
  PRIMARY KEY (id)
  );

  CREATE TABLE species(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  PRIMARY KEY (id)
  );

