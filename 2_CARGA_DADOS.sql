-- Usar o banco de dados correto
USE VacinacaoDB;
GO

----------------------------------------------------------------------
-- 1. DADOS DE LOCALIZAÇÃO
-- Quantidades baseadas no arquivo de exemplo.
----------------------------------------------------------------------

-- Unidade_Federativa (5 ocorrências, incluindo RJ, SP, MG)
INSERT INTO dbo.Unidade_Federativa (Cd_UF, Nm_UF) VALUES
('RJ', 'Rio de Janeiro'),
('SP', 'São Paulo'),
('MG', 'Minas Gerais'),
('SC', 'Santa Catarina'),
('BA', 'Bahia');

-- Municipio (5 ocorrências)
INSERT INTO dbo.Municipio (Cd_Municipio, Nm_Municipio, Cd_UF) VALUES
('MUN-RIO', 'Rio de Janeiro', 'RJ'),
('MUN-SPO', 'São Paulo', 'SP'),
('MUN-BH', 'Belo Horizonte', 'MG'),
('MUN-FLN', 'Florianópolis', 'SC'),
('MUN-SSA', 'Salvador', 'BA');

-- Bairro (5 ocorrências)
INSERT INTO dbo.Bairro (Cd_Bairro, Nm_Bairro, Cd_Municipio) VALUES
('BA-CPA', 'Copacabana', 'MUN-RIO'),
('BA-ITM', 'Itaim Bibi', 'MUN-SPO'),
('BA-SVS', 'Savassi', 'MUN-BH'),
('BA-CNT', 'Centro', 'MUN-FLN'),
('BA-BAR', 'Barra', 'MUN-SSA');

-- Endereco (32 ocorrências)
-- Gerando um volume maior de endereços para dar suporte às outras tabelas.
INSERT INTO dbo.Endereco (Cd_Endereco, Cd_CEP, Nm_Logradouro, Nu_Logradouro, Ds_Complemento, Cd_Bairro) VALUES
-- Endereços no Rio de Janeiro
('END-001', '22050-002', 'Avenida Atlântica', 1702, 'Apto 501', 'BA-CPA'),
('END-002', '22071-000', 'Rua Barata Ribeiro', 500, NULL, 'BA-CPA'),
('END-003', '22020-001', 'Rua Gustavo Sampaio', 80, 'Posto de Saúde', 'BA-CPA'),
('END-004', '22041-011', 'Rua Figueiredo de Magalhães', 219, 'Clínica', 'BA-CPA'),
('END-005', '22080-002', 'Rua Francisco Otaviano', 90, NULL, 'BA-CPA'),
-- Endereços em São Paulo
('END-006', '04538-132', 'Avenida Brigadeiro Faria Lima', 3477, 'Andar 10', 'BA-ITM'),
('END-007', '04543-011', 'Avenida Presidente Juscelino Kubitschek', 2041, 'Torre D', 'BA-ITM'),
('END-008', '04532-060', 'Rua Prof. Atílio Innocenti', 165, 'UBS', 'BA-ITM'),
('END-009', '01449-001', 'Rua Oscar Freire', 700, NULL, 'BA-ITM'),
('END-010', '04547-005', 'Rua Gomes de Carvalho', 1500, 'Apto 202', 'BA-ITM'),
-- Endereços em Belo Horizonte
('END-011', '30112-021', 'Avenida do Contorno', 6000, 'Hospital', 'BA-SVS'),
('END-012', '30130-174', 'Rua da Bahia', 2000, NULL, 'BA-SVS'),
('END-013', '30140-071', 'Rua Pernambuco', 880, 'Apto 303', 'BA-SVS'),
('END-014', '30140-120', 'Rua Inconfidentes', 911, 'Centro Clínico', 'BA-SVS'),
('END-015', '30130-141', 'Rua Alagoas', 550, NULL, 'BA-SVS'),
-- Endereços extras para completar os 32
('END-016', '88015-200', 'Avenida Hercílio Luz', 300, NULL, 'BA-CNT'),
('END-017', '88020-300', 'Rua Esteves Júnior', 150, 'Apto 110', 'BA-CNT'),
('END-018', '40140-090', 'Avenida Sete de Setembro', 3800, 'Apto 101', 'BA-BAR'),
('END-019', '40130-000', 'Avenida Oceânica', 2400, NULL, 'BA-BAR'),
('END-020', '22071-100', 'Rua Siqueira Campos', 43, 'Loja 10', 'BA-CPA'),
('END-021', '04545-000', 'Rua das Fiandeiras', 250, NULL, 'BA-ITM'),
('END-022', '30140-061', 'Rua Tomé de Souza', 830, 'Apto 801', 'BA-SVS'),
('END-023', '88010-001', 'Rua Felipe Schmidt', 10, 'Apto 502', 'BA-CNT'),
('END-024', '40140-130', 'Rua Marquês de Caravelas', 220, NULL, 'BA-BAR'),
('END-025', '22011-001', 'Avenida Nossa Senhora de Copacabana', 100, 'Apto 909', 'BA-CPA'),
('END-026', '04533-010', 'Rua Tabapuã', 81, NULL, 'BA-ITM'),
('END-027', '30140-081', 'Rua Santa Rita Durão', 1000, NULL, 'BA-SVS'),
('END-028', '88015-420', 'Rua Vidal Ramos', 50, NULL, 'BA-CNT'),
('END-029', '40140-000', 'Avenida Princesa Isabel', 10, NULL, 'BA-BAR'),
('END-030', '22070-011', 'Rua Tonelero', 180, NULL, 'BA-CPA'),
('END-031', '04530-001', 'Rua Doutor Renato Paes de Barros', 955, NULL, 'BA-ITM'),
('END-032', '30140-005', 'Praça da Savassi', 20, NULL, 'BA-SVS');

