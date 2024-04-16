-- Active: 1710242554065@@127.0.0.1@5432@20241_fatec_ipi_pbdi_cursores
DO $$
DECLARE
	--1. cursornão vinculdao
	cur_delete REFCURSOR;
	tupla RECORD;
BEGIN
	--2. Abrir o cursor
	OPEN cur_delete SCROLL FOR
		SELECT * FROM tb_youtubers
	LOOP
		--pego a proxima linha
		FETCH cur_delete INTO tupla;
		--saio se for o caso
		EXIT WHEN NOT FOUND;
		--olho para vido_count da tupla
		IF tupla.video_count IS NULL THEN 
		--se for null, faça delete
		DELETE FROM tb_youtubers WHERE CURRENt OF cur_delete; 
		END IF;
	END LOOP;
	--fazer o Loop de baixo para cima
	LOOP
		FETCH BACKWARD FROM cur_delete INTO tupla;
		--saio se for o caso
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', tupla
	END LOOP;
	CLOSE cur_delete;
END;
$$



-- Active: 1710242554065@@127.0.0.1@5432@20241_fatec_ipi_pbdi_cursores
--cursor com parâmetro nomeado e por ordem
-- exibir nomes dos youtubers que começaram a partir de 2010
-- e que têm pelo menos , 60m inscritos
-- Bloquinho anonimo
-- DO $$
-- 	DECLARE
-- 	--1. Declaração do cursor
-- 	v_ano INT := 2010;
-- 	v_inscritos INT := 60000000;
-- 	cur_ano_inscritos CURSOR (ano INT, inscritos INT) FOR
-- 	SELECT youtuber FROM tb_youtubers WHERE started >= ano AND subscribers >= inscritos;
-- 	v_youtuber VARCHAR(200);
-- 	BEGIN
-- 	--2, Abrindo
-- 		--essa
-- 		-- OPEN cur_ano_inscritos(v_ano, v_inscritos);
-- 		-- --ou essa
-- 		-- OPEN cur_ano_inscritos(inscritos := v_inscritos, ano := v_ano );

-- 		OPEN cur_ano_inscritos(ano := v_ano, inscritos := v_inscritos);
-- 	LOOP
-- 		--3. Reculperação
-- 		--buscar nome
-- 		FETCH cur_ano_inscritos INTO v_youtuber;
-- 		--sair se for o caso
-- 		EXIT WHEN NOT FOUND;
-- 		--exibir se puder
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	--4. Fechamento
-- 	END;
-- $$


--cursor vinculado(bound)
--
--
-- DO $$
-- 	DECLARE
-- 		--cursor bound
-- 		--1, Declaração(ainda não esta aberto)
-- 		cur_nomes_e_inscritos CURSOR FOR
-- 		SELECT youtuber, subscribers FROM tb_youtubers;
-- 		tupla RECORD;
-- 		--tupla.youtuber me dá o youtuber
-- 		--tupla.subscribers me dá o número de subscribers
-- 		resultado TEXT DEFAULT '';
-- 	BEGIN
-- 		--2. Abertura do cursor
-- 		OPEN cur_nomes_e_inscritos;
-- 		--vamos usar um loop While
-- 		--3. Reculperação de dados
-- 		FETCH cur_nomes_e_inscritos INTO tupla;
-- 		WHILE FOUND LOOP
-- 			--concatenação, operador ||
-- 			resultado := resultado || tupla.youtuber || ':' || tupla.subscribers || ',';
-- 			FETCH cur_nomes_e_inscritos INTO tupla;
-- 			END LOOP;
-- 		--4. Fechamento
-- 			CLOSE cur_nomes_e_inscritos;
-- 			RAISE NOTICE '%', resultado;
-- 	END;

-- $$

--cursor não vinculado(unbound)
--cursor query dinâmica, ou seja , uma query representada
--como uma string
--bloquinho anonimo
-- DO $$
-- DECLARE
-- 	--1. Declaração
-- 	cur_nomes_a_partir_de REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- 	v_ano INT := 2000;
-- 	v_nome_tabela VARCHAR(200) := 'tb_youtubers';
	
-- BEGIN
-- 	--2. Abertura do cursor
-- 	OPEN cur_nomes_a_partir_de FOR EXECUTE 
-- 	format(
-- 		'
-- 			SELECT youtuber
-- 			FROM %s
-- 			WHERE started >= S1 
-- 		', v_nome_tabela
-- 	)USING v_ano;
-- 	LOOP
-- 		--3,Reculperação dos dados 
-- 		FETCH cur_nomes_a_paritr_de INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	--4, Fechamento do cursor
-- 	CLOSE cur_nomes_a_paritr_de;
-- END;
-- $$



-- --un bloquinho anônimo
-- DO $$
-- 	DECLARE
-- 		--1. declaração do cursor(cursor não vinculado)
-- 		cur_nomes_youtubers REFCURSOR;
-- 		v_youtuber VARCHAR(200);
-- 	BEGIN
-- 		--2. Abertura do cursor
-- 	OPEN cur_nomes_youtubers FOR
-- 		SELECT youtuber FROM tb_youtubers;
-- 	--3. Reculperação de dados de interesse
-- 	LOOP 
-- 		FETCH cur_nomes_youtuber INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	--4, Fechar o cursor
-- 	CLOSE cur_names_youtubers;
-- END;
-- $$


-- CREATE TABLE tb_youtubers (
-- 	cod_top_youtubers SERIAL PRIMARY KEY,
-- 	rank INT,
-- 	youtuber VARCHAR(200),
-- 	subscribers INT,
-- 	video_views VARCHAR(200),
-- 	video_count INT,
-- 	category VARCHAR(200),
-- 	started INT
-- );
-- DROP TABLE tb_youtubers;
-- SELECT * FROM tb_youtubers;

-- ALTER TABLE tb_youtubers ALTER COLUMN video_views TYPE BIGINT USING video_views::BIGINT;