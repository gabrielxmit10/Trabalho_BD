USE VacinacaoDB;
GO

-- 1. ANTES: Sexo Original (M)
SELECT Nm_Paciente, Cd_Sexo FROM dbo.Paciente WHERE Cd_Paciente = 'PAC-002';
GO

BEGIN TRANSACTION;

    UPDATE dbo.Paciente
    SET Cd_Sexo = 'O'
    WHERE Cd_Paciente = 'PAC-002';

    -- 2. DURANTE COMMIT: Sexo novo não confirmado ainda (O)
    SELECT Nm_Paciente, Cd_Sexo FROM dbo.Paciente WHERE Cd_Paciente = 'PAC-002';

COMMIT TRANSACTION;
GO

-- 3. DEPOIS: Sexo novo já alterado (O)
SELECT Nm_Paciente, Cd_Sexo FROM dbo.Paciente WHERE Cd_Paciente = 'PAC-002';
GO


-------------------------------------------------------


-- Mudando de volta pra poder rodar de novo
BEGIN TRANSACTION;

    UPDATE dbo.Paciente
    SET Cd_Sexo = 'M'
    WHERE Cd_Paciente = 'PAC-002';

COMMIT TRANSACTION;
GO
