USE VacinacaoDB;
GO

-- 1. Inserindo Fabricante sem Vacina (sem Lote nenhum)
IF NOT EXISTS (SELECT 1 FROM dbo.Fabricante WHERE Cd_Fabricante = 'FAB-GHOST')
BEGIN
    INSERT INTO dbo.Fabricante (Cd_Fabricante, Nm_Fabricante, CNPJ_Fabricante) 
    VALUES ('FAB-GHOST', 'Fabricante Fantasma', '99999999000199');
END;

-- 1.1. Inserindo Vacina sem Fabricante
IF NOT EXISTS (SELECT 1 FROM dbo.Doenca WHERE Cd_Doenca = 'DOE-ORFA')
BEGIN
    INSERT INTO dbo.Doenca (Cd_Doenca, Nm_Doenca) VALUES ('DOE-ORFA', 'Doença Órfã');
END;
IF NOT EXISTS (SELECT 1 FROM dbo.Vacina WHERE Cd_Vacina = 'VAC-ORFA')
BEGIN
    INSERT INTO dbo.Vacina (Cd_Vacina, Nm_Vacina, Cd_Doenca) 
    VALUES ('VAC-ORFA', 'Vacina Órfã', 'DOE-ORFA');
END;
GO

-- 2. Usando FULL JOIN pra ver os Fabricantes e Vacinas Juntos
WITH FabricanteVacinaLink AS (
    SELECT DISTINCT l.Cd_Fabricante, l.Cd_Vacina
    FROM dbo.Lote AS l
)
SELECT 
    f.Nm_Fabricante,
    v.Nm_Vacina
FROM 
    dbo.Fabricante AS f
FULL OUTER JOIN 
    FabricanteVacinaLink AS fvl ON f.Cd_Fabricante = fvl.Cd_Fabricante
FULL OUTER JOIN 
    dbo.Vacina AS v ON fvl.Cd_Vacina = v.Cd_Vacina
ORDER BY 
    f.Nm_Fabricante, v.Nm_Vacina;
GO


-- 3. Tirando os Dados da Questão
DELETE FROM dbo.Vacina WHERE Cd_Vacina = 'VAC-ORFA';
DELETE FROM dbo.Doenca WHERE Cd_Doenca = 'DOE-ORFA';
DELETE FROM dbo.Fabricante WHERE Cd_Fabricante = 'FAB-GHOST';
GO
