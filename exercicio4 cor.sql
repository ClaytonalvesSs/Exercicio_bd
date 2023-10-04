-- exercicio 4 --
create database dbIeda;
use dbIeda;

create table tbproduto(
IdProp int primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
preço decimal(10,2) not null
);

alter table tbproduto add peso decimal (5,3);
alter table tbproduto add cor varchar(50);
alter table tbproduto add marca varchar(50) not null;

describe tbproduto;

alter table tbproduto drop cor;
alter table tbproduto modify peso decimal(6,3) not null;
alter table tbproduto drop DataValidade;

describe tbproduto;
