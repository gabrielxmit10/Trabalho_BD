USE VacinacaoDB;
GO

SELECT 'Bairro' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Bairro
UNION ALL
SELECT 'Doenca' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Doenca
UNION ALL
SELECT 'Endereco' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Endereco
UNION ALL
SELECT 'Fabricante' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Fabricante
UNION ALL
SELECT 'Lote' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Lote
UNION ALL
SELECT 'Municipio' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Municipio
UNION ALL
SELECT 'Paciente' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Paciente
UNION ALL
SELECT 'Unidade' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Unidade
UNION ALL
SELECT 'Unidade_Federativa' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Unidade_Federativa
UNION ALL
SELECT 'Vacina' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Vacina
UNION ALL
SELECT 'Vacinacao_Registro' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Vacinacao_Registro
UNION ALL
SELECT 'Vacinador' AS Tabela, COUNT(*) AS Cardinalidade FROM dbo.Vacinador
ORDER BY
    Tabela;
GO
