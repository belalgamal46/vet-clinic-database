CREATE TABLE
  patients (
    id SERIAL,
    name VARCHAR(250),
    date_of_birth date,
    PRIMARY KEY (id)
  );

CREATE TABLE
  treatments (
    id INT REFERENCES medical_histories (id),
    type VARCHAR(250),
    name VARCHAR(250),
    PRIMARY KEY (id)
  );

CREATE TABLE
  invoices (
    id SERIAL,
    total_amount decimal(2, 20),
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id INT REFERENCES medical_histories (id),
    PRIMARY KEY (id)
  );

CREATE TABLE
  medical_histories (
    id SERIAL,
    admitted_at timestamp,
    patience_id INT REFERENCES patients (id),
    status VARCHAR(250),
    PRIMARY KEY (id)
  );

CREATE TABLE
  invoices_items (
    id SERIAL,
    unit_price decimal(2, 20),
    quantity INT,
    total_price decimal(2, 20),
    invoice_id INT REFERENCES invoices (id),
    treatments_id INT REFERENCES treatments (id),
    PRIMARY KEY (id)
  );