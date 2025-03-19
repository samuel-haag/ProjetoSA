-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 06/03/2025 às 00:30
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sa_loja_produtosdelimpeza`
--
DROP DATABASE IF EXISTS `sa_loja_produtosdelimpeza`;
CREATE DATABASE IF NOT EXISTS `sa_loja_produtosdelimpeza` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sa_loja_produtosdelimpeza`;

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `ListarPedidos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarPedidos` ()   BEGIN
    SELECT pedido.id_pedido, pedido.data_pedido, cliente.nome AS nome_cliente, funcionario.nome AS nome_funcionario
    FROM pedido INNER JOIN cliente INNER JOIN funcionario ON pedido.cliente_cod_cliente = cliente.cod_cliente AND pedido.funcionario_id_funcionario = funcionario.id_funcionario;
END$$

DROP PROCEDURE IF EXISTS `mySp_clienterInsert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_clienterInsert` (IN `v_nome` VARCHAR(45), IN `v_email` VARCHAR(45), IN `v_telefone` VARCHAR(15), IN `v_endereco` VARCHAR(45), IN `v_cpf` VARCHAR(50), IN `v_cnpj` VARCHAR(50))   BEGIN
IF ((v_nome != '') && (v_telefone != '') && (v_telefone != '') && (v_endereco!= '') && (v_email!= '') && (v_cpf!= '') && (v_cnpj!= '')) THEN
INSERT INTO cliente
(nome, email, telefone, endereco, cpf, cnpj)
VALUES
(v_nome,v_email,v_telefone,v_endereco,v_cpf,v_cnpj);
ELSE
SELECT 'Nome, Email, Telefone, Endereco, Cpf e Cnpj devem ser fornecidos para o cadastro!'
AS Msg;
END IF;
END$$

DROP PROCEDURE IF EXISTS `mySp_funcionarioUpdate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_funcionarioUpdate` (IN `v_id_funcionario` INT, IN `v_nome` VARCHAR(50), IN `v_sal_fixo` DECIMAL(10,2), IN `v_comissao` DECIMAL(10,2), IN `v_cargo` VARCHAR(45))   BEGIN
IF (((v_id_funcionario > 0) && (v_id_funcionario != '') ) && (v_nome != '') &&
(v_sal_fixo != '') && (v_comissao != '') &&
(v_cargo != '')) THEN
UPDATE funcionario SET nome =v_nome,
sal_fixo=v_sal_fixo,
comissao =v_comissao,
cargo =v_cargo
WHERE id_funcionario =v_id_funcionario;
ELSE
SELECT 'O novos Nome, Salário Fixo, Comissão, Cargo devem ser informados!'
AS Msg;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `cod_cliente` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave primaria da tabela cliente',
  `nome` varchar(45) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados do nome do cliente',
  `email` varchar(45) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados do email do cliente',
  `telefone` varchar(15) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados do telefone do cliente',
  `endereco` varchar(45) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados do endereço do cliente',
  `cpf` varchar(50) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados do CPF do cliente',
  `cnpj` varchar(50) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados do CNPJ do cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`cod_cliente`, `nome`, `email`, `telefone`, `endereco`, `cpf`, `cnpj`) VALUES
