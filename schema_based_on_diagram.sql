CREATE TABLE
  "patients" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(250),
    "date_of_birth" date
  );

CREATE TABLE
  "treatments" (
    "id" SERIAL PRIMARY KEY,
    "type" VARCHAR(250),
    "name" VARCHAR(250)
  );

CREATE TABLE
  "invoices" (
    "id" SERIAL PRIMARY KEY,
    "total_amount" "decimal(2, 20)",
    "generated_at" timestamp,
    "payed_at" timestamp,
    "medical_history_id" INT
  );

CREATE TABLE
  "medical_histories" (
    "id" SERIAL PRIMARY KEY,
    "admitted_at" timestamp,
    "patience_id" INT,
    "status" VARCHAR(250)
  );

CREATE TABLE
  "invoices_items" (
    "id" SERIAL PRIMARY KEY,
    "unit_price" "decimal(2, 20)",
    "quantity" INT,
    "total_price" "decimal(2, 20)",
    "invoice_id" INT,
    "treatments_id" INT
  );

CREATE TABLE
  "treatments_and_medical_histories" (
    "medical_histories_id" INT,
    "treatments_id" INT,
    PRIMARY KEY ("medical_histories_id", "treatments_id")
  );

ALTER TABLE "invoices" ADD FOREIGN KEY ("medical_history_id") REFERENCES "medical_histories" ("id");

ALTER TABLE "medical_histories" ADD FOREIGN KEY ("patience_id") REFERENCES "patients" ("id");

ALTER TABLE "invoices_items" ADD FOREIGN KEY ("invoice_id") REFERENCES "invoices" ("id");

ALTER TABLE "invoices_items" ADD FOREIGN KEY ("treatments_id") REFERENCES "treatments" ("id");

ALTER TABLE "treatments_and_medical_histories" ADD FOREIGN KEY ("medical_histories_id") REFERENCES "medical_histories" ("id");

ALTER TABLE "treatments_and_medical_histories" ADD FOREIGN KEY ("treatments_id") REFERENCES "treatments" ("id");