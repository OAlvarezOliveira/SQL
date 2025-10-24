/*
Nombre: Oscar Alvarez Oliveira
Fecha: 03/10/25
Contenido: CREAR DDBB AEROPUERTO
*/

-- Crear la base de datos
CREATE DATABASE bd_RUTAS_AEREAS;
USE bd_RUTAS_AEREAS;

-- Tabla de Compañías Aéreas
CREATE TABLE Compania (
    codCompania VARCHAR(50),
    nombre VARCHAR(150) NOT NULL,
    url VARCHAR(150),
    CONSTRAINT PK_Compania PRIMARY KEY (codCompania)
);

-- Tabla de Aeropuertos
CREATE TABLE Aeropuerto (
    codAeropuerto VARCHAR(50),
    nombre VARCHAR(150) NOT NULL,
    localidad VARCHAR(150) NOT NULL,
    pais VARCHAR(150) NOT NULL,
    CONSTRAINT PK_Aeropuerto PRIMARY KEY (codAeropuerto)
);

-- Tabla de Días de la Semana
CREATE TABLE dia_semana (
    cod_dia INT AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    CONSTRAINT PK_dia_semana PRIMARY KEY (cod_dia)
);

-- Tabla de Rutas Aéreas
CREATE TABLE Ruta (
    codRuta INT AUTO_INCREMENT,
    h_salida TIME NOT NULL,
    h_llegada TIME NOT NULL,
    codCompania VARCHAR(50),
    cod_dia INT,
    codAeropuerto_Origen VARCHAR(50),
    codAeropuerto_Destino VARCHAR(50),
    CONSTRAINT PK_Ruta PRIMARY KEY (codRuta),
    CONSTRAINT FK_Ruta_Compania FOREIGN KEY (codCompania) REFERENCES Compania (codCompania),
    CONSTRAINT FK_Ruta_Dia FOREIGN KEY (cod_dia) REFERENCES dia_semana (cod_dia),
    CONSTRAINT FK_Ruta_Origen FOREIGN KEY (codAeropuerto_Origen) REFERENCES Aeropuerto (codAeropuerto),
    CONSTRAINT FK_Ruta_Destino FOREIGN KEY (codAeropuerto_Destino) REFERENCES Aeropuerto (codAeropuerto)
);
-- Insertar Compañías
INSERT INTO Compania (codCompania, nombre, url) VALUES
('IB', 'Iberia', 'https://www.iberia.com'),
('VY', 'Vueling', 'https://www.vueling.com');

-- Insertar Aeropuertos
INSERT INTO Aeropuerto (codAeropuerto, nombre, localidad, pais) VALUES
('MAD', 'Adolfo Suárez Madrid-Barajas', 'Madrid', 'España'),
('BCN', 'Josep Tarradellas Barcelona-El Prat', 'Barcelona', 'España'),
('CDG', 'Charles de Gaulle', 'París', 'Francia');

-- Insertar Días de la Semana
INSERT INTO dia_semana (nombre) VALUES
('Lunes'), ('Martes'), ('Miércoles'), ('Jueves'), ('Viernes'), ('Sábado'), ('Domingo');

-- Insertar Rutas
INSERT INTO Ruta (h_salida, h_llegada, codCompania, cod_dia, codAeropuerto_Origen, codAeropuerto_Destino) VALUES
('08:00:00', '10:00:00', 'IB', 1, 'MAD', 'BCN'),
('15:00:00', '17:30:00', 'VY', 2, 'BCN', 'CDG'),
('20:00:00', '22:00:00', 'IB', 3, 'CDG', 'MAD');
