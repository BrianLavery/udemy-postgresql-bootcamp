-- ts_headline
SELECT
	president,
	title,
	speech_date,
	ts_headline(speech_text, to_tsquery('military <-> defense'),'StartSel=<,StopSel=>')
FROM docs_presidents
WHERE
	speech_text_search @@ to_tsquery('military <-> defense')
	
-- ts_rank
SELECT
	president,
	title,
	speech_date,
	ts_headline(speech_text, to_tsquery('military <-> defense'),'StartSel=<,StopSel=>'),
	ts_rank (
		speech_text_search,
		to_tsquery('military <-> defense')
	) AS score
FROM docs_presidents
WHERE
	speech_text_search @@ to_tsquery('military <-> defense')
ORDER BY score DESC


-- ts_rank normalised to ignore length of speech
SELECT
	president,
	title,
	speech_date,
	ts_headline(speech_text, to_tsquery('military <-> defense'),'StartSel=<,StopSel=>'),
	ts_rank (
		speech_text_search,
		to_tsquery('military <-> defense'),
		2 --ts_rank normalisation
	) AS score
FROM docs_presidents
WHERE
	speech_text_search @@ to_tsquery('military <-> defense')
ORDER BY score DESC