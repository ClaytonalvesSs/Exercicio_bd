-- Exercicio 11 --

create database dbDistribuidora;
use dbDistribuidora;

create table tbEstado(
UFId int primary key auto_increment,
UF char(2) not null
);

create table tbCidade(
CidadeId int primary key auto_increment,
Cidade varchar(200) not null
);

create table tbBairro(
BairroId int primary key auto_increment,
Bairro varchar(200) not null
);

create table tbEndereco(
CEP decimal(8,0) primary key,
Logradouro varchar(200) not null,
BairroId int not null,
CidadeId int not null,
UFId int not null,
foreign key (BairroId) references tbBairro (BairroId),
foreign key (CidadeId) references tbcidade (CidadeId),
foreign key (UFId) references tbestado (UFId)
);

create table tbCliente(
Id int primary key auto_increment,
NomeCli varchar(200) not null,
NumEnd smallint not null,
CompEnd varchar(50),
CEP decimal(8,0) not null,
foreign key (CEP) references tbendereco (CEP)
);

create table tbCliente_pj(
CNPJ decimal(14,0) primary key,
IE decimal(11,0) unique,
Id int,
foreign key (Id) references tbcliente (Id)
);

create table tbCliente_pf(
CPF decimal(11,0) primary key,
RG decimal(9,0) not null, 
RG_Dig char(1) not null,
Nasc date not null,
Id int,
foreign key (Id) references tbcliente (Id)
);

create table tbNota_fiscal(
NF int primary key,
TotalNota decimal(8,2) not null,
DataEmissao date not null
);

create table tbVenda(
NumeroVenda int primary key auto_increment,
DataVenda date,
TotalVenda decimal(8,2) not null,
NF int,
Id_Cli int not null,
foreign key (NF) references tbnota_fiscal (NF),
foreign key (Id_Cli) references tbcliente (Id)
);

create table tbProduto(
CodigoBarras decimal(14,0) primary key,
Nome varchar(200) not null,
Valor decimal(8,2) not null,
Qtd int
);

create table tbItem_venda(
Qtd int not null,
ValorItem decimal(8,2) not null,
CodigoBarras decimal(14,0),
NumeroVenda int,
foreign key (CodigoBarras)  references tbproduto (CodigoBarras),
foreign key (NumeroVenda) references tbvenda (NumeroVenda),
primary key (CodigoBarras,NumeroVenda)
);


create table tbFornecedor(
Codigo int primary key auto_increment,
CNPJ numeric(14) unique,
Nome varchar(200) not null,
Telefone numeric(11)
);

create table tbCompra(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal(8,2) not null,
QtdTotal int not null,
Codigo int,
foreign key (Codigo) references tbFornecedor (Codigo)
);

create table tbItem_compra(
Qtd int not null,
ValorItem decimal(8,2) not null,
NotaFiscal int,
CodigoBarras decimal(14,0),
foreign key (NotaFiscal) references tbcompra (NotaFiscal),
foreign key (CodigoBarras) references tbproduto (CodigoBarras),
primary key (NotaFiscal,CodigoBarras)
);


-- Exercicios DML -- 

insert into tbFornecedor (Codigo, CNPJ, Nome, Telefone) values
(default, 1245678937123, 'Revenda Chico Loco', 11934567897),
(default, 1345678937123, 'José Faz Tudo S/A ', 11934567898),
(default, 1445678937123, 'Vadalto Entregas', 11934567899),
(default, 1545678937123, 'Astrogilo das Estrelas', 11934567800),
(default, 1645678937123, 'Amoroso e Doce', 11934567801),
(default, 1745678937123, 'Marcelo Dedal', 11934567802),
(default, 1845678937123, 'Franciscano Cachaça', 11934567803),
(default, 1945678937123, 'Joãozinho Chupeta', 11934567804);

select * from tbFornecedor;

