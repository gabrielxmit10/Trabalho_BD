USE VacinacaoDB;
GO

-- 1. Verificar quais fabricantes existem atualmente na tabela.
-- Nenhum com o código 'FAB-XXX'.
SELECT 
    *
FROM 
    dbo.Fabricante;
GO

-- 2. Tentativa de inserir um novo Lote com um Cd_Fabricante que NÃO EXISTE (código 'FAB-XXX').
INSERT INTO dbo.Lote 
    (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses)
VALUES 
    ('LOT-ERRO', 'VAC-CVFIO', 'FAB-XXX', '2027-01-01', '2026-01-01', 100);
GO