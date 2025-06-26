USE VacinacaoDB;
GO

-- 1. VARIAVEIS pra guardar valores enquanto o cursor passa
DECLARE @DtVacinacao DATETIME;
DECLARE @NmPaciente CHAR(150);
DECLARE @CdLote CHAR(10);
DECLARE @NmFabricante CHAR(100);


PRINT '--- Vacinações Registradas com Cursor ---';
PRINT '-----------------------------------------------------------------------------------';
-- 2. DECLARE do CURSOR
DECLARE cursor_relatorio_vacinacao CURSOR FOR
SELECT
    vr.Dt_Vacinacao,
    p.Nm_Paciente,
    l.Cd_Lote,
    f.Nm_Fabricante
FROM
    dbo.Vacinacao_Registro AS vr
JOIN
    dbo.Paciente AS p ON vr.Cd_Paciente = p.Cd_Paciente
JOIN
    dbo.Lote AS l ON vr.Cd_Lote = l.Cd_Lote
JOIN
    dbo.Fabricante AS f ON l.Cd_Fabricante = f.Cd_Fabricante
ORDER BY
    vr.Dt_Vacinacao;

-- OPEN do CURSOR
OPEN cursor_relatorio_vacinacao;

FETCH NEXT FROM cursor_relatorio_vacinacao INTO @DtVacinacao, @NmPaciente, @CdLote, @NmFabricante;

-- WHILE enquanto FETCH funcionar
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Vacinação registrada para ' + RTRIM(@NmPaciente) + ' em ' + CONVERT(CHAR(10), @DtVacinacao, 103) + '. (Lote: ' + RTRIM(@CdLote) + ' / Fabricante: ' + RTRIM(@NmFabricante) + ')';
    -- PRINT '-----------------------------------------------------------------------------------'
    FETCH NEXT FROM cursor_relatorio_vacinacao INTO @DtVacinacao, @NmPaciente, @CdLote, @NmFabricante;
END;

-- 3. CLOSE e DEALLOCATE do CURSOR (liberando recursos)
CLOSE cursor_relatorio_vacinacao;
DEALLOCATE cursor_relatorio_vacinacao;
GO

PRINT '--- Fim ---';
