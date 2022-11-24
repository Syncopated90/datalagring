CREATE TABLE "student"
(
  "person_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "person_number" varchar(12) UNIQUE,
  "name" varchar(500),
  "street" varchar(100),
  "zip" varchar(5),
  "city" varchar(50)
);

CREATE TABLE "health_care_establishment"
(
  "health_care_establishment_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "HCE_id" varchar(10) UNIQUE,
  "street" varchar(100),
  "zip" varchar(5),
  "city" varchar(50)
);

CREATE TABLE "doctor"
(
  "doctor_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "person_id" int NOT NULL REFERENCES "person",
  "employment_id" varchar(10) UNIQUE NOT NULL
);

CREATE TABLE "visit"
(
  "visit_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "time" timestamp,
  "doctor_id" int NOT NULL REFERENCES "doctor",
  "person_id" int NOT NULL REFERENCES "person",
  "health_care_establishment_id" int NOT NULL REFERENCES "health_care_establishment"
);

CREATE TABLE "visit_purpose"
(
  "visit_id" int NOT NULL REFERENCES "visit" ON DELETE CASCADE,
  "description" varchar(500) NOT NULL,
  PRIMARY KEY("visit_id", "description")
);

CREATE TABLE "email"
(
  "email_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "email" varchar(100) UNIQUE NOT NULL
);

CREATE TABLE "phone"
(
  "person_id" int NOT NULL REFERENCES "person" ON DELETE CASCADE,
  "phone_no" varchar(12) NOT NULL,
  PRIMARY KEY ("person_id", "phone_no")
);

CREATE TABLE "person_email"
(
  "email_id" int NOT NULL REFERENCES "email" ON DELETE CASCADE,
  "person_id" int NOT NULL REFERENCES "person" ON DELETE CASCADE,
  PRIMARY KEY("email_id", "person_id")
);
