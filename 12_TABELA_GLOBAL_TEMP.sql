USE VacinacaoDB;
GO

-- Criando Tabela Temporária Global
SELECT *
INTO ##FabricantesTemp
FROM dbo.Fabricante;
GO

-- Tabela Temporária Global Inicial /
SELECT * FROM ##FabricantesTemp;
GO

-- Insert SÓ na Tabela Temporária
INSERT INTO ##FabricantesTemp (Cd_Fabricante, Nm_Fabricante, CNPJ_Fabricante)
VALUES ('FAB-TEMP', 'Fabricante de Teste', '88888888000188');

-- Conteúdo da Tabela Temporária APÓS A INSERÇÃO: //
SELECT * FROM ##FabricantesTemp;

-- Conteúdo da tabela ORIGINAL (NÃO TEM FAB-TEMP porque tá na Temporária): ///
SELECT * FROM dbo.Fabricante;
GO

DROP TABLE IF EXISTS ##FabricantesTemp;
GO
