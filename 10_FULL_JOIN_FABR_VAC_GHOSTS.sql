-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- Passo 1: Preparar os dados de teste.
PRINT '--- Inserindo dados de teste para o FULL JOIN... ---';

-- Inserindo um Fabricante que não tem lotes/vacinas.
IF NOT EXISTS (SELECT 1 FROM dbo.Fabricante WHERE Cd_Fabricante = 'FAB-GHOST')
BEGIN
    INSERT INTO dbo.Fabricante (Cd_Fabricante, Nm_Fabricante, CNPJ_Fabricante) 
    VALUES ('FAB-GHOST', 'Fabricante Fantasma', '99999999000199');
END;

-- Inserindo uma Vacina que não está em nenhum lote.
-- Primeiro, garantimos a doença "mãe".
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

-- Passo 2: Executar a consulta com FULL JOIN.
PRINT '--- Executando a consulta FULL JOIN... ---';

-- Usamos uma CTE (Common Table Expression) para criar uma tabela virtual
-- que representa as ligações existentes entre fabricantes e vacinas através dos lotes.
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


-- Passo 3: Limpeza dos dados de teste.
PRINT '--- Removendo os dados de teste... ---';
-- A ordem da remoção é importante para respeitar as chaves estrangeiras.
DELETE FROM dbo.Vacina WHERE Cd_Vacina = 'VAC-ORFA';
DELETE FROM dbo.Doenca WHERE Cd_Doenca = 'DOE-ORFA';
DELETE FROM dbo.Fabricante WHERE Cd_Fabricante = 'FAB-GHOST';
GO