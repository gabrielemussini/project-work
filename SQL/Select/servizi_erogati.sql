SELECT 
    s.servizi_id,
    s.categoria AS nome_servizio,
    a.nome AS asset_di_supporto,
    a.criticita AS criticita_asset
FROM servizi s
JOIN asset a ON s.asset_id = a.asset_id
JOIN fornitura f ON f.asset_id = a.asset_id
WHERE f.tipo_fornitura = 'Vendita'
ORDER BY a.criticita ASC;