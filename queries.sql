--Task 3 assignment 1: finding number of lessons in a month
SELECT
(SELECT COUNT (start_time) FROM ensemble WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as ensemble,
(SELECT COUNT (start_time) FROM group_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as group_lesson,
(SELECT COUNT (start_time) FROM individual_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as individual_lesson,
((SELECT COUNT (start_time) FROM ensemble WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') +
(SELECT COUNT (start_time) FROM group_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') +
(SELECT COUNT (start_time) FROM individual_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28'))  AS total;

--other way to do it, better? Have to create the view and run the sum query in different commands
CREATE VIEW lessons_february AS
SELECT
(SELECT COUNT (start_time) FROM ensemble WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as ensemble,
(SELECT COUNT (start_time) FROM group_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as group_lesson,
(SELECT COUNT (start_time) FROM individual_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as individual_lesson;

SELECT SUM(ensemble + group_lesson + individual_lesson), individual_lesson, group_lesson, ensemble
FROM lessons_february GROUP BY individual_lesson, group_lesson, ensemble;

--do the above without a VIEW
SELECT SUM(ensemble + group_lesson + individual_lesson), individual_lesson, group_lesson, ensemble FROM
(SELECT
(SELECT COUNT (start_time) FROM ensemble WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as ensemble,
(SELECT COUNT (start_time) FROM group_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as group_lesson,
(SELECT COUNT (start_time) FROM individual_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as individual_lesson) AS foo
GROUP BY individual_lesson, group_lesson, ensemble;

--TASK 3 assignment 2:counting one sibling students, again have to create the view before you can count the number of rows

CREATE VIEW one_sibling AS
SELECT student2_id, COUNT (*) FROM(
SELECT * FROM(
SELECT student2_id FROM student_siblings UNION ALL
SELECT student1_id FROM student_siblings) as x) as x
GROUP BY student2_id HAVING COUNT (*) = 1;

SELECT COUNT(student2_id) FROM one_sibling;

--counting two sibling students
CREATE VIEW two_siblings AS
SELECT student2_id, COUNT (*) FROM(
SELECT * FROM(
SELECT student2_id FROM student_siblings UNION ALL
SELECT student1_id FROM student_siblings) as x) as x
GROUP BY student2_id HAVING COUNT (*) = 2;

SELECT COUNT(student2_id) FROM two_siblings;
--counts students without siblings
SELECT COUNT (*) AS students_without_siblings FROM student WHERE student.id NOT IN
((SELECT student1_id FROM student_siblings) UNION (SELECT student2_id FROM student_siblings));
-- shows the students without siblings:
SELECT * FROM student WHERE student.id NOT IN ((SELECT student1_id FROM student_siblings) UNION (SELECT student2_id FROM student_siblings));

--Task3 assignemnt 3: select all instructors who have worked more than a certain number of shifts in December, in this case 1
SELECT instructor_id, COUNT(instructor_id) FROM
((SELECT instructor_id FROM group_lesson WHERE start_time BETWEEN '2022-12-01' AND '2022-12-31' )
UNION ALL(SELECT instructor_id FROM individual_lesson WHERE start_time BETWEEN '2022-12-01' AND '2022-12-31' )
UNION ALL(SELECT instructor_id FROM ensemble WHERE start_time BETWEEN '2022-12-01' AND '2022-12-31')) AS instructors
GROUP BY instructor_id HAVING COUNT (*) > 1 ORDER BY COUNT(instructor_id) DESC;

--count number of shifts for one instructor over the whole year with union
SELECT COUNT (instructor_id) FROM ((SELECT instructor_id FROM group_lesson)
UNION ALL(SELECT instructor_id FROM individual_lesson)
UNION ALL(SELECT instructor_id FROM ensemble)) AS instructors
WHERE instructor_id = 16;

--Task 3 assingment 4:lists number of ensemble participants from now until one week ahead
SELECT COUNT(student_id) AS participants, genre, start_time, CASE
  WHEN COUNT(student_id) = maximum_participants THEN 'fully booked'
  WHEN COUNT(student_id) = (maximum_participants - 1) THEN 'one free spot'
  WHEN COUNT(student_id) = (maximum_participants - 2) THEN 'two free spots'
  ELSE 'plenty of space'
  END booking_situation
FROM (SELECT * FROM ensemble
INNER JOIN ensemble_participants
ON ensemble.id = ensemble_participants.ensemble_id
WHERE ensemble.start_time BETWEEN current_date AND current_date + interval '1 week') as events
GROUP BY genre, start_time, maximum_participants ORDER BY genre, start_time;

--finding current date and current month
SELECT current_Date, (current_date + interval '1 week');
SELECT date_trunc('month', current_date), date_trunc('month', (current_date + interval '1 month'));

--finding ensembles within a certain date
SELECT * FROM ensemble WHERE start_time BETWEEN current_date AND current_date + interval '1 week' ORDER BY genre, start_time ASC;

--BEGIN and COMMIT to start and end transactions
--finding brand and price for available instruments_for_rent for a certain type of instrument
SELECT brand, price, instrument_id FROM instruments_for_rent
INNER JOIN instrument_price_list ON instruments_for_rent.id = instrument_price_list.instruments_for_rent_id
WHERE instruments_for_rent.id NOT IN
(SELECT instruments_for_rent_id FROM rented_instrument WHERE end_date IS NULL)
AND instruments_for_rent.type = 'synthesizer';
--find all instruments available for rent
SELECT instruments_for_rent_id, instrument_id, type, brand, price FROM instruments_for_rent
INNER JOIN instrument_price_list ON instruments_for_rent.id = instrument_price_list.instruments_for_rent_id
WHERE instruments_for_rent.id NOT IN
(SELECT instruments_for_rent_id FROM rented_instrument WHERE end_date IS NULL) FOR UPDATE;
--check number of rentals by one students
SELECT COUNT(*) FROM rented_instrument WHERE student_id = ?;
--create rental of instrument
INSERT INTO rented_instrument (instruments_for_rent_id, student_id, start_date, end_date ) VALUES (
(SELECT id FROM instruments_for_rent WHERE instrument_id = '0504308159'), 2, current_date, null);
--end rental
UPDATE rented_instrument SET end_date = current_date WHERE instruments_for_rent_id =
(SELECT id FROM instruments_for_rent WHERE instrument_id = '0504308159');
