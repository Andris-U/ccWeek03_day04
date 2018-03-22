DROP TABLE castings;
DROP TABLE stars;
DROP TABLE movies;

CREATE TABLE movies (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255),
  rating DECIMAL,
  budget INT4
);

CREATE TABLE stars (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE castings (
  id SERIAL4 PRIMARY KEY,
  movie_id INT4 REFERENCES movies(id),
  star_id INT4 REFERENCES stars(id),
  fee INT4
);