(0, 'Adriano Raulseixas', 'Didico157@email.com', '47999226927', 'Rua Tchurusbango, 244', 'NULL', '122.153.367-00'),
(1, 'João Silva', 'joao.silva@email.com', '11987654321', 'Rua A, 123', '987.654.321-00', NULL),
(2, 'Maria Oliveira', 'maria.oliveira@email.com', '11976543210', 'Rua B, 456', NULL, '12.345.678/0001-00'),
(3, 'Carlos Mendes', 'carlos.mendes@email.com', '11965432109', 'Rua C, 789', '321.654.987-00', NULL),
(4, 'Fernanda Souza', 'fernanda.souza@email.com', '11999887766', 'Rua D, 321', NULL, '98.765.432/0001-00'),
(5, 'Rafael Lima', 'rafael.lima@email.com', '11988776655', 'Rua E, 654', '741.852.963-00', NULL),
(6, 'Beatriz Martins', 'beatriz.martins@email.com', '11977665544', 'Rua F, 987', NULL, '74.852.963/0001-00'),
(7, 'Lucas Pereira', 'lucas.pereira@email.com', '11966554433', 'Rua G, 111', '369.258.147-00', NULL),
(8, 'Amanda Costa', 'amanda.costa@email.com', '11955443322', 'Rua H, 222', NULL, '25.369.147/0001-00'),
(9, 'Gustavo Ribeiro', 'gustavo.ribeiro@email.com', '11944332211', 'Rua I, 333', '258.147.369-00', NULL),
(10, 'Juliana Cardoso', 'juliana.cardoso@email.com', '11933221100', 'Rua J, 444', NULL, '36.914.725/0001-00'),
(11, 'Pedro Henrique', 'pedro.henrique@email.com', '11922110099', 'Rua K, 555', '147.369.852-00', NULL),
(12, 'Carla Nunes', 'carla.nunes@email.com', '11911009988', 'Rua L, 666', NULL, '85.296.374/0001-00'),
(13, 'Ricardo Almeida', 'ricardo.almeida@email.com', '11900998877', 'Rua M, 777', '963.741.852-00', NULL),
(14, 'Tatiane Rocha', 'tatiane.rocha@email.com', '11899887766', 'Rua N, 888', NULL, '15.975.346/0001-00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
CREATE TABLE `fornecedor` (
  `id_fornecedor` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave primária do fornecedor',
  `nome` varchar(45) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados do nome do fornecedor',
  `contato` varchar(45) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados do contato do fornecedor',
  `endereco` varchar(45) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados do endereço do fornecedor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `fornecedor`
--

INSERT INTO `fornecedor` (`id_fornecedor`, `nome`, `contato`, `endereco`) VALUES
(1, 'Limpeza Total', '11955553333', 'Av. Central, 1000'),
(2, 'Higiene Plus', '11944442222', 'Rua das Indústrias, 500'),
(3, 'Brilho Máximo', '11933331111', 'Rua das Fábricas, 250'),
(4, 'Pureza Limpa', '11922229999', 'Av. das Empresas, 400');

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
CREATE TABLE `funcionario` (
  `id_funcionario` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave primária do funcionário',
  `nome` varchar(50) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados do nome do funcionário',
  `cargo` varchar(45) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados do cargo do funcionário',
  `sal_fixo` decimal(10,2) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados do salário fixo do funcionário',
  `comissao` decimal(10,2) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados da comissão do funcionário'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `funcionario`
--

INSERT INTO `funcionario` (`id_funcionario`, `nome`, `cargo`, `sal_fixo`, `comissao`) VALUES
(1, 'Alex Pereira', 'CEO', 100.00, 800.00),
(2, 'Bruno Rocha', 'Vendedor', 2500.00, 300.00),
(3, 'Camila Ferreira', 'Caixa', 2200.00, 250.00),
(4, 'Diego Martins', 'Estoquista', 2100.00, 200.00),
(5, 'Eduarda Lopes', 'Auxiliar', 2000.00, 150.00),
(6, 'Fábio Santos', 'Supervisor', 4000.00, 600.00),
(7, 'Gabriela Silva', 'Atendente', 2300.00, 280.00),
(8, 'Henrique Dias', 'Vendedor', 2500.00, 300.00),
(9, 'Isabela Campos', 'Caixa', 2200.00, 250.00),
(10, 'José Luiz', 'Estoquista', 2100.00, 200.00),
(11, 'Karina Almeida', 'Atendente', 2300.00, 280.00),
(12, 'Leandro Mendes', 'Auxiliar', 2000.00, 150.00),
(13, 'Mariana Costa', 'Gerente', 3500.00, 500.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `item_de_pedido`
--

DROP TABLE IF EXISTS `item_de_pedido`;
CREATE TABLE `item_de_pedido` (
  `produto_cod_produto` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave estrangeira da tabela produto',
  `produto_fornecedor_id_fornecedor` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave estrangeira da tabela produto para o fornecedor',
  `pedido_id_pedido` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave estrangeira da tabela pedido',
  `pedido_cliente_cod_cliente` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave estrangeira da tabela pedido para o cliente',
  `pedido_funcionario_id_funcionario` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave estrangeira da tabela pedido para a funcionário',
  `quantidade` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados da quantidade do item de pedido',
  `preco_unit` decimal(10,2) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados do preço unitário do item de pedido'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `item_de_pedido`
--

INSERT INTO `item_de_pedido` (`produto_cod_produto`, `produto_fornecedor_id_fornecedor`, `pedido_id_pedido`, `pedido_cliente_cod_cliente`, `pedido_funcionario_id_funcionario`, `quantidade`, `preco_unit`) VALUES
(1, 1, 1, 1, 1, 2, 5.50),
(2, 1, 2, 2, 2, 3, 8.00),
(3, 2, 3, 3, 3, 1, 12.00),
(4, 2, 4, 4, 4, 2, 7.50),
(5, 3, 5, 5, 5, 1, 15.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave primária do pedido',
  `data_pedido` varchar(45) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados da data do pedido do pedido',
  `cliente_cod_cliente` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave estrangeira da tabela cliente',
  `funcionario_id_funcionario` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave estrangeira da tabela funcionário'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `data_pedido`, `cliente_cod_cliente`, `funcionario_id_funcionario`) VALUES
(1, '2024-03-01', 1, 1),
(2, '2024-03-02', 2, 2),
(3, '2024-03-03', 3, 3),
(4, '2024-03-04', 4, 4),
(5, '2024-03-05', 5, 5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

DROP TABLE IF EXISTS `produto`;
CREATE TABLE `produto` (
  `cod_produto` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave primária do produto',
  `nome` varchar(50) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados do nome do produto',
  `valor` decimal(10,2) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados do valor do produto',
  `estoque` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar os dados do estoque do produto',
  `descricao` varchar(60) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar os dados da descrição do produto',
  `fornecedor_id_fornecedor` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar a chave estrangeira da tabela fornecedor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`cod_produto`, `nome`, `valor`, `estoque`, `descricao`, `fornecedor_id_fornecedor`) VALUES
(1, 'Detergente Neutro', 5.50, 100, 'Detergente líquido neutro para limpeza geral', 1),
(2, 'Água Sanitária 2L', 8.00, 50, 'Alvejante e desinfetante multiuso', 1),
(3, 'Sabão em Pó 1kg', 12.00, 80, 'Detergente em pó para roupas', 2),
(4, 'Desinfetante Lavanda 500ml', 7.50, 120, 'Desinfetante perfumado para pisos', 2),
(5, 'Álcool em Gel 500ml', 15.00, 70, 'Álcool 70% para higienização', 3),
(6, 'Esponja Multiuso', 3.50, 200, 'Esponja de limpeza para cozinha e banheiro', 3),
(7, 'Limpador Perfumado 1L', 10.00, 90, 'Limpador líquido perfumado para superfícies', 4),
(8, 'Saco de Lixo 30L', 7.00, 150, 'Sacos de lixo resistentes para resíduos', 4),
(9, 'Sabonete Líquido 500ml', 9.00, 110, 'Sabonete hidratante para mãos e corpo', 2),
(10, 'Pano de Chão', 5.00, 130, 'Pano de algodão para limpeza de pisos', 3);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `view_join`
-- (Veja abaixo para a visão atual)
--
DROP VIEW IF EXISTS `view_join`;
CREATE TABLE `view_join` (
`valor` decimal(10,2)
,`nome` varchar(50)
,`quantidade` int(11)
,`preco_unit` decimal(10,2)
,`valor_a_pagar` decimal(20,2)
);

-- --------------------------------------------------------

--
-- Estrutura para view `view_join`
--
DROP TABLE IF EXISTS `view_join`;

DROP VIEW IF EXISTS `view_join`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_join`  AS SELECT `produto`.`valor` AS `valor`, `produto`.`nome` AS `nome`, `item_de_pedido`.`quantidade` AS `quantidade`, `item_de_pedido`.`preco_unit` AS `preco_unit`, `produto`.`valor`* `item_de_pedido`.`quantidade` AS `valor_a_pagar` FROM (`produto` join `item_de_pedido` on(`produto`.`cod_produto` = `item_de_pedido`.`produto_cod_produto`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cod_cliente`);

--
-- Índices de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`id_fornecedor`);

--
-- Índices de tabela `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`id_funcionario`);

--
-- Índices de tabela `item_de_pedido`
--
ALTER TABLE `item_de_pedido`
  ADD PRIMARY KEY (`produto_cod_produto`,`produto_fornecedor_id_fornecedor`,`pedido_id_pedido`,`pedido_cliente_cod_cliente`,`pedido_funcionario_id_funcionario`),
  ADD KEY `fk_produto_has_pedido_pedido1` (`pedido_id_pedido`,`pedido_cliente_cod_cliente`,`pedido_funcionario_id_funcionario`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`,`cliente_cod_cliente`,`funcionario_id_funcionario`),
  ADD KEY `fk_pedido_cliente1` (`cliente_cod_cliente`),
  ADD KEY `fk_pedido_funcionario1` (`funcionario_id_funcionario`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`cod_produto`,`fornecedor_id_fornecedor`),
  ADD KEY `fk_produto_fornecedor` (`fornecedor_id_fornecedor`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `item_de_pedido`
--
ALTER TABLE `item_de_pedido`
  ADD CONSTRAINT `fk_produto_has_pedido_pedido1` FOREIGN KEY (`pedido_id_pedido`,`pedido_cliente_cod_cliente`,`pedido_funcionario_id_funcionario`) REFERENCES `pedido` (`id_pedido`, `cliente_cod_cliente`, `funcionario_id_funcionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_produto_has_pedido_produto1` FOREIGN KEY (`produto_cod_produto`,`produto_fornecedor_id_fornecedor`) REFERENCES `produto` (`cod_produto`, `fornecedor_id_fornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_cliente1` FOREIGN KEY (`cliente_cod_cliente`) REFERENCES `cliente` (`cod_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_funcionario1` FOREIGN KEY (`funcionario_id_funcionario`) REFERENCES `funcionario` (`id_funcionario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_produto_fornecedor` FOREIGN KEY (`fornecedor_id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
