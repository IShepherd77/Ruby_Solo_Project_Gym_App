DROP TABLE bookings;
DROP TABLE members;
DROP TABLE lessons;


CREATE TABLE lessons (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
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
  premium BOOLEAN DEFAULT FALSE NOT NULL,
  phone VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE bookings (
  id SERIAL8 PRIMARY Key,
  member_id INT8 REFERENCES members(id),
  lesson_id INT8 REFERENCES lessons(id)
);
