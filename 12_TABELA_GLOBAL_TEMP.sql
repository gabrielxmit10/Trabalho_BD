USE VacinacaoDB;
GO

-- Criando a Tabela Temporária Global ##FabricantesTemp com dbo.Fabricante
SELECT *
INTO ##FabricantesTemp
FROM dbo.Fabricante;
GO

-- Conteúdo inicial da Tabela Temporária Global:
SELECT * FROM ##FabricantesTemp;
GO


INSERT INTO ##FabricantesTemp (Cd_Fabricante, Nm_Fabricante, CNPJ_Fabricante)
VALUES ('FAB-TEMP', 'Fabricante de Teste', '88888888000188');

-- Conteúdo da tabela temporária APÓS A INSERÇÃO:
SELECT * FROM ##FabricantesTemp;

-- Conteúdo da tabela ORIGINAL dbo.Fabricante (permanece inalterada):
SELECT * FROM dbo.Fabricante;
GO

DROP TABLE IF EXISTS ##FabricantesTemp;
GO

-- Demonstração concluída.