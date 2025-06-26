USE VacinacaoDB;
GO

BEGIN TRANSACTION;

    -- Criando o Contrainst com CHECK das <= 100 Doses
    ALTER TABLE dbo.Lote
    ADD CONSTRAINT CK_Lote_QtDosesMaxima CHECK (Qt_Doses <= 100);

    -- Insert de Lote com 150 Doses (que dá Erro por causa do CONSTRAINT)
    INSERT INTO dbo.Lote (Cd_Lote, Cd_Vacina, Cd_Fabricante, Dt_Validade, Dt_Fabricacao, Qt_Doses)
    VALUES ('LOT-FAIL', 'VAC-CVFIO', 'FAB-FIO', '20280101', '20270101', 150);

ROLLBACK TRANSACTION;
GO
