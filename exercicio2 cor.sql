-- exercicio 2 --
CREATE DATABASE dbfabricio;
USE dbfabricio;

CREATE TABLE tbproduto(
IdProd int not null primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
Preço decimal(10,2) not null
);

CREATE TABLE tbcliente(
Codigo int primary key,
NomeCli varchar(50) not null, 
DataNascimento date null
);