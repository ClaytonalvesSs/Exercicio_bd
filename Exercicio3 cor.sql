-- exercicio 3 --
create database dbcomercio;
use dbcomercio;

create table tbCliente(
Id int primary key,
NomeCli varchar(200) not null,
NumEndereco tinyint not null,
CompEnd varchar(50)
);

create table tbClientePF(
CPF decimal (11,0) primary key,
RG tinyint,
Rgdig char(1),
Nascimento date not null
);

describe tbCliente;
describe tbClientePF;
