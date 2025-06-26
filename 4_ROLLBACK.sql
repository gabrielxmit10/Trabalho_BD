USE VacinacaoDB;
GO

-- 1. ANTES: Qt_Doses Original
SELECT Cd_Lote, Qt_Doses FROM dbo.Lote WHERE Cd_Lote = 'LOT-CVF01';
GO

BEGIN TRANSACTION;

    UPDATE dbo.Lote
    SET Qt_Doses = 999
    WHERE Cd_Lote = 'LOT-CVF01';

    -- 2. DURANTE COMMIT: Qt_Doses nova
    SELECT Cd_Lote, Qt_Doses FROM dbo.Lote WHERE Cd_Lote = 'LOT-CVF01';

ROLLBACK TRANSACTION;
GO

-- 3. DEPOIS: Qt_Doses após Rollback (original)
SELECT Cd_Lote, Qt_Doses FROM dbo.Lote WHERE Cd_Lote = 'LOT-CVF01';
GO
