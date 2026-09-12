CREATE OR REPLACE FUNCTION salva_storico_asset()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO asset_storico (
        asset_id, nome, funzionalita, stato, configurazione, macroarea, data_modifica, tipo_operazione
    )
    VALUES (
        OLD.asset_id, OLD.nome, OLD.funzionalita, OLD.stato, OLD.configurazione, OLD.macroarea, NOW(), TG_OP
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_asset_versioning
BEFORE UPDATE OR DELETE ON asset
FOR EACH ROW
EXECUTE FUNCTION salva_storico_asset();


CREATE OR REPLACE FUNCTION salva_storico_fornitura()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO fornitura_storico (
        fornitura_id, tipo_fornitura, tipologia, nome, livello_criticita,
        data_inizio, data_fine, asset_id, stakeholder_id, data_modifica, tipo_operazione
    )
    VALUES (
        OLD.fornitura_id, OLD.tipo_fornitura, OLD.tipologia, OLD.nome, OLD.livello_criticita,
        OLD.data_inizio, OLD.data_fine, OLD.asset_id, OLD.stakeholder_id, NOW(), TG_OP
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_fornitura_versioning
BEFORE UPDATE OR DELETE ON fornitura
FOR EACH ROW
EXECUTE FUNCTION salva_storico_fornitura();


CREATE OR REPLACE FUNCTION salva_storico_personale()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO personale_storico (
        personale_id, nome, cognome, mansione, ruolo, stakeholder_id, data_modifica, tipo_operazione
    )
    VALUES (
        OLD.personale_id, OLD.nome, OLD.cognome, OLD.mansione, OLD.ruolo, OLD.stakeholder_id, NOW(), TG_OP
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_personale_versioning
BEFORE UPDATE OR DELETE ON personale
FOR EACH ROW
EXECUTE FUNCTION salva_storico_personale();


CREATE OR REPLACE FUNCTION salva_storico_esterni()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO esterni_storico (
        esterni_id, tipo_esterno, nome_ragione_sociale, cf_piva, soggetto_nis2, stakeholder_id, data_modifica, tipo_operazione
    )
    VALUES (
        OLD.estrno_id, OLD.tipo_esterno, OLD.nome_ragione_sociale, OLD.cf_piva, OLD.soggetto_nis2, OLD.stakeholder_id, NOW(), TG_OP
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_esterni_versioning
BEFORE UPDATE OR DELETE ON esterni
FOR EACH ROW
EXECUTE FUNCTION salva_storico_esterni();


CREATE OR REPLACE FUNCTION salva_storico_stakeholder()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO stakeholder_storico (
        stakeholder_id, telefono_referente, email_referente, data_modifica, tipo_operazione
    )
    VALUES (
        OLD.stakeholder_id, OLD.telefono_referente, OLD.email_referente, NOW(), TG_OP
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_stakeholder_versioning
BEFORE UPDATE OR DELETE ON stakeholder
FOR EACH ROW
EXECUTE FUNCTION salva_storico_stakeholder();


CREATE OR REPLACE FUNCTION salva_storico_nomina()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO nomina_storico (
        nomina_id, nome, descrizione, dati, data_inizio, data_fine, link_documento, stakeholder_id, sostituto, data_modifica, tipo_operazione
    )
    VALUES (
        OLD.nomina_id, OLD.nome, OLD.descrizione, OLD.dati, OLD.data_inizio, OLD.data_fine, OLD.link_documento, OLD.stakeholder_id, OLD.sostituto, NOW(), TG_OP
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_nomina_versioning
BEFORE UPDATE OR DELETE ON nomina
FOR EACH ROW
EXECUTE FUNCTION salva_storico_nomina();


CREATE OR REPLACE FUNCTION salva_storico_utenze()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO utenze_storico (
        utenze_id, asset_id, stakeholder_id, data_inizio, data_fine, credenziali, tipo_accesso, tempo_conservazione_log, concesso_da, modalita_accesso, data_modifica, tipo_operazione
    )
    VALUES (
        OLD.utenze_id, OLD.asset_id, OLD.stakeholder_id, OLD.data_inizio, OLD.data_fine, OLD.credenziali, OLD.tipo_accesso, OLD.tempo_conservazione_log, OLD.concesso_da, OLD.modalita_accesso, NOW(), TG_OP
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_utenze_versioning
BEFORE UPDATE OR DELETE ON utenze
FOR EACH ROW
EXECUTE FUNCTION salva_storico_utenze();