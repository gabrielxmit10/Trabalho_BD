-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- 1. ANTES: Verificando a quantidade original de doses
-- Usando um código de lote que existe na sua base de dados
SELECT Cd_Lote, Qt_Doses FROM dbo.Lote WHERE Cd_Lote = 'LOT-CVF01';
GO

-- 2. DURANTE: Iniciando a transação e fazendo a atualização
BEGIN TRANSACTION;

    -- Tenta atualizar a quantidade de doses para um valor incorreto
    UPDATE dbo.Lote
    SET Qt_Doses = 999
    WHERE Cd_Lote = 'LOT-CVF01';

    -- Verificando o dado DENTRO da transação
    SELECT Cd_Lote, Qt_Doses FROM dbo.Lote WHERE Cd_Lote = 'LOT-CVF01';

-- 3. ROLLBACK: Desfazendo a alteração
ROLLBACK TRANSACTION;
GO

-- 4. DEPOIS: Verificando se a alteração foi desfeita
SELECT Cd_Lote, Qt_Doses FROM dbo.Lote WHERE Cd_Lote = 'LOT-CVF01';
GO