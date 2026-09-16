SELECT 
    n.nome AS ruolo_nomina,
    p.nome AS nome_persona,
    p.cognome AS cognome_persona,
    st.email_referente,
    st.telefono_referente,
    n.data_inizio
FROM nomina n
JOIN stakeholder st ON n.stakeholder_id = st.stakeholder_id
LEFT JOIN personale p ON p.stakeholder_id = st.stakeholder_id
WHERE n.data_fine IS NULL;