

TRUNCATE TABLE students, cohorts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.


INSERT INTO cohorts (cohort_name, starting_date) VALUES
('April', '2023-04-13'),
('January', '2023-01-13'),
('October', '2023-10-13');

INSERT INTO students (student_name, cohort_id) VALUES 
('David', 1),
('Emma', 1),
('John', 2),
('Carrie', 2),
 ('Anna', 3);