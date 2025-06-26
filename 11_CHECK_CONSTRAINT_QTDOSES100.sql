-- Usar o banco de dados correto
USE VacinacaoDB;
GO

PRINT '--- Demonstração da CHECK CONSTRAINT com ROLLBACK ---';
BEGIN TRANSACTION;

    -- Adiciona a regra que será testada
    ALTER TABLE dbo.Lote
    ADD CONSTRAINT CK_Lote_QtDosesMaxima CHECK (Qt_Doses <= 100);

    -- Tenta inserir um valor que viola a regra.
    -- Esta linha irá gerar um erro, mas a transação continuará ativa, permitindo o ROLLBACK.
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses)
    VALUES ('LOT-FAIL', 'VAC-CVFIO', 'FAB-FIO', '20280101', '20270101', 150);

-- Desfaz todas as operações dentro da transação, incluindo a criação da CONSTRAINT.
ROLLBACK TRANSACTION;
GO

PRINT '--- Teste concluído. A transação foi desfeita e a constraint não existe mais no banco. ---';
GO