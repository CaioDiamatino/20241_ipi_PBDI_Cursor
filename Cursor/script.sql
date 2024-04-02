DO $$
DECLARE
	--1. declaração do cursor(cursor não vinculado)
	cur_nomes_youtubers REFCURSOR;
	v_youtuber VARCHAR(200);
BEGIN
	--2. Abertura do cursor
	OPEN cur_nomes_youtubers FOR
		SELECT youtuber FROM tb_youtubers;
	--3. Reculperação de dados de interesse
	LOOP 
		FETCH cur_nomes_youtuber INTO v_youtuber;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', v_youtuber;
	END LOOP;
	--4, Fechar o cursor
	CLOSE cur_names_youtubers;
END;
$$

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