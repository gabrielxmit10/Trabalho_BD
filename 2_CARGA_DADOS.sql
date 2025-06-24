-- Usar o banco de dados correto
USE VacinacaoDB;
GO

----------------------------------------------------------------------
-- 1. DADOS DE LOCALIZAÇÃO
----------------------------------------------------------------------

-- Unidade_Federativa (5 ocorrências)
INSERT INTO dbo.Unidade_Federativa (Cd_UF, Nm_UF) VALUES
('SC', 'Santa Catarina'),
('PR', 'Paraná'),
('PE', 'Pernambuco'),
('AM', 'Amazonas'),
('GO', 'Goiás');

-- Municipio (Pelo menos 1 por UF)
INSERT INTO dbo.Municipio (Cd_Municipio, Nm_Municipio, Cd_UF) VALUES
('MUN-FLN', 'Florianópolis', 'SC'),
('MUN-CWB', 'Curitiba', 'PR'),
('MUN-REC', 'Recife', 'PE'),
('MUN-MAO', 'Manaus', 'AM'),
('MUN-GYN', 'Goiânia', 'GO'),
('MUN-JOI', 'Joinville', 'SC');

-- Bairro (Pelo menos 5 ocorrências)
INSERT INTO dbo.Bairro (Cd_Bairro, Nm_Bairro, Cd_Municipio) VALUES
('BA-TRND', 'Trindade', 'MUN-FLN'),
('BA-AGVD', 'Água Verde', 'MUN-CWB'),
('BA-BVG', 'Boa Viagem', 'MUN-REC'),
('BA-PNTN', 'Ponta Negra', 'MUN-MAO'),
('BA-STBU', 'Setor Bueno', 'MUN-GYN'),
('BA-AMRC', 'América', 'MUN-JOI');

-- Endereco (Pelo menos 5 ocorrências)
INSERT INTO dbo.Endereco (Cd_Endereco, Cd_CEP, Nm_Logradouro, Nu_Logradouro, Ds_Complemento, Cd_Bairro) VALUES
('END-001', '88036-000', 'Rua Lauro Linhares', 1200, 'Bloco A', 'BA-TRND'),
('END-002', '80620-010', 'Avenida República Argentina', 2500, 'Apto 101', 'BA-AGVD'),
('END-003', '51020-000', 'Avenida Boa Viagem', 550, 'Hotel', 'BA-BVG'),
('END-004', '69037-000', 'Avenida Coronel Teixeira', 1320, NULL, 'BA-PNTN'),
('END-005', '74230-030', 'Avenida T-10', 400, 'Sala 50', 'BA-STBU'),
('END-006', '89204-251', 'Rua Max Colin', 1105, NULL, 'BA-AMRC');

----------------------------------------------------------------------
-- 2. DADOS DE VACINAS, FABRICANTES E LOTES
----------------------------------------------------------------------

-- Fabricante (5 ocorrências)
INSERT INTO dbo.Fabricante (Cd_Fabricante, Nm_Fabricante, CNPJ_Fabricante) VALUES
('FAB-GSK', 'GSK', '33247743000104'),
('FAB-SNF', 'Sanofi', '02956406000198'),
('FAB-MRK', 'Merck', '33069212000147'),
('FAB-BHR', 'Bayer', '18459628000115'),
('FAB-CRZ', 'Bio-Manguinhos/Fiocruz', '33781055000135');

-- Doenca (5 ocorrências)
INSERT INTO dbo.Doenca (Cd_Doenca, Nm_Doenca) VALUES
('DOE-HPV', 'Papilomavírus Humano'),
('DOE-DNG', 'Dengue'),
('DOE-GRIP', 'Gripe (Influenza)'),
('DOE-SRMP', 'Sarampo'),
('DOE-MNGB', 'Meningite B');

-- Vacina (Pelo menos 1 por doença)
INSERT INTO dbo.Vacina (Cd_Vacina, Nm_Vacina, Cd_Doenca) VALUES
('VAC-HPV4', 'HPV Quadrivalente', 'DOE-HPV'),
('VAC-DENG', 'Qdenga', 'DOE-DNG'),
('VAC-GRIP4', 'Gripe Tetravalente', 'DOE-GRIP'),
('VAC-TRIP', 'Tríplice Viral (Sarampo)', 'DOE-SRMP'),
('VAC-MENB', 'Bexsero', 'DOE-MNGB');

