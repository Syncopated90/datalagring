 -- /////// OUTPUTS ////////


 -- QUERY 1:
 
 sum | individual_lesson | group_lesson | ensemble
-----+-------------------+--------------+----------
  35 |                10 |           10 |       15

  -- QUERY 2:

   count -- 1 sibling
-------
     4

 count  -- 2 siblings
-------
    12

 students_without_siblings
---------------------------
                         4

  -- QUERY 3:

   instructor_id | count
---------------+-------
            14 |     4
            18 |     3
             5 |     2
            16 |     2

-- QUERY 4:

 participants |       genre       |     start_time      | booking_situation
--------------+-------------------+---------------------+-------------------
            2 | folk              | 2022-12-08 13:43:26 | plenty of space
            4 | grindcore         | 2022-12-06 21:36:19 | plenty of space
            5 | grindcore         | 2022-12-08 03:03:29 | plenty of space
            4 | grindcore         | 2022-12-09 16:12:31 | plenty of space
            7 | grindcore         | 2022-12-10 09:12:39 | one free spot
            6 | pop               | 2022-12-10 07:31:57 | two free spots
            1 | power electronics | 2022-12-08 03:39:44 | plenty of space
            5 | power electronics | 2022-12-09 10:26:59 | plenty of space
            8 | turntablism       | 2022-12-06 22:38:44 | fully booked
            4 | turntablism       | 2022-12-10 09:53:36 | plenty of space
            2 | turntablism       | 2022-12-11 16:02:12 | plenty of space