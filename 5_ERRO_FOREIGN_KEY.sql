USE VacinacaoDB;
GO

-- 1. Fabricantes do Banco de Dados
SELECT 
    *
FROM 
    dbo.Fabricante;
GO

-- 2. Insert com Cd_Fabricante que NÃO EXISTE (código 'FAB-XXX').
INSERT INTO dbo.Lote 
    (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses)
VALUES 
    ('LOT-ERRO', 'VAC-CVFIO', 'FAB-XXX', '2027-01-01', '2026-01-01', 100);
GO
