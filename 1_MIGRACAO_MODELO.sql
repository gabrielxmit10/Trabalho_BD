-- CREATE DATABASE VacinacaoDB;
-- GO

USE VacinacaoDB;
GO


CREATE TABLE dbo.Unidade_Federativa (
    Cd_UF CHAR(2) PRIMARY KEY, -- Ex: 'RJ', 'SP'
    Nm_UF CHAR(50) NOT NULL
);

CREATE TABLE dbo.Municipio (
    Cd_Municipio CHAR(10) PRIMARY KEY,
    Nm_Municipio CHAR(100) NOT NULL,
    Cd_UF CHAR(2) NOT NULL,
    CONSTRAINT FK_Municipio_Unidade_Federativa FOREIGN KEY (Cd_UF) REFERENCES dbo.Unidade_Federativa(Cd_UF)
);
CREATE INDEX IDX_Municipio_Cd_UF ON dbo.Municipio(Cd_UF);

CREATE TABLE dbo.Bairro (
    Cd_Bairro CHAR(10) PRIMARY KEY,
    Nm_Bairro CHAR(100) NOT NULL,
    Cd_Municipio CHAR(10) NOT NULL,
    CONSTRAINT FK_Bairro_Municipio FOREIGN KEY (Cd_Municipio) REFERENCES dbo.Municipio(Cd_Municipio)
);
CREATE INDEX IDX_Bairro_Cd_Municipio ON dbo.Bairro(Cd_Municipio);

CREATE TABLE dbo.Endereco (
    Cd_Endereco CHAR(10) PRIMARY KEY, -- Ex: 'END-001'
    Cd_CEP CHAR(9) NOT NULL,
    Nm_Logradouro CHAR(150) NOT NULL,
    Nu_Logradouro INT NOT NULL,
    Ds_Complemento CHAR(50),
    Cd_Bairro CHAR(10) NOT NULL,
    CONSTRAINT FK_Endereco_Bairro FOREIGN KEY (Cd_Bairro) REFERENCES dbo.Bairro(Cd_Bairro)
);
CREATE INDEX IDX_Endereco_Cd_Bairro ON dbo.Endereco(Cd_Bairro);

CREATE TABLE dbo.Paciente (
    Cd_Paciente CHAR(10) PRIMARY KEY, -- Ex: 'PAC-001'
    Nm_Paciente CHAR(150) NOT NULL,
    Cd_CPF_Paciente CHAR(11) NOT NULL UNIQUE,
    Dt_Nascimento DATE NOT NULL,
    Cd_Sexo CHAR(1)
);

CREATE TABLE dbo.Unidade (
    Cd_Unidade CHAR(10) PRIMARY KEY, -- Ex: 'UNID-01'
    Nm_Unidade CHAR(100) NOT NULL,
    Cd_Endereco CHAR(10) NOT NULL,
    CONSTRAINT FK_Unidade_Endereco FOREIGN KEY (Cd_Endereco) REFERENCES dbo.Endereco(Cd_Endereco)
);
CREATE INDEX IDX_Unidade_Cd_Endereco ON dbo.Unidade(Cd_Endereco);

CREATE TABLE dbo.Vacinador (
    Cd_Vacinador CHAR(10) PRIMARY KEY, -- Ex: 'VAC-001'
    Nm_Vacinador CHAR(150) NOT NULL,
    Cd_CPF_Vacinador CHAR(11) NOT NULL UNIQUE,
    Cd_Unidade_Trabalho CHAR(10) NOT NULL,
    CONSTRAINT FK_Vacinador_Unidade FOREIGN KEY (Cd_Unidade_Trabalho) REFERENCES dbo.Unidade(Cd_Unidade)
);
CREATE INDEX IDX_Vacinador_Cd_Unidade_Trabalho ON dbo.Vacinador(Cd_Unidade_Trabalho);

CREATE TABLE dbo.Fabricante (
    Cd_Fabricante CHAR(10) PRIMARY KEY, -- Ex: 'FAB-01'
    Nm_Fabricante CHAR(100) NOT NULL,
    CNPJ_Fabricante CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE dbo.Doenca (
    Cd_Doenca CHAR(10) PRIMARY KEY, -- Ex: 'DOENCA-01'
    Nm_Doenca CHAR(100) NOT NULL
);

CREATE TABLE dbo.Vacina (
    Cd_Vacina CHAR(10) PRIMARY KEY, -- Ex: 'VACINA-01'
    Nm_Vacina CHAR(100) NOT NULL,
    Cd_Doenca CHAR(10) NOT NULL,
    CONSTRAINT FK_Vacina_Doenca FOREIGN KEY (Cd_Doenca) REFERENCES dbo.Doenca(Cd_Doenca)
);
CREATE INDEX IDX_Vacina_Cd_Doenca ON dbo.Vacina(Cd_Doenca);

CREATE TABLE dbo.Lote (
    Cd_Lote CHAR(10) PRIMARY KEY, -- Ex: 'LOTE-XYZ'
    Cd_Vacina CHAR(10) NOT NULL,
    Cd_Fabricante CHAR(10) NOT NULL,
    Dt_Validade DATE NOT NULL,
    Dt_Fabricacao DATE NOT NULL,
    Qt_Doses INT NOT NULL,
    CONSTRAINT FK_Lote_Vacina FOREIGN KEY (Cd_Vacina) REFERENCES dbo.Vacina(Cd_Vacina),
    CONSTRAINT FK_Lote_Fabricante FOREIGN KEY (Cd_Fabricante) REFERENCES dbo.Fabricante(Cd_Fabricante)
);
CREATE INDEX IDX_Lote_Cd_Vacina ON dbo.Lote(Cd_Vacina);
CREATE INDEX IDX_Lote_Cd_Fabricante ON dbo.Lote(Cd_Fabricante);

CREATE TABLE dbo.Vacinacao_Registro (
    Cd_Vacinacao CHAR(10) PRIMARY KEY, -- Ex: 'REG-001'
    Dt_Vacinacao DATETIME NOT NULL,
    Nu_Dose INT NOT NULL,
    Cd_Paciente CHAR(10) NOT NULL,
    Cd_Vacinador CHAR(10) NOT NULL,
    Cd_Unidade CHAR(10) NOT NULL,
    Cd_Lote CHAR(10) NOT NULL,
    CONSTRAINT FK_Registro_Paciente FOREIGN KEY (Cd_Paciente) REFERENCES dbo.Paciente(Cd_Paciente),
    CONSTRAINT FK_Registro_Vacinador FOREIGN KEY (Cd_Vacinador) REFERENCES dbo.Vacinador(Cd_Vacinador),
    CONSTRAINT FK_Registro_Unidade FOREIGN KEY (Cd_Unidade) REFERENCES dbo.Unidade(Cd_Unidade),
    CONSTRAINT FK_Registro_Lote FOREIGN KEY (Cd_Lote) REFERENCES dbo.Lote(Cd_Lote)
);
CREATE INDEX IDX_Registro_Cd_Paciente ON dbo.Vacinacao_Registro(Cd_Paciente);
CREATE INDEX IDX_Registro_Cd_Vacinador ON dbo.Vacinacao_Registro(Cd_Vacinador);
CREATE INDEX IDX_Registro_Cd_Unidade ON dbo.Vacinacao_Registro(Cd_Unidade);
CREATE INDEX IDX_Registro_Cd_Lote ON dbo.Vacinacao_Registro(Cd_Lote);

GO
