USE VacinacaoDB;
GO


-- 1. Inserindo o Lote Vencido (da QUESTÃO 6, caso fora de ordem)
IF NOT EXISTS (SELECT 1 FROM dbo.Lote WHERE Cd_Lote = 'LOT-VENC')
BEGIN
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses) 
    VALUES ('LOT-VENC', 'VAC-GRIPE', 'FAB-BTN', '20240520', '20230520', 50);
END

-- 1.1. Inserindo o Registro com Vacina Vencida
IF NOT EXISTS (SELECT 1 FROM dbo.Vacinacao_Registro WHERE Cd_Vacinacao = 'REG-VENC')
BEGIN
    INSERT INTO dbo.Vacinacao_Registro (Cd_Vacinacao, Dt_Vacinacao, Nu_Dose, Cd_Paciente, Cd_Vacinador, Cd_Unidade, Cd_Lote)
    VALUES ('REG-VENC', '2024-06-01T10:00:00', 1, 'PAC-001', 'VACD-003', 'UNID-CPA', 'LOT-VENC');
END
GO



DROP PROCEDURE IF EXISTS dbo.spPacientesComVacinaVencida;
GO


-- 2. Create Stored Procedure (dbo.spPacientesComVacinaVencida)
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
        vr.Dt_Vacinacao > l.Dt_Validade; -- Data depois da Validade
END
GO


-- 3. Exec Stored Procedure do Select de Pacientes com Vacina Vencida
EXEC dbo.spPacientesComVacinaVencida;
GO
