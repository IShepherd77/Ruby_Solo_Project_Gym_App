DROP TABLE bookings; --drop table with REFERENCES to foreign keys first
DROP TABLE members;
DROP TABLE lessons;

--table names are plural but keys are singular
CREATE TABLE lessons (
  id SERIAL8 PRIMARY KEY, -- id is PRIMARY KEY
  name VARCHAR(255) NOT NULL, -- NOT NULL means cannot be blank field
  capacity INT4,
  lesson_date DATE NOT NULL,
  start_time TIME without time zone NOT NULL,
  duration INT4 NOT NULL
);

CREATE TABLE members(
  id SERIAL8 PRIMARY KEY,
  forename VARCHAR(255) NOT NULL,
  surname VARCHAR(255) NOT NULL,
  dob DATE NOT NULL,
  premium BOOLEAN DEFAULT FALSE NOT NULL,  --Default can be TRUE or FALSE
  phone VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE bookings (
  id SERIAL8 PRIMARY Key,
  member_id INT8 REFERENCES members(id) ON DELETE CASCADE, -- A foreign key with cascade delete means that if a record in the parent table is deleted, then the corresponding records in the child table will automatically be deleted.
  lesson_id INT8 REFERENCES lessons(id) ON DELETE CASCADE
);
