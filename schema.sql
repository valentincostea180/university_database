-- In this SQL file, you may written the schema of the database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Represent students erolled in any faculty of UNSTPB
CREATE TABLE "students" (
    "id" INTEGER NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "joining_date" NUMERIC DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "finished" INTEGER DEFAULT 0 NOT NULL,
    PRIMARY KEY("id")
);

-- Represent professors of UNSTPB
CREATE TABLE "professors" (
    "id" INTEGER NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "joining_date" NUMERIC DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "role" TEXT CHECK( "role" IN ('Rector', 'Prerector', 'Assistant', 'RG') ) NOT NULL,
    PRIMARY KEY("id")
);

-- Represent all faculties
CREATE TABLE "faculties" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "foundation_year" INTEGER NOT NULL,
    PRIMARY KEY("id")
);

-- Represent sponsors of the faculties
CREATE TABLE "sponsoring_companies" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent the physical classes
CREATE TABLE "classes" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "body" TEXT CHECK( "body" IN ('LEUc','LEUb','LEUa') ) NOT NULL,
    "made_by" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent our cantinas
CREATE TABLE "dinning_halls" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "body" TEXT CHECK( "body" IN ('LEUc','LEUb','LEUa') ) NOT NULL,
    "faculty_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("faculty_id") REFERENCES "faculties""id"
);

-- Represent available courses
CREATE TABLE "courses" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "faculty_id" TEXT NOT NULL,
    "class_id" TEXT NOT NULL,
    "professor_id" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("faculty_id") REFERENCES "faculties""id",
    FOREIGN KEY("class_id") REFERENCES "classes""id",
    FOREIGN KEY("professor_id") REFERENCES "professors""id",
);

-- Represent faculty related events
CREATE TABLE "events" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "professor_id" INTEGER NOT NULL,
    "class_id" INTEGER NOT NULL,
    "info" TEXT NOT NULL,
    "date" NUMERIC NOT NULL,
    FOREIGN KEY("class_id") REFERENCES "classes""id",
    FOREIGN KEY("professor_id") REFERENCES "professors""id",
    PRIMARY KEY("id")
)

-- Represent the realtionship between studetns and faculties
CREATE TABLE "stud_by_fac" (
    "id" INTEGER,
    "student_id" INTEGER,
    "faculty_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("student_id") REFERENCES "students"("id"),
    FOREIGN KEY("faculty_id") REFERENCES "faculties"("id")
);

-- Represent the realtionship between students and courses
CREATE TABLE "stud_by_course" (
    "id" INTEGER,
    "student_id" INTEGER,
    "professor_id" INTEGER,
    "class_id" INTEGER,
    "course_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("student_id") REFERENCES "students"("id"),
    FOREIGN KEY("professor_id") REFERENCES "professors"("id"),
    FOREIGN KEY("course_id") REFERENCES "courses"("id"),
    FOREIGN KEY("class_id") REFERENCES "classes"("id")
);

CREATE TABLE "stud_by_event" (
    "id" INTEGER,
    "student_id" INTEGER,
    "event_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("student_id") REFERENCES "students"("id"),
    FOREIGN KEY("event_id") REFERENCES "events"("id")
);

-- And finally optimization
CREATE INDEX "student_name_search" ON "students" ("first_name", "last_name");
CREATE INDEX "course_by_stud" ON "courses" ("course_id", "sutdent_id");
CREATE INDEX "dinning_by_faculty" ON "dinning_halls" ("name", "faculty_id");