----------------------------------------------------------------------
-- 2. DADOS DE VACINAS, FABRICANTES E LOTES
----------------------------------------------------------------------

-- Fabricante (5 ocorrências)
INSERT INTO dbo.Fabricante (Cd_Fabricante, Nm_Fabricante, CNPJ_Fabricante) VALUES
('FAB-FIO', 'Fiocruz', '33781055000135'),
('FAB-BTN', 'Butantan', '61610534000183'),
('FAB-PFZ', 'Pfizer', '46989728000160'),
('FAB-JNS', 'Janssen', '51780468000187'),
('FAB-AZN', 'AstraZeneca', '00923151000114');

-- Doenca (5 ocorrências)
INSERT INTO dbo.Doenca (Cd_Doenca, Nm_Doenca) VALUES
('DOE-COV', 'COVID-19'),
('DOE-INFLU', 'Influenza'),
('DOE-FAMB', 'Febre Amarela'),
('DOE-HPVC', 'HPV'),
('DOE-DENG', 'Dengue');

-- Vacina (5 ocorrências)
INSERT INTO dbo.Vacina (Cd_Vacina, Nm_Vacina, Cd_Doenca) VALUES
('VAC-CVFIO', 'COVID-19 Fiocruz', 'DOE-COV'),
('VAC-CVBTN', 'CoronaVac', 'DOE-COV'),
('VAC-CVJNS', 'COVID-19 Janssen', 'DOE-COV'),
('VAC-GRIPE', 'Influenza Trivalente', 'DOE-INFLU'),
('VAC-FEBRE', 'Febre Amarela', 'DOE-FAMB');

-- Lote (7 ocorrências)
INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) VALUES
('LOT-CVF01', 'VAC-CVFIO', 'FAB-FIO', '2026-12-31', '2025-01-10', 50),
('LOT-CVB01', 'VAC-CVBTN', 'FAB-BTN', '2026-10-20', '2025-04-15', 25),
('LOT-CVJ01', 'VAC-CVJNS', 'FAB-JNS', '2026-11-01', '2025-11-01', 40),
('LOT-PZ001', 'VAC-CVFIO', 'FAB-PFZ', '2026-12-01', '2025-12-01', 30),
('LOT-AZN01', 'VAC-CVFIO', 'FAB-AZN', '2027-02-28', '2025-11-01', 60),
('LOT-GRP01', 'VAC-GRIPE', 'FAB-BTN', '2026-05-01', '2025-03-10', 50),
('LOT-FAMB1', 'VAC-FEBRE', 'FAB-FIO', '2028-01-01', '2026-06-01', 80);


----------------------------------------------------------------------
-- 3. DADOS DE UNIDADES, PACIENTES E VACINADORES
----------------------------------------------------------------------

-- Unidade (5 ocorrências)
INSERT INTO dbo.Unidade (Cd_Unidade, Nm_Unidade, Cd_Endereco) VALUES
('UNID-CPA', 'Posto de Saúde Copacabana', 'END-003'),
('UNID-ITM', 'UBS Itaim Bibi', 'END-008'),
('UNID-SVS', 'Hospital da Savassi', 'END-011'),
('UNID-CNT', 'Clínica Centro', 'END-016'),
('UNID-BAR', 'UBS Barra', 'END-019');

-- Paciente (5 ocorrências)
INSERT INTO dbo.Paciente (Cd_Paciente, Nm_Paciente, Cd_CPF_Paciente, Dt_Nascimento, Cd_Sexo) VALUES
('PAC-001', 'Maria Silva', '11122233344', '1980-05-15', 'F'),
('PAC-002', 'João Souza', '55566677788', '1990-10-20', 'M'),
('PAC-003', 'Carlos Andrade', '22233344455', '1995-02-25', 'M'),
('PAC-004', 'Ana Beatriz Costa', '88899900011', '2018-08-10', 'F'),
('PAC-005', 'Helena Costa', '12312312312', '1985-11-30', 'F');

