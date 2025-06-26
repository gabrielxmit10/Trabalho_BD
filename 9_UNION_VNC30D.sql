USE VacinacaoDB;
GO

-- 1. Inserindo Lote com Validades (daqui 15 dias e 15 dias atrás)

-- Insert do que VAI VENCER em 15 dias.
IF NOT EXISTS (SELECT 1 FROM dbo.Lote WHERE Cd_Lote = 'LOT-EXP30D')
BEGIN
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) 
    VALUES ('LOT-EXP30D', 'VAC-CVFIO', 'FAB-FIO', DATEADD(day, 15, GETDATE()), GETDATE(), 10);
END;

-- Insert do que VENCEU há 15 dias.
IF NOT EXISTS (SELECT 1 FROM dbo.Lote WHERE Cd_Lote = 'LOT-VNC30D')
BEGIN
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) 
    VALUES ('LOT-VNC30D', 'VAC-GRIPE', 'FAB-BTN', DATEADD(day, -15, GETDATE()), DATEADD(year, -1, GETDATE()), 20);
END;
GO


-- 2. Usando UNION ALL pra ver nos próximos 30 e últimos 30
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


-- 3. Tirando os Dados da Questão
DELETE FROM dbo.Lote WHERE Cd_Lote = 'LOT-EXP30D';
DELETE FROM dbo.Lote WHERE Cd_Lote = 'LOT-VNC30D';
GO
