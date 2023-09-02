-- Desafio DIO parte2: Refinando o Banco de Dados ecommerce_v1

-- Criando tabelas


-- TABELA CLIENTE
create table clientes(
	idCliente int not null auto_increment,
    dataNascimento date not null,
    pNome varchar(10) not null,
    nomeMeio char(3),
    sobrenome varchar(20),
    endereco varchar(45),
    primary key (idCliente)
)auto_increment=1





-- TABELA TIPO CLIENTE
create table tipoClientes(
	idTipo int not null auto_increment,
    tipo enum('CPF', 'CNPJ') default 'CPF',
    numero varchar(15) not null,
    primary key (idTipo),
    constraint unique_numero_tipoCliente unique(numero),
    constraint fk_cliente_tipoCliente foreign key (idTipo) references clientes(idCliente)
)auto_increment=1;





-- TABELA PAGAMENTO
create table pagamentos(
	idPagamento int auto_increment not null,	
    tipoPagamento enum('PIX', 'Boleto', 'Cartão', 'Dois Cartões') default 'Cartão',    
    primary key (idPagamento)    
)auto_increment=1;





-- TABELA PRODUTO
create table produtos(
	idProduto int auto_increment primary key,
    nomeProduto varchar(20) not null,
    classificacaoCrianca bool default false,
    categoria enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    descricao varchar(255),
    valor float not null,
    avaliacao float not null default 0,
    dimensoes varchar(10)
)auto_increment=1;





-- TABELA ENTREGAS
create table entregas(
	idEntrega int not null auto_increment,
    statusEntrega enum('Em andamento', 'Em processamento', 'Enviado', 'Entregue') default 'Em processamento',
    codRastreio char(10) not null,
    primary key (idEntrega),
    constraint unique_codRastreio unique(codRastreio)
)auto_increment=1;





-- TABELA PEDIDO
create table pedidos(
	idPedido int auto_increment,
    idPedidoPagamento int not null,
    idPedidoCliente int not null,
    descricao varchar(255),
    frete float default 10,
    primary key (idPedido, idPedidoPagamento, idPedidoCliente),
    constraint fk_pedido_pagamento foreign key (idPedidoPagamento) references pagamentos(idPagamento),
    constraint fk_pedido_entrega foreign key (idPedido) references entregas(idEntrega),
    constraint fk_pedido_cliente foreign key (idPedidoCliente) references clientes(idCliente)
)auto_increment=1;





-- TABELA ESTOQUE 
create table estoquesProdutos(
	idEstoqueProduto int auto_increment primary key,
    quantidade int default 0,
    localidade varchar(45)
)auto_increment=1;





-- TABELA FORNECEDOR
create table fornecedores(
	idFornecedor int auto_increment primary key,
    cnpj char(15) not null,
    razaoSocial varchar(45) not null,
    contato char(11) not null,
    constraint unique_cnpj_fornecedor unique (cnpj),
    constraint unique_razaoSocial_fornecedor unique (razaoSocial)
)auto_increment=1;





-- TABELA VENDEDOR
create table vendedores(
	idVendedor int auto_increment primary key,
    razaoSocial varchar(45) not null,
    cnpj char(15),
    cpf char(11),
    localidade varchar(45),
    nomeFantasia varchar(45),
    constraint unique_razaoSocial_vendedor unique (razaoSocial),
    constraint unique_cnpj_vendedor unique (cnpj),
    constraint unique_cpf_vendedor unique (cpf)
)auto_increment=1;





-- TABELAS DE RELACIONAMENTO M:N

-- TABELA PRODUTO_VENDEDOR
create table produtosVendedores(
	idProdutoVendedorVendedor int,
    idProdutoVendedorProduto int,
    quantidade int default 1,
    primary key (idProdutoVendedorVendedor, idProdutoVendedorProduto),
    constraint fk_produtoVendedor_vendedor foreign key (idProdutoVendedorVendedor) references vendedores(idVendedor),
    constraint fk_produtoVendedor_produto foreign key (idProdutoVendedorProduto) references produtos(idProduto)
);





-- TABELA PRODUTO_PEDIDO
create table produtosPedidos(
	idProdutoPedidoProduto int,
    idProdutoPedidoPedido int,
    quantidade int default 1,
    statusPedido enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idProdutoPedidoProduto, idProdutoPedidoPedido),
    constraint fk_produtoPedido_produto foreign key (idProdutoPedidoProduto) references produtos(idProduto),
    constraint fk_produtoPedido_pedido foreign key (idProdutoPedidoPedido) references pedidos(idPedido)
);





-- TABELA ESTOQUE_LOCALIDADE
create table estoquesLocalidades(
	idEstoqueLocalidadeProduto int,
    idEstoqueLocalidadeEstoque int,
    localidade varchar(45) not null,
    primary key (idEstoqueLocalidadeProduto, idEstoqueLocalidadeEstoque),
    constraint fk_estoqueLocalidade_produto foreign key (idEstoqueLocalidadeProduto) references produtos(idProduto),
    constraint fk_estoqueLocalidade_estoque foreign key (idEstoqueLocalidadeEstoque) references estoquesProdutos(idEstoqueProduto)
);





-- TABELA PRODUTO_FORNECEDOR
create table produtosFornecedores(
	idProdutoFornecedorProduto int,
    idProdutoFornecedorFornecedor int,
    quantidade int not null,
    primary key (idProdutoFornecedorProduto, idProdutoFornecedorFornecedor),
    constraint fk_produtoFornecedor_produto foreign key (idProdutoFornecedorProduto) references produtos(idProduto),
    constraint fk_produtoFornecedor_fornecedor foreign key (idProdutoFornecedorFornecedor) references fornecedores(idFornecedor)
);


show tables;