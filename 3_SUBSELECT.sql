USE VacinacaoDB;
GO

-- Pacientes q tomaram vacina de TODO fabricante
SELECT
    p.Nm_Paciente,
    p.Cd_Paciente
FROM
    dbo.Paciente AS p
JOIN
    dbo.Vacinacao_Registro AS vr ON p.Cd_Paciente = vr.Cd_Paciente
JOIN
    dbo.Lote AS l ON vr.Cd_Lote = l.Cd_Lote
GROUP BY
    p.Cd_Paciente, p.Nm_Paciente
HAVING
    COUNT(DISTINCT l.Cd_Fabricante) = (SELECT COUNT(*) FROM dbo.Fabricante);
GO

-- Provando Fabricantes da Helena Costa
SELECT
    p.Nm_Paciente,
    f.Nm_Fabricante,
    v.Nm_Vacina,
    vr.Dt_Vacinacao
FROM
    dbo.Paciente AS p
JOIN
    dbo.Vacinacao_Registro AS vr ON p.Cd_Paciente = vr.Cd_Paciente
JOIN
    dbo.Lote AS l ON vr.Cd_Lote = l.Cd_Lote
JOIN
    dbo.Fabricante AS f ON l.Cd_Fabricante = f.Cd_Fabricante
JOIN
    dbo.Vacina AS v ON l.Cd_Vacina = v.Cd_Vacina
WHERE
    p.Cd_Paciente = 'PAC-005'; -- Só ver a Helena Costa
GO
