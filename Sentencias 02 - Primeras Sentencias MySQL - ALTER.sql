-- Exemplos prácticos de ALTER TABLE en MySQL

create database bd_probas_alter;
use bd_probas_alter;

CREATE TABLE tbl_empregado (
idEmpregado	 	varchar(150),
segundoApelido 	varchar (20) NULL,
primerApelido	varchar (30) NOT NULL,
nomeContacto	varchar (15) NULL,
dataNacemento	datetime NULL,
enderezo		varchar (60) NULL,
cidade			varchar (60),
codigoPostal	char (10),
telefono		varchar (24) NULL,
salario			DECIMAL(8,2) DEFAULT 0.0,
codigoOficina 	varchar(150),
-- Definición de restrición clave primaria
CONSTRAINT PK_tbl_Empregado PRIMARY KEY CLUSTERED (idEmpregado)
);

CREATE TABLE tbl_oficinas
(
codOficina	varchar(150),
nome		varchar (40) NOT NULL,
enderezo    varchar(60) NOT NULL,
codPostal   char(5) NULL,
idDirector  varchar(150) NOT NULL,
cidade      varchar(20) NOT NULL,
provincia   varchar(20), 
telefono    char(9) NULL,

-- Definición de restrición de clave primaria
CONSTRAINT PK_tbl_Oficina_codOficina PRIMARY KEY CLUSTERED (codOficina)); 

-- cambiar el nombre de una tabla
alter table tbl_oficinas rename tbl_oficina;

-- cambiar el juego de caracteres externo
alter table tbl_oficinas character set  latin1;

-- cambiar el motor (engine) de almacenamiento
alter table tbl_oficinas engine=InnDB;

-- Eliminar una columna de una table
alter table tbl_empregado drop column segundoApelido;

-- Añadir una columna de una table
alter table tbl_empregado add column segundoApelido varchar(20) null;

-- Eliminar varias columnas de una table
alter table tbl_empregado drop column segundoApelido, drop column dataNacemento;
alter table tbl_empregado add column segundoApelido varchar(20) null , add column dataNacemento datetime null;
alter table tbl_oficina add column  dataEstablecemeto date;


-- Sentencias alter para añadir y borrar restricciones

-- Añadir uan restriccion check table
Alter table tbl_oficina
add constraint ck_tbl_oficina_dataEstablecemeto check (dataEstablecemeto > '2013-09-07' and dataEstablecemeto < 2019-08-07);









