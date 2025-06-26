-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- Passo 1: Adicionar a coluna para armazenar a data da �ltima vacina��o na tabela Paciente.
-- Usamos IF NOT EXISTS para que o script possa ser executado v�rias vezes sem erro.
PRINT '--- Adicionando a coluna Dt_Ultima_Vacinacao � tabela Paciente... ---';

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'Dt_Ultima_Vacinacao' AND Object_ID = Object_ID(N'dbo.Paciente'))
BEGIN
    ALTER TABLE dbo.Paciente
    ADD Dt_Ultima_Vacinacao DATETIME NULL;
END
GO

-- Passo 2: Criar o TRIGGER
-- Primeiro, apagamos o TRIGGER se ele j� existir.
DROP TRIGGER IF EXISTS dbo.trgAtualizaUltimaVacinacao;
GO

PRINT '--- Criando o TRIGGER dbo.trgAtualizaUltimaVacinacao... ---';
GO

CREATE TRIGGER dbo.trgAtualizaUltimaVacinacao
ON dbo.Vacinacao_Registro -- O gatilho pertence � tabela Vacinacao_Registro
FOR INSERT -- E ele dispara no evento de INSERT
AS
BEGIN
    -- Impede que mensagens como "(1 linha afetada)" apare�am no resultado
    SET NOCOUNT ON;

    -- Atualiza a tabela Paciente
    UPDATE dbo.Paciente
    SET
        -- Define a nova data com base na data da linha que acabou de ser inserida
        Dt_Ultima_Vacinacao = i.Dt_Vacinacao
    FROM
        dbo.Paciente AS p
    JOIN
        -- 'inserted' � uma tabela "m�gica" que existe dentro de um trigger
        -- e cont�m os dados da(s) linha(s) que acabaram de ser inseridas.
        inserted AS i ON p.Cd_Paciente = i.Cd_Paciente;
END
GO