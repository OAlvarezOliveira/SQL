-- SQL DDL - DATE DEFINITION Languaje : create . alter . drop
/*
Nombre: Oscar Alvarez Oliveira
Fecha: 19/09/25
Contenido: PRACTICA CON CREATE & DROP
*/
-- drop database bd_pruebas_empleados;
create database bd_pruebas_empleados;
/*
1. Rangos según tipo de entero

TINYINT → 1 byte 
SMALLINT → 2 bytes 
MEDIUMINT → 3 bytes 
INT o INTEGER → 4 bytes 
BIGINT → 8 bytes 
*/
use bd_pruebas_empleados;	
create table tbl_Oficina (
codOficina integer,
nombre varchar(60),
descripcion varchar (150),
direcion varchar(80),
telefono char(9),
constraint PK_Oficina PRIMARY KEY (codOficina));

create table tbl_Empleado (
codEmpleado varchar(7),
nombre varchar(60) not null,
apellido1 varchar (50) not null,
apellido2 varchar(50) null,
fechaNacimiento date,
codOficina integer ,
constraint PK_Empleado PRIMARY KEY (codEmpleado),
constraint FK_empleado_oficina FOREIGN KEY (codOficina) REFERENCES tbl_Oficina(codOficina));

-- Obtencion de las bases de datos del gestor
select * from information_schema.schemata ; 


-- Obtencion de las restricciones de las tablas : claves primaria , candidata y ajena
select * from information_schema.table_constraints;	

-- Obtencion de las restricciones de la integridad refencial
select * from information_schema.referential_constraints;	

