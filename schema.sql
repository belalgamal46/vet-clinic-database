/* Database schema to keep the structure of entire database. */
CREATE TABLE
  animals (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth date,
    escape_attempts INT,
    neutered boolean,
    weight_kg decimal,
    species_id INT REFERENCES species (id),
    owner_id INT REFERENCES owners (id),
    PRIMARY KEY (id)
  );

CREATE TABLE
  owners (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250),
    age INT,
    PRIMARY KEY (id)
  );

CREATE TABLE
  species (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    PRIMARY KEY (id)
  );

CREATE TABLE
  vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE
  );

CREATE TABLE
  specializations (
    species_id INT,
    vets_id INT,
    CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id),
    CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets (id),
    PRIMARY KEY (species_id, vets_id)
  );

CREATE TABLE
  visits (
    id SERIAL PRIMARY KEY,
    animals_id INT,
    CONSTRAINT fk_animals_id FOREIGN KEY (animals_id) REFERENCES animals (id),
    vets_id INT,
    CONSTRAINT fk_animals FOREIGN KEY (vets_id) REFERENCES vets (id),
    visit_date DATE NOT NULL
  );