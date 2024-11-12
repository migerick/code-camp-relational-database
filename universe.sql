CREATE DATABASE universe;

CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    distance INT,
    galaxy_type VARCHAR(100) NOT NULL,
    is_active BOOLEAN NOT NULL
);

CREATE TABLE star_type (
    star_type_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    is_giant BOOLEAN NOT NULL
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL,
    temperature NUMERIC NOT NULL,
    luminosity INT,
    has_planets BOOLEAN NOT NULL,
    star_type_id INT NOT NULL,
    FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id),
    FOREIGN KEY (star_type_id) REFERENCES star_type(star_type_id)
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    star_id INT NOT NULL,
    radius INT NOT NULL,
    orbital_period NUMERIC NOT NULL,
    is_habitable BOOLEAN NOT NULL,
    FOREIGN KEY (star_id) REFERENCES star(star_id)
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    planet_id INT NOT NULL,
    is_visible BOOLEAN NOT NULL,
    has_ice BOOLEAN,
    mass INT NOT NULL,
    FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);


INSERT INTO galaxy (name, distance, galaxy_type, is_active)
VALUES
('Milky Way', 100000, 'Spiral', TRUE),
('Andromeda', 250000, 'Spiral', TRUE),
('Triangulum', 300000, 'Spiral', TRUE),
('Whirlpool', 150000, 'Spiral', TRUE),
('Pinwheel', 200000, 'Spiral', TRUE),
('Sunflower', 500000, 'Spiral', FALSE);

INSERT INTO star_type (name, description, is_giant)
VALUES
('Red Dwarf', 'A small, low mass star with low luminosity.', FALSE),
('Yellow Dwarf', 'A medium-sized star, like our Sun.', FALSE),
('Giant', 'A star that is in the later stages of its life, much larger than the Sun.', TRUE),
('Supergiant', 'An extremely large star, many times larger than the Sun.', TRUE),
('Neutron Star', 'A star that has collapsed to a very small size after a supernova explosion.', FALSE);

INSERT INTO star (name, galaxy_id, temperature, luminosity, has_planets, star_type_id)
VALUES
('Sun', 1, 5778, 1, TRUE, 2),
('Alpha Centauri', 1, 5790, 1.5, TRUE, 2),
('Sirius', 2, 9940, 25, TRUE, 3),
('Betelgeuse', 3, 3500, 100000, FALSE, 4),
('Rigel', 4, 12000, 100000, TRUE, 4),
('Vega', 5, 9600, 40, TRUE, 2);

INSERT INTO planet (name, star_id, radius, orbital_period, is_habitable)
VALUES
('Earth', 1, 6371, 365.25, TRUE),
('Mars', 1, 3389, 687, TRUE),
('Venus', 1, 6051, 225, FALSE);

INSERT INTO moon (name, planet_id, is_visible, has_ice, mass)
VALUES
('Luna', 1, TRUE, TRUE, 7349),
('Phobos', 2, TRUE, FALSE, 10),
('Deimos', 2, TRUE, FALSE, 5);
