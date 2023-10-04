-- exercicio 6 -- 
create database dbdesenvolvimento;
use dbdesenvolvimento;

-- criação da tabela tbproduto -- 
create table tbproduto(
IdProd int primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
Preco decimal (6,3) not null
);

-- modificando a tabela tbproduto -- 
alter table tbproduto add Peso decimal(9,3);
alter table tbproduto add Cor varchar(50);
alter table tbproduto add Marca varchar(50) not null;
alter table tbproduto drop Cor;
alter table tbproduto modify column Peso decimal (9,3) not null;

/* não da para exluir a coluna Cor porque ela ja havia sido excluida anteriormente */

-- criando a base de dados dbLojaGrande --
create database dbLojaGrande;

-- alterando novamente a tbproduto -- 
alter table tbproduto add Cor varchar(50);

-- criando a base de dados dblojica --
create database dblojica; 
use dblojica;

-- criando a tabela tbcliente -- 
create table tbcliente(
NomeCli varchar(50) not null, 
CodigoCli int primary key,
DataCadastro datetime not null
);

-- utilizando a dbLojaGrande -- 
use dbLojaGrande;

-- criando a tabela tbfuncionario --
create table tbfuncionario(
NomeFunc varchar(50) not null,
CodigoFunc int primary key,
DataCadastro datetime not null
);

-- apagando a dbLojaGrande -- 
drop database dbLojaGrande;

-- voltando a modificar a dblojica -- 
use dblojica;
alter table tbcliente add Cpf decimal(11,0) not null unique;