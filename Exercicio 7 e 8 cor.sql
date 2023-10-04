-- exercicio 7 -- 
-- Clayton Alves e Guilherme Gasperini -- 
create database dbescola;
use dbescola;

-- criando a tabela tbcliente --
create table tbcliente(
IdCli int primary key,
NomeCli varchar(50) not null, 
NumEnd smallint,
DataCadastro datetime default current_timestamp()
);

-- alterando a tbcliente --
alter table tbcliente add cpf decimal(11,0) unique not null;
alter table tbcliente add cep decimal(8,0) not null;

-- criando a dbempresa --
create database dbempresa;

-- ainda utilizando a dbescola, crie a tabela tbendereco --
create table tbendereco(
cep decimal(8,0) primary key,
Logradouro varchar(250) not null,
IdUf tinyint
);

-- adicionando a fk na tbcliente --
alter table tbcliente add foreign key Fk_Cep_TbCliente (cep) references tbendereco (cep);

describe tbcliente;

/* tive dificuldades para fazer o comando de adicionar a fk, tanto que tive o auxilio de colegas.
As vezes tenho dificuldades em utilizar o tipo de dados correto*/

-- visualizando as bases de dados do servidor --
show databases;

drop database dbempresa;

-- exercicio 8 -- 
Create table tbest(
IdUf tinyint primary key,
NomeUfs char(2) not null,
NomeEstado char(40) not null
);

-- colocando a fk na tabela tbendereco --
alter table tbendereco add foreign key Fk_IdUf_tbEndereco (IdUf) references tbest (IdUf);

-- alterando a tbest --
alter table tbest drop NomeEstado;
rename table tbest to tbestado;
alter table tbestado rename column NomeUfs to NomeUf;

-- adicionando na tbendereco --
alter table tbendereco add IdCid int;

-- criação da tbcidade --
create table tbcidade(
IdCid int primary key,
NomeCidade varchar(50) not null
);

alter table tbcidade modify column NomeCidade varchar(250) not null;

-- colocando fk na tb endereco -- 
alter table tbendereco add foreign key Fk_IdCid_tbEndereco (IdCid) references tbcidade (IdCid);

describe tbendereco;