-- Exercicio 2 DML -- 
 Delimiter $$
 create procedure spInsertTbcidade(vCidadeId int, vCidade varchar(200))
 begin
     if not exists (select * from tbCidade where Cidade= vCidade) then 
         insert into tbCidade (CidadeId, Cidade) values (vCidadeId, vCidade); 
     end if;
 end$$

 call spInsertTbcidade(null,'Rio de Janeiro');
 call spInsertTbcidade(null, 'São Carlos');
 call spInsertTbcidade(null,'Campinas');
 call spInsertTbcidade(null,'Franco da Rocha');
 call spInsertTbcidade(null,'Osasco');
 call spInsertTbcidade(null,'Pirituba');
 call spInsertTbcidade(null,'Lapa');
 call spInsertTbcidade(null,'Ponta Grossa');
 
 select * from tbcidade;
 
 -- Exercicio 3 DML -- 
 delimiter $$
 create procedure spInsertTbEstado(vUFId int, vUF varchar(2))
 begin
 if not exists (select * from tbEstado where UF = vUF) then 
         insert into tbEstado (UFId, UF) values (vUFId, vUF); 
     end if; 
 end $$
 
 call spInsertTbEstado(null, 'SP');
 call spInsertTbEstado(null, 'RJ');
 call spInsertTbEstado(null, 'RS');
 
 select * from tbestado;
 
 -- Exercicio 4 DML -- 
 delimiter $$
 create procedure spInsertTbBairro(vBairroId int, vBairro varchar(200))
 begin
 if not exists (select * from tbBairro where Bairro = vBairro) then 
        insert into tbbairro(BairroId, Bairro) values(vBairroId, vBairro);
     end if; 
 end $$
 
 call spInsertTbBairro(null, 'Aclimação');
 call spInsertTbBairro(null, 'Capão Redondo');
 call spInsertTbBairro(null, 'Pirituba');
 call spInsertTbBairro(null, 'Liberdade');
 
 select * from tbBairro;
 
-- Exercicio 5 DML --
delimiter $$
create procedure spInsertTbProduto(vCodigoBarras decimal(14,0), vNome varchar(200), vValor decimal(8,2), vQtd int)
begin
	if not exists (select * from tbProduto where CodigoBarras = vCodigoBarras) then 
         insert into tbProduto (CodigoBarras, Nome, Valor, Qtd) values (vCodigoBarras, vNome, vValor, vQtd); 
     end if; 
end $$

call spInsertTbProduto(12345678910111, 'Rei de Papel Mache', 54.61, 120);
call spInsertTbProduto(12345678910112, 'Bolinha de Sabão', 100.45, 120);
call spInsertTbProduto(12345678910113, 'Carro Bate', 44.00, 120);
call spInsertTbProduto(12345678910114, 'Bola Furada', 10.00, 120);
call spInsertTbProduto(12345678910115, 'Maçã Laranja', 99.44, 120);
call spInsertTbProduto(12345678910116, 'Boneco do Hitler', 124.00, 200);
call spInsertTbProduto(12345678910117, 'Farinha de Suruí', 50.00, 200);
call spInsertTbProduto(12345678910118, 'Zelador de cemitério', 24.50, 100);

select * from tbproduto;


-- Exercício 6 DML -- 
delimiter $$
create procedure spInsertTbEndereco( vCEP decimal(8,0), vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF varchar(2))
begin
		declare vBairroId int;
        declare vCidadeId int;
        declare vUFId int;
        
        if not exists (select * from tbEndereco where CEP = vCEP) then
        
        if not exists (select * from tbBairro where Bairro = vBairro) then
        insert into tbBairro(Bairro) values (vBairro);
        set vBairroId = (select BairroId from tbBairro where Bairro = vBairro);
        else
			select BairroId into vBairroId from tbBairro where Bairro = vBairro;
end if;

		if not exists (select * from tbCidade where Cidade = vCidade) then
        insert into tbCidade(Cidade) values (vCidade);
        set vCidadeId = (select CidadeId from tbCidade where Cidade = vCidade);
        else 
			select CidadeId into vCidadeId from tbCidade where Cidade = vCidade;