-- Lote (Pelo menos 5 ocorrências)
INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) VALUES
('LOT-A01B', 'VAC-HPV4', 'FAB-MRK', '2026-10-31', '2024-11-01', 100),
('LOT-C02D', 'VAC-DENG', 'FAB-GSK', '2027-05-20', '2025-05-21', 80),
('LOT-E03F', 'VAC-GRIP4', 'FAB-SNF', '2025-12-15', '2024-06-15', 120),
('LOT-G04H', 'VAC-TRIP', 'FAB-CRZ', '2028-01-01', '2026-01-01', 200),
('LOT-I05J', 'VAC-MENB', 'FAB-GSK', '2026-08-30', '2025-02-28', 50),
('LOT-K06L', 'VAC-GRIP4', 'FAB-SNF', '2026-02-01', '2024-08-01', 150);

----------------------------------------------------------------------
-- 3. DADOS DE PESSOAS E UNIDADES
----------------------------------------------------------------------

-- Unidade (5 ocorrências)
INSERT INTO dbo.Unidade (Cd_Unidade, Nm_Unidade, Cd_Endereco) VALUES
('UNID-TRND', 'Posto de Saúde Trindade', 'END-001'),
('UNID-AGVD', 'Clínica de Vacinação Água Verde', 'END-002'),
('UNID-BVG', 'Hospital Boa Viagem', 'END-003'),
('UNID-PNTN', 'UBS Ponta Negra', 'END-004'),
('UNID-STBU', 'Centro de Saúde Bueno', 'END-005');

-- Paciente (5 ocorrências)
INSERT INTO dbo.Paciente (Cd_Paciente, Nm_Paciente, Cd_CPF_Paciente, Dt_Nascimento, Cd_Sexo) VALUES
('PAC-001', 'Ana Clara Rezende', '11122233344', '1995-03-12', 'F'),
('PAC-002', 'Bruno Carvalho Dias', '22233344455', '1988-07-25', 'M'),
('PAC-003', 'Camila Ferreira Alves', '33344455566', '2001-11-02', 'F'),
('PAC-004', 'Diego Martins Santos', '44455566677', '1974-01-30', 'M'),
('PAC-005', 'Eduarda Lima Guedes', '55566677788', '2010-09-15', 'F');

-- Vacinador (5 ocorrências)
INSERT INTO dbo.Vacinador (Cd_Vacinador, Nm_Vacinador, Cd_CPF_Vacinador, Cd_Unidade_Trabalho) VALUES
('VACD-001', 'Fernanda Oliveira', '66677788899', 'UNID-TRND'),
('VACD-002', 'Gustavo Pereira', '77788899900', 'UNID-AGVD'),
('VACD-003', 'Heloísa Costa', '88899900011', 'UNID-BVG'),
('VACD-004', 'Igor Azevedo', '99900011122', 'UNID-PNTN'),
('VACD-005', 'Juliana Barbosa', '00011122233', 'UNID-STBU');

----------------------------------------------------------------------
-- 4. DADOS DE REGISTRO DA VACINAÇÃO
----------------------------------------------------------------------
INSERT INTO dbo.Vacinacao_Registro (Cd_Vacinacao, Dt_Vacinacao, Nu_Dose, Cd_Paciente, Cd_Vacinador, Cd_Unidade, Cd_Lote) VALUES
('REG-00001', '2025-06-10 10:30:00', 1, 'PAC-001', 'VACD-001', 'UNID-TRND', 'LOT-A01B'),
('REG-00002', '2025-06-15 11:00:00', 1, 'PAC-002', 'VACD-002', 'UNID-AGVD', 'LOT-E03F'),
('REG-00003', '2025-06-20 14:00:00', 1, 'PAC-003', 'VACD-003', 'UNID-BVG', 'LOT-C02D'),
('REG-00004', '2025-06-25 09:15:00', 1, 'PAC-005', 'VACD-001', 'UNID-TRND', 'LOT-I05J'),
('REG-00005', '2025-07-01 16:00:00', 2, 'PAC-001', 'VACD-001', 'UNID-TRND', 'LOT-A01B'),
('REG-00006', '2025-07-10 08:45:00', 1, 'PAC-004', 'VACD-005', 'UNID-STBU', 'LOT-G04H'),
('REG-00007', '2025-07-15 13:20:00', 2, 'PAC-002', 'VACD-002', 'UNID-AGVD', 'LOT-K06L');

GO
