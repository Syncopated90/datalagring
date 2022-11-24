CREATE TABLE skill_levels
(
  id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  skill_level varchar(12)
);
CREATE TABLE student
(
  id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  person_number varchar(12) NOT NULL UNIQUE,
  name varchar(50) NOT NULL,
  address varchar(50),
  phone_number varchar(20) NOT NULL UNIQUE,
  email varchar(50) NOT NULL UNIQUE,
  contact_person INT NOT NULL,
  skill_level_id INT NOT NULL ,
  CONSTRAINT level_fk
    FOREIGN KEY(skill_level_id)
      REFERENCES skill_levels(id)
);
CREATE TABLE instructor
(
  id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  person_number varchar(12) NOT NULL UNIQUE,
  name varchar(50) NOT NULL,
  address varchar(50),
  phone_number varchar(20) NOT NULL UNIQUE,
  email varchar(50) NOT NULL UNIQUE
);
