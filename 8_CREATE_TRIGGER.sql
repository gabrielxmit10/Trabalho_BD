USE VacinacaoDB;
GO


-- Criar Coluna pra Última Vacinação do Paciente
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'Dt_Ultima_Vacinacao' AND Object_ID = Object_ID(N'dbo.Paciente'))
BEGIN
    ALTER TABLE dbo.Paciente
    ADD Dt_Ultima_Vacinacao DATETIME NULL;
END
GO


DROP TRIGGER IF EXISTS dbo.trgAtualizaUltimaVacinacao;
GO

-- 1. Criar o TRIGGER (dbo.trgAtualizaUltimaVacinacao)
CREATE TRIGGER dbo.trgAtualizaUltimaVacinacao
ON dbo.Vacinacao_Registro
FOR INSERT -- O Gatilho é o Insert
AS
BEGIN
    -- SET NOCOUNT ON;

    UPDATE dbo.Paciente
    SET
        Dt_Ultima_Vacinacao = i.Dt_Vacinacao
    FROM
        dbo.Paciente AS p
    JOIN
        inserted AS i ON p.Cd_Paciente = i.Cd_Paciente;
END
GO

PRINT 'Trigger criado com Sucesso';
GO
