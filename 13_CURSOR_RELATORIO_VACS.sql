USE VacinacaoDB;
GO

-- 1. DECLARAR AS VARIÁVEIS
-- Estas variáveis irão guardar os valores de cada linha enquanto o cursor percorre os dados.
DECLARE @DtVacinacao DATETIME;
DECLARE @NmPaciente CHAR(150);
DECLARE @CdLote CHAR(10);
DECLARE @NmFabricante CHAR(100);

-- 2. DECLARAR O CURSOR
-- Associamos o cursor a uma consulta SELECT que junta as tabelas necessárias.
PRINT '--- Relatório de Vacinação com Cursor ---';
PRINT '-----------------------------------------------------------------------------------';
DECLARE cursor_relatorio_vacinacao CURSOR FOR
SELECT
    vr.Dt_Vacinacao,
    p.Nm_Paciente,
    l.Cd_Lote,
    f.Nm_Fabricante
FROM
    dbo.Vacinacao_Registro AS vr
JOIN
    dbo.Paciente AS p ON vr.Cd_Paciente = p.Cd_Paciente
JOIN
    dbo.Lote AS l ON vr.Cd_Lote = l.Cd_Lote
JOIN
    dbo.Fabricante AS f ON l.Cd_Fabricante = f.Cd_Fabricante
ORDER BY
    vr.Dt_Vacinacao;

-- 3. ABRIR O CURSOR
-- A consulta SELECT é executada e os resultados são armazenados na memória, prontos para serem percorridos.
OPEN cursor_relatorio_vacinacao;

-- 4. PERCORRER (FETCH) O CURSOR
-- Pegamos a primeira linha do cursor e a colocamos nas nossas variáveis.
FETCH NEXT FROM cursor_relatorio_vacinacao INTO @DtVacinacao, @NmPaciente, @CdLote, @NmFabricante;

-- O laço WHILE continua enquanto a última operação FETCH for bem-sucedida (@@FETCH_STATUS = 0)
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Dentro do laço, trabalhamos com os dados da linha atual que estão nas variáveis.
    -- Usamos RTRIM() para remover os espaços em branco extras dos campos CHAR.
    PRINT 'Vacinação registrada para ' + RTRIM(@NmPaciente) + ' em ' + CONVERT(CHAR(10), @DtVacinacao, 103) + '. (Lote: ' + RTRIM(@CdLote) + ' / Fabricante: ' + RTRIM(@NmFabricante) + ')';
    --PRINT '-----------------------------------------------------------------------------------'
    -- No final do laço, pegamos a próxima linha para a próxima iteração.
    FETCH NEXT FROM cursor_relatorio_vacinacao INTO @DtVacinacao, @NmPaciente, @CdLote, @NmFabricante;
END;

-- 5. FECHAR E DESALOCAR O CURSOR
-- Após o fim do laço, é crucial fechar e desalocar o cursor para liberar os recursos do servidor.
CLOSE cursor_relatorio_vacinacao;
DEALLOCATE cursor_relatorio_vacinacao;
GO

PRINT '--- Fim do Relatório ---';