end if;

		if not exists (select * from tbestado where UF = vUF) then
        insert into tbestado(UF) values (vUF);
        set vUFId = (select UFId from tbestado where UF = vUF);
        else 
			select UFId into vUFId from tbestado where UF = vUF;
end if;

insert into tbendereco(CEP, Logradouro, BairroId, CidadeId, UFId) values(vCEP, vLogradouro, vBairroId, vCidadeId, vUFId);
end if;
end $$

call spInsertTbEndereco(12345050, 'Rua da Federal', 'Lapa', 'São Paulo','SP');
call spInsertTbEndereco(12345051, 'Av Brasil', 'Lapa', 'Campinas','SP');
call spInsertTbEndereco(12345052, 'Rua Liberdade', 'Consolação', 'São Paulo','SP');
call spInsertTbEndereco(12345053, 'Av Paulista', 'Penha', 'Rio de Janeiro','RJ');
call spInsertTbEndereco(12345054, 'Rua Ximbú', 'Penha', 'Rio de Janeiro','RJ');
call spInsertTbEndereco(12345055, 'Rua Piu XI', 'Penha', 'Campinas','SP');
call spInsertTbEndereco(12345056, 'Rua Chocolate', 'Aclimação', 'Barra Mansa','RJ');
call spInsertTbEndereco(12345057, 'Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa','RS');

select * from tbEndereco;


-- exercício 7 

Delimiter $$ 
create procedure spInsertClientePF(vNomeCli varchar(200), vNumEnd decimal(6,0), vCompEnd varchar(50),  vCEP decimal (8,0),  vCPF decimal(11,0),  vRG decimal(9,0), vRG_Dig char(1),  vNasc char(10),  vLogradouro varchar (200),  vBairro varchar(200), vCidade varchar (200), vUF char (2)) 
  
