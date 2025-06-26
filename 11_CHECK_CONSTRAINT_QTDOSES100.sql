-- Usar o banco de dados correto
USE VacinacaoDB;
GO

PRINT '--- Demonstra��o da CHECK CONSTRAINT com ROLLBACK ---';
BEGIN TRANSACTION;

    -- Adiciona a regra que ser� testada
    ALTER TABLE dbo.Lote
    ADD CONSTRAINT CK_Lote_QtDosesMaxima CHECK (Qt_Doses <= 100);

    -- Tenta inserir um valor que viola a regra.
    -- Esta linha ir� gerar um erro, mas a transa��o continuar� ativa, permitindo o ROLLBACK.
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses)
    VALUES ('LOT-FAIL', 'VAC-CVFIO', 'FAB-FIO', '20280101', '20270101', 150);

-- Desfaz todas as opera��es dentro da transa��o, incluindo a cria��o da CONSTRAINT.
ROLLBACK TRANSACTION;
GO

PRINT '--- Teste conclu�do. A transa��o foi desfeita e a constraint n�o existe mais no banco. ---';
GO