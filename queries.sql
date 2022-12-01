--finding number of lessons in a month
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

SELECT SUM(ensemble + group_lesson + individual_lesson) FROM lessons_february;

--counting one sibling students, again have to create the view before you can count the number of rows

CREATE VIEW one_sibling AS
SELECT student2_id, COUNT (*) FROM(
SELECT * FROM(
SELECT student2_id FROM student_siblings UNION ALL
SELECT student1_id FROM student_siblings) as one_sibling) as one_sibling
GROUP BY student2_id HAVING COUNT (*) = 1;

SELECT SUM(count) FROM one_sibling;

--counting two sibling students
CREATE VIEW two_sibling AS
SELECT student2_id, COUNT (*) FROM(
SELECT * FROM(
SELECT student2_id FROM student_siblings UNION ALL
SELECT student1_id FROM student_siblings) as one_sibling) as one_sibling
GROUP BY student2_id HAVING COUNT (*) = 2;

SELECT COUNT(student2_id) FROM two_sibling;
--counts students without siblings
SELECT COUNT (*) AS students_without_siblings FROM student WHERE student.id NOT IN ((SELECT student1_id FROM student_siblings) UNION (SELECT student2_id FROM student_siblings));
-- shows the students without siblings:
SELECT * FROM student WHERE student.id NOT IN ((SELECT student1_id FROM student_siblings) UNION (SELECT student2_id FROM student_siblings));