begin
  
  
 if not exists (select*from tbEndereco where CEP=VCEP) then  
       if not exists (select * from tbBairro where Bairro = vBairro) then 
       insert into tbBairro (Bairro) values (vBairro); 
           end if ; 
  
       if not exists  (select * from tbCidade where Cidade = vCidade) then 
       insert into tbCidade (Cidade) values (vCidade); 
            end if; 
  
       if not exists (select * from tbEstado where UF = vUF) then 
           insert into tbEstado (UF) values (vUF); 
           end if ; 
  
        insert into tbEndereco (Logradouro, BairroId, CidadeId, UFId, CEP) 
        values (vLogradouro,(select BairroId from tbBairro where Bairro = vBairro), 
        (select CidadeId from tbCidade where Cidade = vCidade), 
        (select UfId from tbEstado where UF = vUF), vCEP); 
 end if; 
  
                  if not exists (select CPF from tbCliente_pf where CPF = vCPF) then 
                          insert into tbcliente (NomeCli, NumEnd, CompEnd, CEP) 
                         values (vNomeCli, vNumEnd, vCompEnd, (select CEP from tbEndereco where CEP = vCEP)); 
  
                                 insert into tbCliente_pf (Id, CPF, RG, RG_Dig, Nasc) 
                                 values ((select id from tbcliente where NomeCli = vNomeCli and NumEnd = vNumEnd),  
                 vCPF, vRG, vRG_Dig, str_to_date( vNasc,'%d/%m/%Y')); 
  
        end if; 
  
 end$$
  
  
 call spInsertClientePF('Pimpão', 325, null, 12345051, 12345678911, 12345678, '0', '12/10/2000', 'Av Brasil', 'Lapa', 'Campinas', 'SP'); 
 call spInsertClientePF('Disney Chaplin', 89, 'Ap. 12', 12345053, 12345678912, 12345679, '0', '21/11/2001', 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ'); 
 call spInsertClientePF('Marciano', 744, null, 12345054, 12345678913, 12345680, '0', '01/06/2001', 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ'); 
 call spInsertClientePF('Lança Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', '05/04/2004', 'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT'); 
 call spInsertClientePF('Remédio Amargo', 2585, null, 12345058, 12345678915, 12345682, '0', '15/07/2002', 'Av Nova', 'Jardim Santa Isabel', 'Cuiabá', 'MT'); 

select * from tbEndereco;

select * from tbCliente;
select * from tbCliente_pf;

-- exercício 8 --

Delimiter $$ 
create procedure spInsertClientePJ(vNomeCli varchar(200),vCNPJ decimal (14,0), vIE decimal (11,0), vCEP decimal (8,0), vLogradouro varchar (200), vNumEnd decimal(6,0), vCompEnd varchar(50), vBairro varchar(200), vCidade varchar (200), vUF char (2)) 
  
 Begin 
  declare vId int;
  set vId = (select min(Id) from tbCliente);
  
 if not exists (select CEP from tbEndereco where CEP = vCEP) then  
       if not exists (select Bairro from tbBairro where Bairro = vBairro) then 
       insert into tbBairro (Bairro) values (vBairro); 
           end if ; 
  
       if not exists  (select CidadeID from tbCidade where Cidade = vCidade) then 
       insert into tbCidade (Cidade) values (vCidade); 
            end if; 
  
       if not exists (select UFId from tbEstado where UF = vUF) then 
           insert into tbEstado (UF) values (vUF); 
           end if ; 
  
        insert into tbEndereco (Logradouro, BairroId, CidadeId, UFId, CEP) 
        values (vLogradouro,(select BairroId from tbBairro where Bairro = vBairro), 
        (select CidadeId from tbCidade where Cidade = vCidade), 
        (select UfId from tbEstado where UF = vUF), vCEP); 
 end if; 
  
                  if not exists (select CNPJ from tbCliente_pj where CNPJ = vCNPJ) then 
                          insert into tbcliente (NomeCli, NumEnd, CompEnd, CEP) 
                         values (vNomeCli, vNumEnd, vCompEnd, (select CEP from tbEndereco where CEP = vCEP)); 
  
                                 insert into tbCliente_pJ (Id, CNPJ, IE) 
                                 values ((select id from tbcliente where NomeCli = vNomeCli and NumEnd = vNumEnd),  
                 vCNPJ, vIE); 
  
        end if; 
  
 end$$ 

call spInsertClientePJ('Paganada',12345678912345,98765432198,12345051,'Av. Brasil',159,null,'Lapa','Campinas','SP');
call spInsertClientePJ('Caloteando',12345678912346,98765432199,12345053,'Av. Paulista',69,null,'Penha','Rio de Janeiro','RJ');
call spInsertClientePJ('Semgrana',12345678912347,98765432100,12345060,'Rua dos Amores',189,null,'Sei lá','Recife','PE');
call spInsertClientePJ('Cemreais',12345678912348,98765432101,12345060,'Rua dos Amores',5024,'Sala 23','Sei lá','Recife','PE');
call spInsertClientePJ('Durango',12345678912349,98765432102,12345060,'Rua dos Amores',1254,null,'Sei lá','Recife','PE');
select * from tbEndereco;

select * from tbCliente;
select * from tbCliente_pj;
drop procedure spInsertClientePJ;

-- exercício 9

delimiter $$
create procedure spInsertCompras(vNotaFiscal int, vNome varchar (200), vDataCompra varchar(10), vCodigoBarras decimal (14,0), vValorItem decimal (8,2), vQtd int, vQtdTotal int, vValorTotal decimal(8,2)) 
begin
    if not exists (select * from tbFornecedor where Nome = vNome) then
        insert into tbFornecedor (Nome) values (vNome);
        set vNome = (select Nome from tbfornecedor where Nome= vNome);
        else
        select Nome into vNome from tbfornecedor where Nome = vNome;
    end if;
    
    if not exists (select Codigo from tbFornecedor ) then
		insert into tbFornecedor (Codigo, CNPJ, Nome, Telefone)
        values (vCodigo);
	end if;

    if not exists (select * from tbCompra where NotaFiscal = vNotaFiscal) then
        insert into tbCompra (NotaFiscal, DataCompra, ValorTotal, QtdTotal)
        values (vNotaFiscal, str_to_date(vDataCompra, '%d/%m/%Y'), vValorTotal, vQtdTotal);
        set vNotaFiscal = (select NotaFiscal from tbCompra where NotaFiscal= vNotaFiscal);
        else
        select NotaFiscal into vNotaFiscal from tbCompra where NotaFiscal = vNotaFiscal;
    end if;

    if not exists (select * from tbItem_Compra where CodigoBarras = vCodigoBarras) then
        insert into tbItem_Compra (NotaFiscal, CodigoBarras, ValorItem, Qtd) 
        values (vNotaFiscal, vCodigoBarras, vValorItem, vQtd);
			set vCodigoBarras = (select CodigoBarras from tbItem_Compra where CodigoBarras= vCodigoBarras);
				else 
					select CodigoBarras into vCodigoBarras from tbItem_Compra where CodigoBarras = vCodigoBarras;
	end if;
end $$

call spInsertCompras(8459, 'Amoroso e Doce','01/05/2018',12345678910111, 22.22, 200, 700, 21944.00);
call spInsertCompras(2482, 'Revenda Chico Loco','22/04/2020',12345678910112, 40.50, 180, 180,  7290.00 );
call spInsertCompras(21563, 'Marcelo Dedal','12/07/2020', 12345678910113,  3.00, 300, 300, 900.00);
call spInsertCompras(8459, 'Amoroso e Doce','04/12/2020', 12345678910114,  35.00, 500, 700, 21944.00);
call spInsertCompras(156354 , 'Revenda Chico Loco','23/11/2021', 12345678910115,  54.00, 350, 350, 18900.00);

select * from tbfornecedor;
select * from tbCompra;
select * from tbItem_compra;
drop procedure spInsertCompras;

-- Exercicio 10 DML --
-- arrumar--
delimiter $$
create procedure spInsertVendas(vNumeroVenda int, vCodigoBarras decimal(14,0), vQtd int, vValorItem decimal (8,2), vNomeCli varchar(200))
begin
    declare vId_Cli int;
    set vId_Cli = (select Id_Cli from tbcliente where NomeCli = vNomeCli);
    
 if exists (select Id_Cli from tbcliente where NomeCli = vNomeCli) then
	insert into tbVenda(NumeroVenda, DataVenda, TotalVenda, Id_Cli) values (vNumeroVenda, DataVenda, vTotalVenda, vId_Cli);
end if;

 if exists (select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras) then
  insert into tbItem_Venda(Qtd, ValorItem, CodigoBarras, NumeroVenda) values (vQtd, vValorItem, vCodigoBarras, vNumeroVenda);
  set vCodigoBarras = (select CodigoBarras from tbItem_Venda where CodigoBarras = vCodigoBarras);
end if;
end $$

call spInsertVendas(null,current_date(), 54.61, 12345678910111, 1 , 54.61, 'Pimpão');
call spInsertVendas(null,current_date(), 200.90, 12345678910112, 2 , 100.45, 'Lança Perfume');
call spInsertVendas(null,current_date(), 44.00, 12345678910113, 2 , 44.00, 'Pimpão');

select * from tbVenda;
select * from tbItem_Venda;
drop procedure spInsertVendas

-- Exercicio 11 DML --

delimiter $$
create procedure spNotaFiscalInsert (vNF int, vCliente varchar(200))
begin
declare vTotalNota decimal(8,2);
set vTotalNota = (select sum(TotalVenda) from tbVenda where Id_Cli = (select Id from tbCliente where NomeCli = vCliente));
insert into tbNota_Fiscal(NF, TotalNota, DataEmissao) values(vNF, vTotalNota, current_date());
End $$;

call spNotaFiscalInsert (359, 'Pimpão', '05-09-2022')
call spNotaFiscalInsert (360, 'Lança Perfume', '05-09-2022')
-- Exercicio 12 DML --
call spInsertTbProduto (12345678910130, 'Camiseta de Poliéster', 35.61, 100);
call spInsertTbProduto (12345678910131, 'Blusa Frio Moletom', 200.00, 100);
call spInsertTbProduto (12345678910132, 'Vestido Decote Redondo', 144.00, 50);

select * from TbProduto;

-- Exercicio 13 DML -- 
delimiter $$
create procedure spDeleteTbProduto(vCodigoBarras decimal(14,0))
begin

delete from TbProduto Where CodigoBarras = vCodigoBarras;
end $$

call spDeleteTbProduto (12345678910116);
call spDeleteTbProduto (12345678910117);
select * from TbProduto;

set sql_safe_updates=0;


-- Exercicio 14 DML -- 
delimiter $$
create procedure spUpdateTbProduto(vValor decimal (8,2), vCodigoBarras decimal(14,0))
begin

update TbProduto set Valor = vValor where CodigoBarras = vCodigoBarras;
update TbProduto set Valor = vValor where CodigoBarras = vCodigoBarras;
update TbProduto set Valor = vValor where CodigoBarras = vCodigoBarras;

end $$

call spUpdateTbProduto(64.50, '12345678910111');
call spUpdateTbProduto(120.00, '12345678910112');
call spUpdateTbProduto(64.00, '12345678910113');
select * from TbProduto;


-- Exercicio 15 DML --
delimiter $$
create procedure spSelectTbProduto()
begin
	select * from TbProduto;
    
end $$

call spSelectTbProduto;


-- Exercicio 16 DML --
delimiter $$
create procedure spCreateLikeTbProd()
begin
	CREATE TABLE tb_ProdutoHistorico like tbProduto;
end $$ 

call spCreateLikeTbProd;

describe tb_ProdutoHistorico;

-- Exercicio 17 DML --
alter table tb_ProdutoHistorico add Ocorrencia varchar(20);
alter table tb_ProdutoHistorico add Atualizacao datetime;

-- Exercicio 18 DML --
alter table tb_ProdutoHistorico modify CodigoBarras decimal(14,0) not null;
alter table tb_ProdutoHistorico drop primary key;
alter table tb_ProdutoHistorico add constraint CodigoBarras primary key (CodigoBarras,ocorrencia,atualizacao);

-- Exercicio 19 DML --
delimiter $$ 
create trigger trg_insertTbProdHist after insert on TbProduto 
	for each row
begin
	insert into tb_ProdutoHistorico
    set CodigoBarras = NEW.CodigoBarras,
    Nome = NEW.Nome,
    Valor = NEW.Valor,
    Qtd = NEW.Qtd,
	Ocorrencia = "Novo",
    Atualizacao = current_timestamp();
END;
$$

call spInsertTbProduto (12345678910119, 'Agua Mineral', 1.99, 500);
select * from tb_ProdutoHistorico;
select * from TbProduto;
drop trigger trg_insertTbProdHist;

-- Exercicio 20 --
delimiter $$ 
create trigger trg_insertTbProdHistStatus after update on TbProduto 
	for each row
begin
	insert into tb_ProdutoHistorico
    set CodigoBarras = NEW.CodigoBarras,
		Nome = NEW.Nome,
		Valor = NEW.Valor,
		Qtd = NEW.Qtd,
		Ocorrencia = "Atualizado",
		Atualizacao = current_timestamp();
    insert into tb_ProdutoHistorico
    set CodigoBarras = Old.CodigoBarras,
		Nome = Old.Nome,
		Valor = Old.Valor,
		Qtd = Old.Qtd,
		Ocorrencia = "Novo",
		Atualizacao = current_timestamp();
END;
$$

update TbProduto set Valor = 2.99 where CodigoBarras = 12345678910119;
select * from tb_ProdutoHistorico;
select * from TbProduto;