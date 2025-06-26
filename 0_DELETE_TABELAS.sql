-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- Apagando as tabelas na ordem correta para respeitar as chaves estrangeiras.
-- Tabelas com mais dependências são apagadas primeiro.

DROP TABLE IF EXISTS dbo.Vacinacao_Registro;
DROP TABLE IF EXISTS dbo.Lote;
DROP TABLE IF EXISTS dbo.Vacina;
DROP TABLE IF EXISTS dbo.Doenca;
DROP TABLE IF EXISTS dbo.Vacinador;
DROP TABLE IF EXISTS dbo.Paciente;
DROP TABLE IF EXISTS dbo.Unidade;
DROP TABLE IF EXISTS dbo.Fabricante;
DROP TABLE IF EXISTS dbo.Endereco;
DROP TABLE IF EXISTS dbo.Bairro;
DROP TABLE IF EXISTS dbo.Municipio;
DROP TABLE IF EXISTS dbo.Unidade_Federativa;

GO

PRINT 'Tabelas apagadas.';