-- Vacinador (21 ocorrências)
INSERT INTO dbo.Vacinador (Cd_Vacinador, Nm_Vacinador, Cd_CPF_Vacinador, Cd_Unidade_Trabalho) VALUES
('VACD-001','Fernanda Lima','44455566677','UNID-ITM'),
('VACD-002','Ricardo Souza','77788899900','UNID-SVS'),
('VACD-003','Bruno Alves','10120230344','UNID-CPA'),
('VACD-004','Carolina Lima','20230340455','UNID-ITM'),
('VACD-005','Diego Nogueira','30340450566','UNID-CPA'),
('VACD-006','Elisa Pinto','40450560677','UNID-BAR'),
('VACD-007','Fabiana Rocha','50560670788','UNID-CPA'),
('VACD-008','Gustavo Ribeiro','60670780899','UNID-ITM'),
('VACD-009','Helena Santoro','70780890911','UNID-SVS'),
('VACD-010','Igor Martins','80890910922','UNID-BAR'),
('VACD-011','Juliana Teixeira','90910920933','UNID-CPA'),
('VACD-012','Kléber Viana','01234567890','UNID-ITM'),
('VACD-013','Lúcia Azevedo','12345678900','UNID-SVS'),
('VACD-014','Mário Brandão','23456789011','UNID-BAR'),
('VACD-015','Natália Crespo','34567890122','UNID-CPA'),
('VACD-016','Otávio Campos','55565675788','UNID-ITM'),
('VACD-017','Patrícia Farias','66676786899','UNID-SVS'),
('VACD-018','Rafael Junqueira','77787897911','UNID-CNT'),
('VACD-019','Sofia Siqueira','88898918922','UNID-CNT'),
('VACD-020','Carla Mendes','20000000005','UNID-CPA'),
('VACD-021','Vanessa Gomes','99988877766','UNID-BAR');


----------------------------------------------------------------------
-- 4. DADOS DE REGISTRO DA VACINAÇÃO (13 ocorrências) -- CORRIGIDO
----------------------------------------------------------------------
INSERT INTO dbo.Vacinacao_Registro (Cd_Vacinacao, Dt_Vacinacao, Nu_Dose, Cd_Paciente, Cd_Vacinador, Cd_Unidade, Cd_Lote) VALUES
('REG-00001', CAST('2025-06-07T10:00:00' AS DATETIME), 1, 'PAC-001', 'VACD-003', 'UNID-CPA', 'LOT-CVF01'),
('REG-00002', CAST('2025-07-20T11:00:00' AS DATETIME), 2, 'PAC-001', 'VACD-003', 'UNID-CPA', 'LOT-CVF01'),
('REG-00003', CAST('2025-08-01T14:30:00' AS DATETIME), 1, 'PAC-002', 'VACD-004', 'UNID-ITM', 'LOT-CVB01'),
('REG-00004', CAST('2025-08-05T09:15:00' AS DATETIME), 1, 'PAC-003', 'VACD-002', 'UNID-SVS', 'LOT-GRP01'),
('REG-00005', CAST('2025-09-10T15:00:00' AS DATETIME), 2, 'PAC-002', 'VACD-004', 'UNID-ITM', 'LOT-CVB01'),
('REG-00006', CAST('2025-06-06T16:00:00' AS DATETIME), 1, 'PAC-004', 'VACD-010', 'UNID-BAR', 'LOT-GRP01'),
('REG-00007', CAST('2025-06-07T10:00:00' AS DATETIME), 1, 'PAC-005', 'VACD-003', 'UNID-CPA', 'LOT-CVF01'),
('REG-00008', CAST('2025-10-10T10:30:00' AS DATETIME), 2, 'PAC-005', 'VACD-016', 'UNID-ITM', 'LOT-CVB01'),
('REG-00009', CAST('2025-11-15T11:00:00' AS DATETIME), 3, 'PAC-005', 'VACD-002', 'UNID-SVS', 'LOT-PZ001'),
('REG-00010', CAST('2025-12-20T09:45:00' AS DATETIME), 4, 'PAC-005', 'VACD-018', 'UNID-CNT', 'LOT-CVJ01'),
('REG-00011', CAST('2026-01-25T14:00:00' AS DATETIME), 5, 'PAC-005', 'VACD-010', 'UNID-BAR', 'LOT-AZN01'),
('REG-00012', CAST('2026-02-10T08:30:00' AS DATETIME), 1, 'PAC-002', 'VACD-009', 'UNID-SVS', 'LOT-FAMB1'),
('REG-00013', CAST('2026-02-12T10:00:00' AS DATETIME), 2, 'PAC-004', 'VACD-009', 'UNID-SVS', 'LOT-FAMB1');

GO