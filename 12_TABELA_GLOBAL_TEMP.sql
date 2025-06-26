USE VacinacaoDB;
GO

-- Criando a Tabela Tempor�ria Global ##FabricantesTemp com dbo.Fabricante
SELECT *
INTO ##FabricantesTemp
FROM dbo.Fabricante;
GO

-- Conte�do inicial da Tabela Tempor�ria Global:
SELECT * FROM ##FabricantesTemp;
GO


INSERT INTO ##FabricantesTemp (Cd_Fabricante, Nm_Fabricante, CNPJ_Fabricante)
VALUES ('FAB-TEMP', 'Fabricante de Teste', '88888888000188');

-- Conte�do da tabela tempor�ria AP�S A INSER��O:
SELECT * FROM ##FabricantesTemp;

-- Conte�do da tabela ORIGINAL dbo.Fabricante (permanece inalterada):
SELECT * FROM dbo.Fabricante;
GO

DROP TABLE IF EXISTS ##FabricantesTemp;
GO

-- Demonstra��o conclu�da.