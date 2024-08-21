-- In this SQL file, you may find writen some typical SQL queries users will run on my database

-- Find if a given student has finished his BD by first and last name
SELECT "finished"
FROM "student"
WHERE "first_name" = 'Andrei'
AND "last_name" = 'CIMPOIASI';


-- Find all events a given student signed up for
SELECT "name"
FROM "events"
WHERE "id" = (
    SELECT "id"
    FROM "stud_by_event"
    WHERE "student_id" = (
        SELECT "id"
        FROM "students"
        WHERE "first_name" = 'Matei'
        AND "last_name" = "PATARNIE"
    )
);

-- Find the professor of a given course
SELECT "first_name", "last_name"
FROM "professor"
WHERE "id" = (
    SELECT "professor_id"
    FROM "courses"
    WHERE "name" = 'Algebra 1'
);

-- Add a new sponsor
INSERT INTO "sponsoring_companies" ("name", "industry", "location")
VALUES ('TechY', 'IT and Telecom', '123 Sesame Street');

-- Add a new event
INSERT INTO "events" ("name", "professor_id", "class_id", "info", "date")
VALUES ('Learning AI', '23', '104', 'Dive into the foundations of Artificial Intelligence (AI)
                                    with our compact session. Explore essential concepts including
                                    machine learning, neural networks, natural language processing,
                                    and computer vision.', '2024-02-28');

-- Add a new cantina
INSERT INTO "dinning_halls" ("name", "body", "submission_path", "faculty_id")
VALUES ('Alexandru Negrescu', 'LEUc', '3'); 
