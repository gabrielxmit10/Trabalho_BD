-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- Passo 1: Preparar os dados.
PRINT '--- Inserindo lotes de teste para a demonstração... ---';

-- Inserindo um lote que VAI VENCER em 15 dias.
IF NOT EXISTS (SELECT 1 FROM dbo.Lote WHERE Cd_Lote = 'LOT-EXP30D')
BEGIN
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) 
    VALUES ('LOT-EXP30D', 'VAC-CVFIO', 'FAB-FIO', DATEADD(day, 15, GETDATE()), GETDATE(), 10);
END;

-- Inserindo um lote que JÁ VENCEU há 15 dias.
IF NOT EXISTS (SELECT 1 FROM dbo.Lote WHERE Cd_Lote = 'LOT-VNC30D')
BEGIN
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) 
    -- CORRIGIDO: O código agora tem 10 caracteres.
    VALUES ('LOT-VNC30D', 'VAC-GRIPE', 'FAB-BTN', DATEADD(day, -15, GETDATE()), DATEADD(year, -1, GETDATE()), 20);
END;
GO


-- Passo 2: Executar a consulta com UNION ALL.
PRINT '--- Executando a consulta com UNION ALL... ---';

SELECT
    l.Cd_Lote,
    v.Nm_Vacina,
    l.Dt_Validade,
    'Vence nos próximos 30 dias' AS [Status]
FROM
    dbo.Lote AS l
JOIN
    dbo.Vacina AS v ON l.Cd_Vacina = v.Cd_Vacina
WHERE
    l.Dt_Validade > GETDATE() AND l.Dt_Validade <= DATEADD(day, 30, GETDATE())

UNION ALL

SELECT
    l.Cd_Lote,
    v.Nm_Vacina,
    l.Dt_Validade,
    'Venceu nos últimos 30 dias' AS [Status]
FROM
    dbo.Lote AS l
JOIN
    dbo.Vacina AS v ON l.Cd_Vacina = v.Cd_Vacina
WHERE
    l.Dt_Validade < GETDATE() AND l.Dt_Validade >= DATEADD(day, -30, GETDATE());
GO


-- Passo 3: Limpeza dos dados de teste.
PRINT '--- Removendo os lotes de teste... ---';
DELETE FROM dbo.Lote WHERE Cd_Lote = 'LOT-EXP30D';
-- CORRIGIDO: Usando o código correto para a remoção.
DELETE FROM dbo.Lote WHERE Cd_Lote = 'LOT-VNC30D';
GO