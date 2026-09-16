SELECT 
    f.fornitura_id,
    f.tipo_fornitura,
    f.tipologia,
    f.nome AS fornitore,
    f.livello_criticita,
    f.data_inizio,
    a.nome AS asset_collegato,
    e.ragione_sociale,
    e.soggetto_nis2
FROM fornitura f
LEFT JOIN asset a ON f.asset_id = a.asset_id
LEFT JOIN esterno e ON f.stakeholder_id = e.stakeholder_id
WHERE f.data_fine IS NULL
ORDER BY f.tipo_fornitura ASC;