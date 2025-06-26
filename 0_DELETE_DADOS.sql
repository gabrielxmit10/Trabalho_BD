-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- Deletar os dados na ordem inversa das dependências
DELETE FROM dbo.Vacinacao_Registro;
DELETE FROM dbo.Lote;
DELETE FROM dbo.Vacina;
DELETE FROM dbo.Doenca;
DELETE FROM dbo.Vacinador;
DELETE FROM dbo.Paciente;
DELETE FROM dbo.Unidade;
DELETE FROM dbo.Fabricante;
DELETE FROM dbo.Endereco;
DELETE FROM dbo.Bairro;
DELETE FROM dbo.Municipio;
DELETE FROM dbo.Unidade_Federativa;
GO

PRINT 'Dados apagados.';