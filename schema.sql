/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT NOT NULL IDENTITY(1,1),
  name VARCHAR(250),
  date_of_birth date,
  escape_attempts INT,
  neutered boolean,
  weight_kg decimal,
  PRIMARY KEY(id)
  );