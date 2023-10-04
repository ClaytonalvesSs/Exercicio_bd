-- exercicio 9 --
create database dbbanco;
use dbbanco;


create table tbcliente(
Cpf bigint primary key,
Nome varchar(50) not null,
Sexo char(1) not null,
Endereco varchar(50) not null
);

create table tbconta(
NumeroConta int primary key,
Saldo decimal(7,2),
TipoConta smallint,
NumAgencia int not null 
);

create table tbhistorico(
Cpf bigint,
NumeroConta int,
primary key (Cpf, NumeroConta),
DataInicio date
);

-- adicionando as fk na tbhistorico --
alter table tbhistorico add foreign key (Cpf) references tbcliente (Cpf);
alter table tbhistorico add foreign key (NumeroConta) references tbconta(NumeroConta);

create table tbtelefone_cliente(
Telefone int primary key,
Cpf bigint
);

-- adicionando a fk na tbtelefone_cliente --
alter table tbtelefone_cliente add foreign key (Cpf) references tbcliente(Cpf);


create table tbagencia(
NumeroAgencia int primary key,
CodBanco int, 
Endereco varchar(50) not null
);

-- após a criação da tbagencia, adiciono a fk na tbconta -- 
alter table tbconta add foreign key (NumAgencia) references tbagencia(NumeroAgencia);

create table tbbanco(
Codigo int primary key,
Nome varchar(50) not null
);

-- apos a criação da tbbanco, adiciono a fk na tbagencia -- 
alter table tbagencia add foreign key (CodBanco) references tbbanco(Codigo);

-- inserindo registros na tbbanco -- 
insert into tbbanco (Codigo, Nome)
	values (1,'Banco do Brasil');
insert into tbbanco (Codigo, Nome)
	values (104,'Caixa Economica Federal');
insert into tbbanco (Codigo, Nome)
	values (801,'Banco Escola');

-- inserindo registros na tbagencia --
insert into tbagencia (CodBanco, NumeroAgencia, Endereco)
	values(1, 123, 'Av Paulista, 78');
insert into tbagencia (CodBanco, NumeroAgencia, Endereco)
	values(104,159,'Rua Liberdade, 124');
insert into tbagencia (CodBanco, NumeroAgencia, Endereco)
	values(801, 401,'Rua Vinte Três, 23');
insert into tbagencia (CodBanco, NumeroAgencia, Endereco)
	values(801, 485,'Av Marechal, 68');
    
-- inserindo registros na tbcliente --
insert into tbcliente (Cpf, Nome, Sexo, Endereco)
	values(12345678910, 'Enildo', 'M', 'Rua Grande, 75');
insert into tbcliente (Cpf, Nome, Sexo, Endereco)
	values(12345678911, 'Astrogildo', 'M','Rua Pequena, 789');
insert into tbcliente (Cpf, Nome, Sexo, Endereco)
	values(12345678912, 'Monica', 'F', 'Av Larga, 148');
insert into tbcliente (Cpf, Nome, Sexo, Endereco)
	values(12345678913, 'Cascão', 'M', 'Av Principal, 369');
    
-- inserindo registros na tbconta -- 
insert into tbconta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values(9876, 456.05, 1, 123);
insert into tbconta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values(9877, 321.00, 1, 485);
insert into tbconta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values(9878, 100.00, 2, 485);
insert into tbconta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values(9879, 5589.48, 1, 401);
    
-- inserindo registros na tbhistorico --
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values(12345678910, 9876, '2001-04-15');
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values(12345678911, 9877, '2011-03-10');
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values(12345678912, 9878, '2021-03-11');
    insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values(12345678913, 9879, '2000-07-05');
    
-- inserindo registros na tbtelefone_cliente --
insert into tbtelefone_cliente (Cpf, Telefone)
	values(12345678910, 912345678);
insert into tbtelefone_cliente (Cpf, Telefone)
	values(12345678911, 912345679);
insert into tbtelefone_cliente (Cpf, Telefone)
	values(12345678912, 912345680);
insert into tbtelefone_cliente (Cpf, Telefone)
	values(12345678913, 912345681);
    
-- adicionando o atributo e-mail na tbcliente -- 
alter table tbcliente add E_mail varchar (50);

-- recuperando os registros da monica --
select Cpf, Endereco from tbcliente where Nome = 'Monica';

-- recuperando os dados do Banco Escola -- 
select 	NumeroAgencia, Endereco from tbagencia where CodBanco = '801';

-- recuperando os registro de todos do sexo M -- 
select Cpf, Nome, Sexo, Endereco, E_mail from tbcliente where Sexo = 'M';


-- Exercicio 10 -- 

-- excluindo a coluna telefone e cpf do valor 12345678911 --
delete from tbtelefone_cliente where Cpf = '12345678911';
select * from tbtelefone_cliente;

-- alterando o tipo de conta para 2 (DA CONTA 9879) --
set sql_safe_updates = 0;
update tbconta set TipoConta = 2 where NumeroConta = 9879;
select * from tbconta;

-- inserindo email no registro da Monica -- 
update tbcliente set E_mail = 'Astro@Escola.com' where nome = 'Monica';
select * from tbcliente;

-- dando aumento de 10% na conta 9876 --
update tbconta set Saldo = 456.05 * 1.1 where numeroconta = 9876;
select * from tbconta;

-- selecionando apenas Nome, E_mail e Endereco da Monica --
select Nome, E_mail, Endereco from tbcliente where Nome = 'Monica';

-- alterando o nome enildo para enildo candido na tbcliente --
update tbcliente set Nome = 'Enildo Candido' where Nome = 'Enildo';
update tbcliente set E_mail = 'Enildo@escola.com' where Nome = 'Enildo Candido';

-- removendo 30 reais de cada conta -- 
update tbconta set Saldo = Saldo - 30;
select * from tbconta;


-- excluindo a conta 9878 -- 
delete from tbhistorico where NumeroConta = 9878;
delete from tbconta where NumeroConta = 9878;
select * from tbhistorico;
select * from tbconta;