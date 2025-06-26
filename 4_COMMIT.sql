-- Usar o banco de dados correto
USE VacinacaoDB;
GO

-- 1. ANTES: Verificando o dado original
SELECT Nm_Paciente, Cd_Sexo FROM dbo.Paciente WHERE Cd_Paciente = 'PAC-002';
GO

-- 2. DURANTE: Iniciando a transação e fazendo a atualização
BEGIN TRANSACTION;

    -- Atualiza o sexo do paciente
    UPDATE dbo.Paciente
    SET Cd_Sexo = 'O'
    WHERE Cd_Paciente = 'PAC-002';

    -- Verificando o dado DENTRO da transação (ainda não é permanente)
    SELECT Nm_Paciente, Cd_Sexo FROM dbo.Paciente WHERE Cd_Paciente = 'PAC-002';

-- 3. COMMIT: Tornando a alteração permanente
COMMIT TRANSACTION;
GO

-- 4. DEPOIS: Verificando se a alteração foi salva permanentemente
SELECT Nm_Paciente, Cd_Sexo FROM dbo.Paciente WHERE Cd_Paciente = 'PAC-002';
GO