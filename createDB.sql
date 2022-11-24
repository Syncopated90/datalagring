CREATE TABLE skill_levels
(
  id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  skill_level varchar(12)
);
CREATE TABLE lesson_price_plan
(
  id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  type_of_lesson varchar(12) NOT NULL UNIQUE,
  price VARCHAR(50),
  skill_level_id INT NOT NULL,
  CONSTRAINT level_fk
    FOREIGN KEY(skill_level_id)
      REFERENCES skill_levels(id)
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
CREATE TABLE group_lesson
(
  id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  student_id INT,
  instructor_id INT,
  lesson_price_plan_id INT NOT NULL,
  minimum_participants INT NOT NULL,
  maximum_participants INT NOT NULL,
  skill_level_id INT NOT NULL,
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  CONSTRAINT level_fk
    FOREIGN KEY(skill_level_id)
      REFERENCES skill_levels(id)
);
