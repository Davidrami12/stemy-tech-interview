CREATE DATABASE pokedex;
USE pokedex;

-- Crear tablas necesarias según el modelo
CREATE TABLE pokemon_type (
    type VARCHAR(255) PRIMARY KEY
);

CREATE TABLE pokemon_species (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE pokemon_species_type (
    pokemon_species_id INTEGER REFERENCES pokemon_species(id),
    pokemon_type VARCHAR(255) REFERENCES pokemon_type(type),
    PRIMARY KEY (pokemon_species_id, pokemon_type)
);

CREATE TABLE pokemon (
    id INTEGER PRIMARY KEY,
    pokemon_species_id INTEGER REFERENCES pokemon_species(id),
    level INTEGER NOT NULL
);

CREATE TABLE trainer (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE trainer_pokedex (
    pokemon_id INTEGER REFERENCES pokemon(id),
    trainer_id INTEGER REFERENCES trainer(id),
    captured_at TIMESTAMP NOT NULL,
    PRIMARY KEY (pokemon_id, trainer_id, captured_at)
);


-- Insertar datos de prueba para cada tabla
INSERT INTO pokemon_species (id, name) VALUES (22, 'Onix');
INSERT INTO pokemon_species (id, name) VALUES (54, 'Pikachu');

INSERT INTO pokemon_species_type (pokemon_species_id, pokemon_type) VALUES (22, 'Rock');
INSERT INTO pokemon_species_type (pokemon_species_id, pokemon_type) VALUES (22, 'Ground');
INSERT INTO pokemon_species_type (pokemon_species_id, pokemon_type) VALUES (54, 'Electric');

INSERT INTO pokemon_type (type) VALUES ('Rock');
INSERT INTO pokemon_type (type) VALUES ('Ground');
INSERT INTO pokemon_type (type) VALUES ('Electric');

INSERT INTO pokemon (id, pokemon_species_id, level) VALUES (100, 22, 10);
INSERT INTO pokemon (id, pokemon_species_id, level) VALUES (101, 54, 20);

INSERT INTO trainer (id, name) VALUES (2, 'Ash Ketchum');
INSERT INTO trainer (id, name) VALUES (1, 'Brock');

INSERT INTO trainer_pokedex (pokemon_id, trainer_id, captured_at) VALUES (100, 1, '2023-10-30 10:00:00');
INSERT INTO trainer_pokedex (pokemon_id, trainer_id, captured_at) VALUES (101, 2, '2023-10-14 11:00:00');



-- 1. Devolver el número de Pokémon que ha capturado cada entrenador:
SELECT t.name AS 'Trainer Name', COUNT(tp.pokemon_id) AS 'Number of Pokémon Captured'
FROM trainer t
JOIN trainer_pokedex tp ON t.id = tp.trainer_id
GROUP BY t.name;


-- 2. Devolver los pokémon de tipo Electric que haya capturado Ash Ketchum:
SELECT  p.id AS 'Pokémon ID',
		p.level AS 'Level',
		ps.name AS 'Pokémon Name',
		tp.captured_at AS 'Captured At'
FROM pokemon p
JOIN pokemon_species ps ON p.pokemon_species_id = ps.id
JOIN trainer_pokedex tp ON p.id = tp.pokemon_id
JOIN trainer t ON t.id = tp.trainer_id
JOIN pokemon_species_type pst ON ps.id = pst.pokemon_species_id
WHERE pst.pokemon_type = 'Electric' AND t.name = 'Ash Ketchum';


-- 3. Devolver último pokémon que haya capturado Brock:
SELECT 
    p.id AS 'Pokémon ID',
    p.level AS 'Level',
    ps.name AS 'Pokémon Name',
    tp.captured_at AS 'Captured At'
FROM pokemon p
JOIN pokemon_species ps ON p.pokemon_species_id = ps.id
JOIN trainer_pokedex tp ON p.id = tp.pokemon_id
JOIN trainer t ON t.id = tp.trainer_id
WHERE t.name = 'Brock'
ORDER BY tp.captured_at DESC
LIMIT 1;
