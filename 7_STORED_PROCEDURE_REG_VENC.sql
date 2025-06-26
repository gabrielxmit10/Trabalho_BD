-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- Passo 1: Preparar os dados com formato de data universal (não ambíguo)
PRINT '--- Inserindo dados de teste com formato de data correto... ---';

IF NOT EXISTS (SELECT 1 FROM dbo.Lote WHERE Cd_Lote = 'LOT-VENC')
BEGIN
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) 
    -- CORRIGIDO: Usando o formato 'YYYYMMDD'
    VALUES ('LOT-VENC', 'VAC-GRIPE', 'FAB-BTN', '20240520', '20230520', 50);
END

IF NOT EXISTS (SELECT 1 FROM dbo.Vacinacao_Registro WHERE Cd_Vacinacao = 'REG-VENC')
BEGIN
    INSERT INTO dbo.Vacinacao_Registro (Cd_Vacinacao, Dt_Vacinacao, Nu_Dose, Cd_Paciente, Cd_Vacinador, Cd_Unidade, Cd_Lote)
    -- CORRIGIDO: Usando o formato 'YYYY-MM-DDTHH:MI:SS'
    VALUES ('REG-VENC', '2024-06-01T10:00:00', 1, 'PAC-001', 'VACD-003', 'UNID-CPA', 'LOT-VENC');
END
GO


-- Passo 2: Criar o Stored Procedure.
DROP PROCEDURE IF EXISTS dbo.spPacientesComVacinaVencida;
GO

PRINT '--- Criando o Stored Procedure dbo.spPacientesComVacinaVencida... ---';
GO 

CREATE PROCEDURE dbo.spPacientesComVacinaVencida
AS
BEGIN
    SELECT
        p.Nm_Paciente,
        v.Nm_Vacina,
        l.Cd_Lote,
        l.Dt_Validade,
        vr.Dt_Vacinacao AS Dt_Aplicacao_Vencida
    FROM
        dbo.Vacinacao_Registro AS vr
    JOIN
        dbo.Paciente AS p ON vr.Cd_Paciente = p.Cd_Paciente
    JOIN
        dbo.Lote AS l ON vr.Cd_Lote = l.Cd_Lote
    JOIN
        dbo.Vacina AS v ON l.Cd_Vacina = v.Cd_Vacina
    WHERE
        vr.Dt_Vacinacao > l.Dt_Validade;
END
GO


-- Passo 3: Executar (chamar) o Stored Procedure.
PRINT '--- Executando o Stored Procedure para gerar o relatório. ---';
EXEC dbo.spPacientesComVacinaVencida;
GO