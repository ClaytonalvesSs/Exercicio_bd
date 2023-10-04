-- exercicio 1 --
CREATE DATABASE dbclaytonegui;
Use dbclaytonegui;

CREATE TABLE tbUsuario(
Idusuario int primary key,
NomeUsuario varchar(45),
DataNascimento date
);

CREATE TABLE tbCliente(
CodigoCli smallint primary key,
Nome varchar(50),
Endereco varchar(60)
);

CREATE TABLE tbEstado(
Id int primary key,
Uf char(2)
);

CREATE TABLE tbProduto(
Barras numeric(13) primary key,
Valor Decimal (10,4),
Dercricao varchar(230)
);

SHOW DATABASES;
SHOW TABLES;


alter table tbCliente modify nome varchar(58);

alter table tbProduto add quantidade tinyint;

describe tbCliente;
describe tbProduto;

 drop table tbEstado;
 
 alter table tbUsuario drop DataNascimento;
 
 describe tbUsuario;
 