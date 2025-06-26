-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- Consulta para encontrar pacientes que tomaram vacina de TODOS os fabricantes existentes
SELECT
    p.Nm_Paciente
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