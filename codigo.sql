-- Crear la extensión PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- Crear la tabla areas_protegidas
DROP TABLE IF EXISTS areas_protegidas CASCADE;
CREATE TABLE areas_protegidas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    categoria VARCHAR(100),
    geom GEOMETRY(POLYGON, 4326)
);

-- Crear la tabla cuerpos_agua
DROP TABLE IF EXISTS cuerpos_agua CASCADE;
CREATE TABLE cuerpos_agua (
    id SERIAL PRIMARY KEY,
    id_area INTEGER,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(100),
    geom GEOMETRY(POLYGON, 4326),
    FOREIGN KEY (id_area) REFERENCES areas_protegidas(id)
);

-- Crear la tabla ictiofauna
DROP TABLE IF EXISTS ictiofauna CASCADE;
CREATE TABLE ictiofauna (
    id SERIAL PRIMARY KEY,
    id_cagua INTEGER, 
    fecha_registro DATE,
    nombre_especie VARCHAR(255) NOT NULL,
    IUCN VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_cagua) REFERENCES cuerpos_agua(id)
);

-- Crear la tabla puntos_avistamiento_aves
DROP TABLE IF EXISTS puntos_avistamiento_aves CASCADE;
CREATE TABLE puntos_avistamiento_aves (
    id SERIAL PRIMARY KEY,
    id_area INTEGER, 
    especie VARCHAR(255) NOT NULL,
    fecha_observacion DATE NOT NULL,
    geom GEOMETRY(POINT, 4326),
    FOREIGN KEY (id_area) REFERENCES areas_protegidas(id)
);

-- Crear la tabla clase_suelo
DROP TABLE IF EXISTS clase_suelo CASCADE;
CREATE TABLE clase_suelo (
    id SERIAL PRIMARY KEY,
    id_area INTEGER, 
    tipo_suelo VARCHAR(100) NOT NULL,
    geom GEOMETRY(POLYGON, 4326),
    FOREIGN KEY (id_area) REFERENCES areas_protegidas(id)
);

-- Crear la tabla especies_fauna
DROP TABLE IF EXISTS especies_fauna CASCADE;
CREATE TABLE especies_fauna (
    id SERIAL PRIMARY KEY,
    id_csuelo INTEGER, 
    nombre_comun VARCHAR(255) NOT NULL,
    nombre_cientifico VARCHAR(255) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    geom GEOMETRY(POINT, 4326),
    FOREIGN KEY (id_csuelo) REFERENCES clase_suelo(id)
);
