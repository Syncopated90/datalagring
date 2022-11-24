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
      ON DELETE RESTRICT
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
      ON DELETE RESTRICT
);
CREATE TABLE contact_person
(
  student_id INT NOT NULL PRIMARY KEY,
  name varchar(50) NOT NULL,
  phone_number varchar(20) NOT NULL UNIQUE,
  email varchar(50) NOT NULL UNIQUE,
  CONSTRAINT student_fk
    FOREIGN KEY(student_id)
      REFERENCES student(id)
      ON DELETE CASCADE
);
CREATE TABLE student_siblings
(
  student1_id INT NOT NULL,
  student2_id INT NOT NULL,
  CONSTRAINT student1_fk
    FOREIGN KEY(student1_id)
      REFERENCES student(id)
      ON DELETE CASCADE,
  CONSTRAINT student2_fk
    FOREIGN KEY(student2_id)
      REFERENCES student(id)
      ON DELETE CASCADE
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
CREATE TABLE instruments_for_rent
(
  id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  instrument_id VARCHAR(20) UNIQUE NOT NULL,
  type VARCHAR(50) NOT NULL,
  brand VARCHAR(50) NOT NULL,
  currently_in_stock INT
);
CREATE TABLE instrument_price_list
(
  instruments_for_rent_id INT NOT NULL PRIMARY KEY,
  price VARCHAR(50) NOT NULL,
  CONSTRAINT instrument_fk
    FOREIGN KEY(instruments_for_rent_id)
      REFERENCES instruments_for_rent(id)
      ON DELETE CASCADE
);
CREATE TABLE rented_instrument
(
  instruments_for_rent_id INT NOT NULL,
  student_id INT NOT NULL,
  PRIMARY KEY (instruments_for_rent_id, student_id),
  CONSTRAINT instrument_fk
    FOREIGN KEY(instruments_for_rent_id)
      REFERENCES instruments_for_rent(id)
      ON DELETE CASCADE,
  CONSTRAINT student_fk
    FOREIGN KEY(student_id)
      REFERENCES student(id)
      ON DELETE RESTRICT
);
CREATE TABLE ensemble
(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    minimum_participants INT NOT NULL,
    maximum_participants INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    instructor_id INT NOT NULL,
    lesson_price_plan_id INT NOT NULL,
    CONSTRAINT instructor_fk
        FOREIGN KEY(instructor_id)
            REFERENCES instructor(id)
            ON DELETE SET NULL,
    CONSTRAINT price_plan_fk
        FOREIGN KEY(lesson_price_plan_id)
            REFERENCES lesson_price_plan(id)
            ON DELETE RESTRICT

);

CREATE TABLE ensemble_participants
(
    ensemble_id INT NOT NULL PRIMARY KEY,
    student_id INT NOT NULL,
    CONSTRAINT student_fk
        FOREIGN KEY(student_id)
            REFERENCES student(id)
            ON DELETE CASCADE
);

CREATE TABLE individual_lesson
(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    instrument VARCHAR(50) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    student_id INT NOT NULL,
    lesson_price_plan_id INT NOT NULL,
    skill_level_id INT NOT NULL,
    instructor_id INT NOT NULL,
    CONSTRAINT student_fk
        FOREIGN KEY(student_id)
            REFERENCES student(id)
            ON DELETE CASCADE,
    CONSTRAINT price_plan_fk
        FOREIGN KEY(lesson_price_plan_id)
            REFERENCES lesson_price_plan(id)
            ON DELETE RESTRICT,
    CONSTRAINT skill_fk
        FOREIGN KEY(skill_level_id)
            REFERENCES skill_levels(id)
            ON DELETE RESTRICT,
    CONSTRAINT instructor_fk
        FOREIGN KEY(instructor_id)
            REFERENCES instructor(id)
            ON DELETE SET NULL
);

CREATE TABLE group_lesson
(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    minimum_participants INT NOT NULL,
    maximum_participants INT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    student_id INT NOT NULL,
    lesson_price_plan_id INT NOT NULL,
    skill_level_id INT NOT NULL,
    instructor_id INT NOT NULL,
    CONSTRAINT student_fk
        FOREIGN KEY(student_id)
            REFERENCES student(id)
            ON DELETE SET NULL,
    CONSTRAINT price_plan_fk
        FOREIGN KEY(lesson_price_plan_id)
            REFERENCES lesson_price_plan(id)
            ON DELETE RESTRICT,
    CONSTRAINT skill_fk
        FOREIGN KEY(skill_level_id)
            REFERENCES skill_levels(id)
            ON DELETE RESTRICT,
    CONSTRAINT instructor_fk
        FOREIGN KEY(instructor_id)
            REFERENCES instructor(id)
            ON DELETE SET NULL
);

CREATE TABLE group_participants
(
    group_lesson_id INT NOT NULL PRIMARY KEY,
    student_id INT NOT NULL,
    CONSTRAINT group_lesson_fk
        FOREIGN KEY(group_lesson_id)
            REFERENCES group_lesson(id)
            ON DELETE CASCADE,
    CONSTRAINT student_fk
        FOREIGN KEY(student_id)
            REFERENCES student(id)
            ON DELETE CASCADE
);

CREATE TABLE instruments
(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    instrument_type VARCHAR(50) NOT NULL,
    student_id INT NOT NULL,
    instructor_id INT NOT NULL,
    CONSTRAINT student_fk
        FOREIGN KEY(student_id)
            REFERENCES student(id)
            ON DELETE CASCADE,
    CONSTRAINT instructor_fk
        FOREIGN KEY(instructor_id)
            REFERENCES instructor(id)
            ON DELETE CASCADE
);
