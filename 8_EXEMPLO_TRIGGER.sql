USE VacinacaoDB;
GO

-- 1. ANTES: Ultima Vacinação do PAC-001 (Data NULL)
PRINT '--- Valor ANTES de disparar o TRIGGER ---';
SELECT
    Nm_Paciente,
    Dt_Ultima_Vacinacao 
FROM dbo.Paciente
WHERE Cd_Paciente = 'PAC-001';
GO


BEGIN TRANSACTION;

    PRINT '--- Inserindo um novo registro, o que vai disparar o TRIGGER... ---';
    -- Insert Ativa Trigger
    INSERT INTO dbo.Vacinacao_Registro
        (Cd_Vacinacao, Dt_Vacinacao, Nu_Dose, Cd_Paciente, Cd_Vacinador, Cd_Unidade, Cd_Lote)
    VALUES
        ('REG-TEST', GETDATE(), 3, 'PAC-001', 'VACD-001', 'UNID-CPA', 'LOT-CVF01');

    -- DEPOIS: Após Trigger (Agora)
    SELECT
        Nm_Paciente,
        Dt_Ultima_Vacinacao 
    FROM dbo.Paciente
    WHERE Cd_Paciente = 'PAC-001';


ROLLBACK TRANSACTION;
GO

-- 3. FINAL: Após Rollback (NULL de novo)
--SELECT
--    Nm_Paciente,
--    Dt_Ultima_Vacinacao 
--FROM dbo.Paciente
--WHERE Cd_Paciente = 'PAC-001';
--GO
