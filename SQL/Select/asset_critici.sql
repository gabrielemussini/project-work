SELECT 
    asset_id,
    nome,
    macroarea,
    criticita,
    stato
FROM asset
WHERE criticita IN ('Alta', 'Media')
ORDER BY criticita ASC;