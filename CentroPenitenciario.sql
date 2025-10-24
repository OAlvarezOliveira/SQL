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
  domicilio varchar(80),
  telefono char(9),
  codPrision varchar(8),
  codDatos varchar(8),
  constraint PK_tbl_detenidos PRIMARY KEY (codDetenido),
  constraint UK_numPasaporte UNIQUE (numPasaporte),
  constraint FK_detenidos_prision FOREIGN KEY (codPrision) REFERENCES tbl_prision (codPrision),
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
);

-- RELACIÓN PRESENTA
create table tbl_presenta (
  codPresenta varchar(8),
  codAntecedente varchar(8),
  codDetenido varchar(8),
  constraint PK_tbl_presenta PRIMARY KEY (codPresenta),
  constraint FK_presenta_antecedentes FOREIGN KEY (codAntecedente) REFERENCES tbl_antecedentes (codAntecedente),
  constraint FK_presenta_detenidos FOREIGN KEY (codDetenido) REFERENCES tbl_detenidos (codDetenido)
);

-- Consultas del sistema
select * from information_schema.schemata;
select * from information_schema.table_constraints;
select * from information_schema.referential_constraints;


