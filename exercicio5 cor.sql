-- exercicio 5 --
CREATE DATABASE dbvanessa;
use dbvanessa;

CREATE TABLE tbvenda(
NF int primary key auto_increment,
DataValidade date not null
);

ALTER TABLE tbvenda add preco decimal not null;
ALTER TABLE  tbvenda add Qtd tinyint;

ALTER TABLE tbvenda DROP dataValidade;
ALTER TABLE tbvenda ADD DataVenda date default (current_date);

CREATE TABLE tbproduto(
CodigoB int primary key,
NomeProd varchar(50) not null
);

alter table tbvenda add foreign key (NF) references tbproduto (CodigoB);


describe tbvenda;

