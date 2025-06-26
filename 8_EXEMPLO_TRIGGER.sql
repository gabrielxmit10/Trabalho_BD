-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- 1. ANTES: Verificando o estado inicial do paciente 'PAC-001'. A data deve ser NULL.
PRINT '--- Valor ANTES de disparar o TRIGGER ---';
SELECT
    Nm_Paciente,
    Dt_Ultima_Vacinacao 
FROM dbo.Paciente
WHERE Cd_Paciente = 'PAC-001';
GO

-- 2. DURANTE: Iniciamos uma transação para testar o INSERT e o TRIGGER
BEGIN TRANSACTION;

    PRINT '--- Inserindo um novo registro, o que vai disparar o TRIGGER... ---';
    -- Este INSERT fará com que o TRIGGER dbo.trgAtualizaUltimaVacinacao seja executado.
    INSERT INTO dbo.Vacinacao_Registro
        (Cd_Vacinacao, Dt_Vacinacao, Nu_Dose, Cd_Paciente, Cd_Vacinador, Cd_Unidade, Cd_Lote)
    VALUES
        ('REG-TEST', GETDATE(), 3, 'PAC-001', 'VACD-001', 'UNID-CPA', 'LOT-CVF01');

    -- Agora verificamos se o trigger funcionou. A data deve estar preenchida com a data/hora atual.
    PRINT '--- Valor DEPOIS de disparar o TRIGGER (dentro da transação) ---';
    SELECT
        Nm_Paciente,
        Dt_Ultima_Vacinacao 
    FROM dbo.Paciente
    WHERE Cd_Paciente = 'PAC-001';

-- 3. ROLLBACK: Desfazemos o INSERT para não sujar o banco com dados de teste.
-- O ROLLBACK também desfaz a alteração feita pelo trigger.
ROLLBACK TRANSACTION;
GO

-- 4. FINAL: Verificando se o ROLLBACK funcionou. A data deve ter voltado a ser NULL.
PRINT '--- Valor FINAL, após o ROLLBACK da transação ---';
SELECT
    Nm_Paciente,
    Dt_Ultima_Vacinacao 
FROM dbo.Paciente
WHERE Cd_Paciente = 'PAC-001';
GO