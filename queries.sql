--finding number of lessons in a month
SELECT
(SELECT COUNT (start_time) FROM ensemble WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as ensemble,
(SELECT COUNT (start_time) FROM group_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as group_lesson,
(SELECT COUNT (start_time) FROM individual_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as individual_lesson,
((SELECT COUNT (start_time) FROM ensemble WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') +
(SELECT COUNT (start_time) FROM group_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') +
(SELECT COUNT (start_time) FROM individual_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28'))  AS total;

--other way to do it
CREATE VIEW lessons_february AS
SELECT
(SELECT COUNT (start_time) FROM ensemble WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as ensemble,
(SELECT COUNT (start_time) FROM group_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as group_lesson,
(SELECT COUNT (start_time) FROM individual_lesson WHERE start_time BETWEEN '2022-02-01' AND '2022-02-28') as individual_lesson;

SELECT SUM(ensemble + group_lesson + individual_lesson) FROM view_lessons;

--counting siblings
SELECT COUNT (DISTINCT student1_id) FROM student_siblings;
SELECT student1_id, COUNT(student1_id) FROM student_siblings GROUP BY student1_id;
