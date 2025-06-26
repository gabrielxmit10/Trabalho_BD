USE VacinacaoDB;
GO

-- 1. Inserir um lote de teste já vencido

IF NOT EXISTS (SELECT 1 FROM dbo.Lote WHERE Cd_Lote = 'LOT-VENC')
BEGIN
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) 
    VALUES ('LOT-VENC', 'VAC-GRIPE', 'FAB-BTN', '2024-05-20', '2023-05-20', 50);
END
GO

-- Conferir o lote inserido
-- SELECT * FROM dbo.Lote WHERE Cd_Lote = 'LOT-VENC';
-- GO


-- Passo 2: Criar a VIEW.
-- Apagamos a VIEW se ela já existir, em seu próprio lote.
DROP VIEW IF EXISTS dbo.vLotesVencidos;
GO -- <== GO ADICIONADO AQUI

PRINT '--- Criando a VIEW dbo.vLotesVencidos... ---';
GO -- <== GO ADICIONADO AQUI para isolar o CREATE VIEW

CREATE VIEW dbo.vLotesVencidos AS
SELECT
    l.Cd_Lote,
    v.Nm_Vacina,
    f.Nm_Fabricante,
    l.Dt_Validade,
    l.Qt_Doses
FROM
    dbo.Lote AS l
JOIN 
    dbo.Vacina AS v ON l.Cd_Vacina = v.Cd_Vacina
JOIN 
    dbo.Fabricante AS f ON l.Cd_Fabricante = f.Cd_Fabricante
WHERE
    l.Dt_Validade < GETDATE();
GO


-- Passo 3: Consultar a VIEW.
PRINT '--- Consultando os dados da VIEW para ver os lotes vencidos. ---';
SELECT * FROM dbo.vLotesVencidos;
GO