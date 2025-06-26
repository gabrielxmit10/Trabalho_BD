USE VacinacaoDB;
GO

-- 1. Insert dum Lote já VENCIDO

IF NOT EXISTS (SELECT 1 FROM dbo.Lote WHERE Cd_Lote = 'LOT-VENC')
BEGIN
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) 
    VALUES ('LOT-VENC', 'VAC-GRIPE', 'FAB-BTN', '2024-05-20', '2023-05-20', 50);
END
GO

-- Conferir Lote do Insert
-- SELECT * FROM dbo.Lote WHERE Cd_Lote = 'LOT-VENC';
-- GO



DROP VIEW IF EXISTS dbo.vLotesVencidos;
GO


-- 2. Criar  VIEW (dbo.vLotesVencidos)
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
    l.Dt_Validade < GETDATE(); -- Validade Antes de AGORA
GO


-- 3. Ver VIEW de Lotes Vencidos
SELECT * FROM dbo.vLotesVencidos;
GO
