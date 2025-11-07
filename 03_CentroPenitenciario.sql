create database db_centroPenitenciario;
use db_centroPenitenciario;

-- PRISIONES
create table tbl_prision (
  codPrision varchar(8),
  nombrePrision varchar(150) not null,
  descripcion varchar(150),
  constraint PK_tbl_Prision PRIMARY KEY (codPrision)
);

-- DATOS FISICOS
create table tbl_datosFisicos (
  codDatos varchar(8),
  colorPelo varchar(50) not null,
  tatuajes varchar(150),
  altura smallint,
  peso smallint,
  constraint PK_tbl_datosFisicos PRIMARY KEY (codDatos)
);

-- DETENIDOS
create table tbl_detenidos (
  codDetenido varchar(8),
  numPasaporte varchar(8) not null,
  nombreDetenido varchar(50) not null,
  apellido1 varchar(150) not null,
  apellido2 varchar(150),
  fechaNacimiento date not null,
  lugarNacimiento varchar(150) not null,
  domicilio varchar(80) default 'Avda Buenos Aires',
  telefono char(9),
  codPrision varchar(8) null,
  codDatos varchar(8),
  -- Clave primaria
  constraint PK_tbl_detenidos PRIMARY KEY (codDetenido),
  -- Clave única
  constraint UK_numPasaporte UNIQUE (numPasaporte),
  -- Restriccion Check
   constraint Ok_fechaNacimiento CHECK (fechaNacimiento < GETDATE()),
  -- Clave Ajena
  constraint FK_detenidos_prision FOREIGN KEY (codPrision) REFERENCES tbl_prision (codPrision)
  on delete set null
  on update cascade,
  constraint FK_datosFisicos_detenidos FOREIGN KEY (codDatos) REFERENCES tbl_datosFisicos (codDatos)
);

-- COLOR OJOS
create table tbl_colorOjos (
  codColorOjos varchar(8),
  color varchar(50),
  ojo varchar(50),
  descripcion varchar(50),
  codDatos varchar(8),
  constraint PK_tbl_colorOjos PRIMARY KEY (codColorOjos),
  constraint FK_ojos_datosFisicos FOREIGN KEY (codDatos) REFERENCES tbl_datosFisicos (codDatos)
  on delete restrict
  on update cascade
);

-- CONTACTOS
create table tbl_contactos (
  codContactos varchar(8),
  nombre varchar(50) not null,
  apellido1 varchar(50) not null,
  apellido2 varchar(50),
  tipoContacto enum ('abogado','familiar'),
  codDetenido varchar(8),
  constraint PK_tbl_contactos PRIMARY KEY (codContactos),
  constraint FK_contactos_detenidos FOREIGN KEY (codDetenido) REFERENCES tbl_detenidos (codDetenido)
  on delete restrict
  on update cascade
);

-- DETENCION
create table tbl_detencion (
  codDetencion varchar(8),
  motivo varchar(50) not null,
  estadoLegal varchar(50),
  expedienteJudicial varchar(25),
  juzgadoACargo varchar(25),
  fecha datetime,
  lugar varchar(50) not null,
  codDetenido varchar(8),
  constraint PK_tbl_detencion PRIMARY KEY (codDetencion),
  constraint UK_expedienteJudicial UNIQUE (expedienteJudicial),
  constraint FK_detencion_detenidos FOREIGN KEY (codDetenido) REFERENCES tbl_detenidos (codDetenido)
 on delete restrict
  on update cascade
);

-- ANTECEDENTES
create table tbl_antecedentes (
  codAntecedente varchar(8),
  fecha datetime,
  condena varchar(50),
  nombreAntecedente varchar(25),
  codDetenido varchar(8),
  constraint PK_tbl_antecedentes PRIMARY KEY (codAntecedente),
  constraint FK_antecedentes_detenidos FOREIGN KEY (codDetenido) REFERENCES tbl_detenidos (codDetenido)
  on delete restrict
  on update cascade
);

-- RELACIÓN PRESENTA
create table tbl_presenta (
  codPresenta varchar(8),
  codAntecedente varchar(8),
  codDetenido varchar(8),
  constraint PK_tbl_presenta PRIMARY KEY (codPresenta),
  constraint FK_presenta_antecedentes FOREIGN KEY (codAntecedente) REFERENCES tbl_antecedentes (codAntecedente)
  on delete cascade
  on update cascade,
  constraint FK_presenta_detenidos FOREIGN KEY (codDetenido) REFERENCES tbl_detenidos (codDetenido)
  on delete restrict
  on update cascade
);

-- Ingesta de datos inicial 

-- PRISIONES
insert into tbl_prision values 
('PR000001', 'Centro Penitenciario Madrid I', 'Prisión de máxima seguridad'),
('PR000002', 'Centro Penitenciario Sevilla', 'Prisión regional del sur');

-- DATOS FISICOS
insert into tbl_datosFisicos values 
('DF000001', 'Castaño', 'Tatuaje en brazo derecho', 180, 75),
('DF000002', 'Rubio', 'Ninguno', 165, 60);

-- DETENIDOS
insert into tbl_detenidos values 
('DT000001', 'X1234567', 'Juan', 'Pérez', 'López', '2026-07-10', 'Madrid', 'Calle Mayor 12', '612345678', 'PR000001', 'DF000001'),
('DT000002', 'Y7654321', 'Ana', 'García', NULL, '1990-03-22', 'Sevilla', 'Av. Andalucía 34', '699876543', 'PR000002', 'DF000002'),
('DT000003', 'Y7654331', 'Ana', 'García', NULL, '1990-03-22', 'Sevilla', default,'699876543', 'PR000002', 'DF000002');

-- COLOR OJOS
insert into tbl_colorOjos values 
('CO000001', 'Marrón', 'Izquierdo', 'marrón claro', 'DF000001'),
('CO000002', 'Verde', 'Derecho', 'verde intenso', 'DF000002');

-- CONTACTOS
insert into tbl_contactos values 
('CT000001', 'Carlos', 'Pérez', 'Ruiz', 'abogado', 'DT000001'),
('CT000002', 'Laura', 'García', NULL, 'familiar', 'DT000002');

-- DETENCION
insert into tbl_detencion values 
('DE000001', 'Robo con fuerza', 'Prisión preventiva', 'EXP1234', 'Juzgado Nº5', '2022-01-15 10:30:00', 'Madrid', 'DT000001'),
('DE000002', 'Estafa', 'En juicio', 'EXP5678', 'Juzgado Nº2', '2023-05-10 09:00:00', 'Sevilla', 'DT000002');

-- ANTECEDENTES
insert into tbl_antecedentes values 
('AN000001', '2020-04-20 12:00:00', '2 años prisión', 'Hurto menor', 'DT000001'),
('AN000002', '2021-07-11 14:30:00', '1 año condicional', 'Falsificación', 'DT000002');

-- PRESENTA
insert into tbl_presenta values 
('PS000001', 'AN000001', 'DT000001'),
('PS000002', 'AN000002', 'DT000002');



-- Consultas del sistema
select * from information_schema.schemata;
select * from information_schema.table_constraints;
select * from information_schema.referential_constraints;


