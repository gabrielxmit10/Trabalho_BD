-- LIMPEZA pra QUESTÃO 11 (caso faça sem ROLLBACK)
USE VacinacaoDB;
GO

ALTER TABLE dbo.Lote
DROP CONSTRAINT CK_Lote_QtDosesMaxima;
GO

PRINT 'Constraint CK_Lote_QtDosesMaxima removida com sucesso.';
