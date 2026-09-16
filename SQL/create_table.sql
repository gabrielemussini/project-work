CREATE TABLE asset (
	asset_id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	funzionalita VARCHAR(255) NOT NULL,
	aggiorn_manuale BOOLEAN NOT NULL,
	stato VARCHAR(50) NOT NULL CHECK (stato IN ('Attivo', 'In dismissione', 'Dismesso')),
	configurazione TEXT,
	macroarea VARCHAR(50) NOT NULL,
	criticita VARCHAR(50) NOT NULL CHECK (criticita IN ('Minima','Bassa','Media','Alta'))
);

CREATE TABLE stakeholder (
	stakeholder_id SERIAL PRIMARY KEY,
	email_referente VARCHAR(50) NOT NULL,
	telefono_referente VARCHAR(50) NOT NULL
);

CREATE TABLE squadra (
	squadra_id SERIAL PRIMARY KEY,
	nome VARCHAR(100)
);

CREATE TABLE hardware (
	hardware_id SERIAL PRIMARY KEY,
	categoria VARCHAR(50) NOT NULL,
	mac VARCHAR(50),
	ip VARCHAR(50),
	produttore VARCHAR(255),
	posizione VARCHAR(255) NOT NULL,
	asset_id INTEGER NOT NULL,
	FOREIGN KEY (asset_id) REFERENCES asset(asset_id)
);

CREATE TABLE software (
	software_id SERIAL PRIMARY KEY,
	tipo_licenza VARCHAR (40) NOT NULL CHECK (tipo_licenza IN ('Open source','Closed source','Proprietario')),
	categoria VARCHAR(40) NOT NULL,
	sviluppo_sicuro TEXT,
	asset_id INTEGER NOT NULL,
	FOREIGN KEY (asset_id)	REFERENCES asset(asset_id)
);

CREATE TABLE database (
	database_id SERIAL PRIMARY KEY,
	contenuto VARCHAR (255) NOT NULL,
	riservatezza VARCHAR (40) NOT NULL CHECK (riservatezza IN ('Pubblico', 'Sensibile', 'Riservato')),
	posizione VARCHAR(50) NOT NULL CHECK (posizione IN ('In loco', 'In cloud')),
	asset_id INTEGER NOT NULL,
	FOREIGN KEY (asset_id) REFERENCES asset(asset_id)
);

CREATE TABLE servizi(
	servizi_id SERIAL PRIMARY KEY,
	categoria VARCHAR(50) NOT NULL,
	asset_id INTEGER NOT NULL,
	FOREIGN KEY (asset_id) REFERENCES asset(asset_id)
);

CREATE TABLE fornitura (
	fornitura_id SERIAL PRIMARY KEY,
	tipo_fornitura VARCHAR(50) NOT NULL CHECK (tipo_fornitura IN ('Vendita','Acquisto')),
	tipologia VARCHAR(50) NOT NULL,
	nome VARCHAR(100),
	data_inizio DATE NOT NULL,
	data_fine DATE,
	livello_criticita VARCHAR(50) NOT NULL CHECK (livello_criticita IN ('Minimo', 'Basso', 'Medio','Alto')),
	asset_id INTEGER,
	stakeholder_id INTEGER NOT NULL,
	FOREIGN KEY (asset_id) REFERENCES asset(asset_id),
	FOREIGN KEY (stakeholder_id) REFERENCES Stakeholder(stakeholder_id) 
);

CREATE TABLE livello_atteso (
	livello_atteso_id SERIAL PRIMARY KEY,
	asset_id INTEGER NOT NULL,
	metrica VARCHAR(100) NOT NULL,
	soglia_allerta_max REAL,
	soglia_allerta_min REAL,
	squadra_id INTEGER NOT NULL,
	FOREIGN KEY (asset_id) REFERENCES asset(asset_id),
	FOREIGN KEY (squadra_id) REFERENCES squadra(squadra_id)
);

CREATE TABLE riesame(
	riesame_id SERIAL PRIMARY KEY,
	data_riesame DATE NOT NULL,
	descrizione TEXT NOT NULL,
	esito TEXT NOT NULL,
	link_documento TEXT NOT NULL,
	squadra_id INTEGER NOT NULL,
	FOREIGN KEY (squadra_id) REFERENCES squadra(squadra_id)
);

CREATE TABLE flussi_rete(
	flusso_id SERIAL PRIMARY KEY,
	entita_origine VARCHAR(100) NOT NULL,
	asset_origine INTEGER,
	stakeholder_origine INTEGER,
	entita_destinazione VARCHAR(100) NOT NULL,
	asset_destinazione INTEGER,
	stakeholder_destinazione INTEGER,
	direzione VARCHAR(50) NOT NULL CHECK (direzione IN ('Monodirezionale', 'Bidirezionale')),
	scopo VARCHAR(255) NOT NULL,
	autorizzato_da INTEGER NOT NULL,
	data_autorizzazione DATE NOT NULL,
	stato VARCHAR(50) NOT NULL CHECK (stato IN ('Attivo', 'In dismissione', 'Dismesso')),
	FOREIGN KEY (asset_origine) REFERENCES asset(asset_id),
	FOREIGN KEY (Stakeholder_origine) REFERENCES stakeholder(stakeholder_id),
	FOREIGN KEY (asset_destinazione) REFERENCES asset(asset_id),
	FOREIGN KEY (Stakeholder_destinazione) REFERENCES stakeholder(stakeholder_id),
	FOREIGN KEY (autorizzato_da) REFERENCES squadra(squadra_id)
);

CREATE TABLE utenze (
	utenze_id SERIAL PRIMARY KEY,
	asset_id INTEGER NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	data_inizio DATE NOT NULL,
	data_fine DATE,
	credenziali BOOLEAN NOT NULL,
	tipo_accesso VARCHAR(50) NOT NULL CHECK (tipo_accesso IN ('Da remoto', 'In sede')),
	tempo_conservazione_log INTERVAL NOT NULL,
	concesso_da INTEGER NOT NULL,
	modalita_accesso TEXT NOT NULL,
	FOREIGN KEY (asset_id) REFERENCES asset(asset_id),
	FOREIGN KEY (Stakeholder_id) REFERENCES Stakeholder(stakeholder_id),
	FOREIGN KEY (concesso_da) REFERENCES squadra(squadra_id)
);

CREATE TABLE personale (
	personale_id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	cognome VARCHAR(50) NOT NULL,
	mansione VARCHAR(50) NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	FOREIGN KEY (stakeholder_id) REFERENCES stakeholder(stakeholder_id)
);

CREATE TABLE esterno (
	esterno_id SERIAL PRIMARY KEY,
	tipo_esterno VARCHAR(50) NOT NULL CHECK (tipo_esterno IN ('Cliente', 'Fornitore', 'Cliente-fornitore')),
	ragione_sociale VARCHAR(100) NOT NULL,
	cf_piva VARCHAR(50) NOT NULL,
	soggetto_nis2 BOOLEAN NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	FOREIGN KEY (stakeholder_id) REFERENCES Stakeholder(stakeholder_id)
);

CREATE TABLE vulnerabilita (
	Vulnerabilita_id SERIAL PRIMARY KEY,
	esterno_id INTEGER NOT NULL,
	nome_vulnerabilita VARCHAR(100) NOT NULL,
	gravita VARCHAR(50) NOT NULL CHECK (gravita IN ('Minima', 'Bassa', 'Media','Alta')),
	note TEXT,
	FOREIGN KEY (esterno_id) REFERENCES esterno(esterno_id)
);

CREATE TABLE piano_formazione (
	piano_id SERIAL PRIMARY KEY,
	contenuto VARCHAR(255) NOT NULL,
	descrizione VARCHAR(255),
	data_creazione DATE NOT NULL,
	specializzato BOOLEAN NOT NULL,
	approvato BOOLEAN NOT NULL
);

CREATE TABLE formazione (
	personale_id INTEGER NOT NULL,
	piano_id INTEGER NOT NULL,
	data_formazione DATE NOT NULL,
	mod_verifica VARCHAR(255),
	PRIMARY KEY (personale_id, piano_id),
	FOREIGN KEY (personale_id) REFERENCES personale(personale_id),
	FOREIGN KEY (piano_id) REFERENCES piano_formazione(piano_id)
);

CREATE TABLE squadra_stakeholder (
	squadra_id INTEGER NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	ruolo VARCHAR(50) NOT NULL CHECK (ruolo IN ('Responsible', 'Accountable', 'Consulted','Informed')),
	PRIMARY KEY (squadra_id, stakeholder_id, ruolo),
	FOREIGN KEY (squadra_id) REFERENCES squadra(squadra_id),
	FOREIGN KEY (stakeholder_id) REFERENCES Stakeholder(stakeholder_id)
);

CREATE TABLE nomina (
	nomina_id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	descrizione TEXT NOT NULL,
	dati VARCHAR(50) NOT NULL CHECK (dati IN('Dati pubblici','Dati sensibili','Dati riservati')),
	data_inizio DATE NOT NULL,
	data_fine DATE,
	link_documento TEXT NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	sostituto INTEGER NOT NULL,
	FOREIGN KEY (stakeholder_id) REFERENCES stakeholder(stakeholder_id),
	FOREIGN KEY (sostituto) REFERENCES stakeholder(stakeholder_id)
);

CREATE TABLE raci (
	raci_id SERIAL PRIMARY KEY,
	nome VARCHAR(200)
);

CREATE TABLE ruolo_raci (
	raci_id INTEGER NOT NULL,
	nomina_id INTEGER NOT NULL,
	ruolo VARCHAR(50) NOT NULL CHECK (ruolo IN ('Responsible', 'Accountable', 'Consulted','Informed')),
	PRIMARY KEY (raci_id, nomina_id, ruolo),
	FOREIGN KEY (raci_id) REFERENCES raci(raci_id),
	FOREIGN KEY (nomina_id) REFERENCES nomina(nomina_id)
);

CREATE TABLE attivita (
	attivita_id SERIAL PRIMARY KEY,
	asset_id INTEGER,
	tipologia VARCHAR(50) NOT NULL CHECK (tipologia IN ('Installazione', 'Monitoraggio', 'Aggiornamento','Test vulnerabilità','Miglioramento attuato',
	'Backup effettuato','Test backup effettuato','Ripristino backup','Comunicazione attività','Dismissione','Trasferimento', 'Ripristino', 'Isolamento', 'Continuità', 'Altro')),
	nome VARCHAR(100) NOT NULL,
	Procedimento TEXT NOT NULL,
	data_inizio DATE NOT NULL,
	data_fine DATE,
	link_documento TEXT,
	esito TEXT NOT NULL,
	squadra_id INTEGER NOT NULL,
	note TEXT,
	FOREIGN KEY (asset_id) REFERENCES asset(asset_id),
	FOREIGN KEY (squadra_id) REFERENCES squadra(squadra_id)
);

CREATE TABLE installazione (
	installazione_id SERIAL PRIMARY KEY,
	attivita_id INTEGER NOT NULL,
	asset_su_cui_e_installato INTEGER NOT NULL,
	FOREIGN KEY (attivita_id) REFERENCES attivita(attivita_id),
	FOREIGN KEY (asset_su_cui_e_installato) REFERENCES asset(asset_id)
);

CREATE TABLE monitoraggio (
	monitoraggio_id SERIAL PRIMARY KEY,
	attivita_id INTEGER NOT NULL,
	metrica VARCHAR(100) NOT NULL,
	valore REAL NOT NULL,
	FOREIGN KEY (attivita_id) REFERENCES attivita(attivita_id)
);

CREATE TABLE test_vulnerabilita (
	test_id SERIAL PRIMARY KEY,
	attivita_id INTEGER NOT NULL,
	tipo_test VARCHAR(40) NOT NULL CHECK (tipo_test IN ('Penetration test', 'Vulnerability assessment')),
	FOREIGN KEY (attivita_id) REFERENCES attivita(attivita_id)
);

CREATE TABLE miglioramento (
	miglioramento_id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	descrizione TEXT NOT NULL,
	scopo TEXT NOT NULL,
	stato VARCHAR(50) NOT NULL CHECK (stato IN ('Da attuare', 'In corso di attuazione', 'Attuato','Dismesso','Parzialmente attuato')),
	priorita VARCHAR(50)NOT NULL CHECK (priorita IN ('Bassa', 'Media', 'Alta')),
	scadenza DATE,
	raci_id INTEGER NOT NULL,
	note TEXT,
	FOREIGN KEY (raci_id) REFERENCES raci(raci_id)
);

CREATE TABLE miglioramento_attuato (
	miglioramento_att_id SERIAL PRIMARY KEY,
	attivita_id INTEGER NOT NULL,
	miglioramento_id INTEGER NOT NULL,
	FOREIGN KEY (attivita_id) REFERENCES attivita(attivita_id),
	FOREIGN KEY (miglioramento_id) REFERENCES miglioramento(miglioramento_id)
);

CREATE TABLE backup_eff (
	backup_id SERIAL PRIMARY KEY,
	attivita_id INTEGER NOT NULL,
	tipo_backup VARCHAR(50) NOT NULL CHECK (tipo_backup IN ('Completo', 'Incrementale','Differenziale')),
	backup_pos VARCHAR(100) NOT NULL CHECK (backup_pos IN ('Localmente', 'Remoto', 'In cloud')),
	cifratura BOOLEAN NOT NULL,
	FOREIGN KEY (attivita_id) REFERENCES attivita(attivita_id)
);

CREATE TABLE test_backup (
	test_backup_id SERIAL PRIMARY KEY,
	asset_id INTEGER NOT NULL,
	backup_testato INTEGER NOT NULL,
	FOREIGN KEY (asset_id) REFERENCES asset(asset_id),
	FOREIGN KEY (backup_testato) REFERENCES backup_eff(backup_id)
);

CREATE TABLE comunicazione_attivita (
	comunicazione_id SERIAL PRIMARY KEY,
	attivita_id INTEGER NOT NULL,
	direzione VARCHAR(50) NOT NULL CHECK (direzione IN ('Interna', 'Esterna')),
	tipo_comunicazione VARCHAR(200) NOT NULL,
	comunicazione TEXT NOT NULL,
	destinatari TEXT NOT NULL,
	canale_trasmissione VARCHAR(100) NOT NULL,
	FOREIGN KEY (attivita_id) REFERENCES attivita(attivita_id)
);

CREATE TABLE attivita_successiva (
	attivita_partenza INTEGER NOT NULL,
	attivita_seguente INTEGER NOT NULL,
	PRIMARY KEY (attivita_partenza,attivita_seguente),
	FOREIGN KEY (attivita_partenza) REFERENCES attivita(attivita_id),
	FOREIGN KEY (attivita_seguente) REFERENCES attivita(attivita_id)
);

CREATE TABLE procedura (
	procedura_id SERIAL PRIMARY KEY,
	raci_id INTEGER NOT NULL,
	finalita VARCHAR(255) NOT NULL,
	tipologia VARCHAR(100) NOT NULL CHECK (tipologia IN ('Installazione','Monitoraggio','Aggiornamento','Test vulnerabilità','Backup','Test backup',
	'Riprisitno backup','Comunicazione','Dismissione','Trasferimento','Ripristino','Isolamento','Continuità','Altro')),
	nome VARCHAR(255) NOT NULL,
	procedimento TEXT NOT NULL,
	con_attivazione TEXT NOT NULL,
	con_disattivazione TEXT NOT NULL,
	proced_report TEXT NOT NULL,
	data_creazione DATE NOT NULL,
	data_dismissione DATE,
	link_documento TEXT NOT NULL,
	approvato BOOLEAN NOT NULL,
	FOREIGN KEY (raci_id) REFERENCES raci(raci_id)
);

CREATE TABLE asset_procedura (
	risorse_id INTEGER NOT NULL,
	Procedura_id INTEGER NOT NULL,
	PRIMARY KEY (risorse_id, procedura_id),
	FOREIGN KEY (risorse_id) REFERENCES asset(asset_id),
	FOREIGN KEY (procedura_id) REFERENCES procedura(procedura_id)
);

CREATE TABLE comunicazione_procedura (
	comunicazione_id SERIAL PRIMARY KEY,
	procedura_id INTEGER NOT NULL,
	direzione VARCHAR(50) NOT NULL CHECK (direzione IN ('Interna','Esterna')),
	tipo_comunicazione VARCHAR(200) NOT NULL,
	comunicazione TEXT NOT NULL,
	destinatari TEXT NOT NULL,
	canale_trasmissione VARCHAR(100) NOT NULL,
	FOREIGN KEY (procedura_id) REFERENCES procedura(procedura_id)
);

CREATE TABLE procedura_successiva (
	procedura_partenza INTEGER NOT NULL,
	procedura_seguente INTEGER NOT NULL,
	PRIMARY KEY (procedura_partenza,procedura_seguente),
	FOREIGN KEY (procedura_partenza) REFERENCES procedura(procedura_id),
	FOREIGN KEY (procedura_seguente) REFERENCES procedura(procedura_id)
);

CREATE TABLE ripristino (
	ripristino_id SERIAL PRIMARY KEY,
	procedura_id INTEGER NOT NULL,
	tempo_ripristino INTERVAL,
	costi_ripristino REAL,
	FOREIGN KEY (procedura_id) REFERENCES procedura(procedura_id)
);

CREATE TABLE rischio (
	rischio_id SERIAL PRIMARY KEY,
	test_vulnerabilita_id INTEGER,
	nome VARCHAR(255) NOT NULL,
	data_rilevazione DATE,
	tipologia_rischio VARCHAR(100) NOT NULL CHECK (tipologia_rischio IN ('Cyber/informatico', 'Operativo/tecnico', 'Umano','Terze parti','Fisico/ambientale','Altro')),
	descrizione TEXT NOT NULL,
	analisi_rischio_prob VARCHAR(50) NOT NULL CHECK (analisi_rischio_prob IN ('Minima', 'Bassa', 'Media','Alta')),
	analisi_rischio_grav VARCHAR(50) NOT NULL CHECK (analisi_rischio_grav IN ('Minima', 'Bassa', 'Media','Alta')),
	stato VARCHAR(50) NOT NULL CHECK (stato IN ('Attivo', 'Eliminato', 'Mitigato','Trasferito','Accettato')),
	note TEXT,
	FOREIGN KEY (test_vulnerabilita_id) REFERENCES test_vulnerabilita(test_id)
);

CREATE TABLE rischio_miglioramenti (
	rischio_id INTEGER NOT NULL,
	miglioramento_id INTEGER NOT NULL,
	PRIMARY KEY (rischio_id, miglioramento_id),
	FOREIGN KEY (rischio_id) REFERENCES rischio(rischio_id),
	FOREIGN KEY (miglioramento_id) REFERENCES miglioramento(miglioramento_id)
);

CREATE TABLE crisi (
	crisi_id SERIAL PRIMARY KEY,
	squadra_id INTEGER NOT NULL,
	tipologia_crisi VARCHAR(100) NOT NULL CHECK (tipologia_crisi IN ('Cyber/informatico', 'Operativo/tecnico', 'Umano','Terze parti','Fisico/ambientale','Altro')),
	data_inizio DATE NOT NULL,
	data_fine DATE,
	descrizione TEXT NOT NULL,
	report TEXT NOT NULL,
	causa TEXT,
	conseguenze TEXT,
	gravita VARCHAR(50) NOT NULL CHECK (gravita IN ('Bassa', 'Media', 'Alta')),
	stato VARCHAR(50) NOT NULL CHECK (stato IN ('In corso', 'In fase di elaborazione', 'Mitigata','Annullata')),
	FOREIGN KEY (squadra_id) REFERENCES squadra(squadra_id)
);

CREATE TABLE mitigare_crisi (
	attivita_id INTEGER NOT NULL,
	crisi_id INTEGER NOT NULL,
	PRIMARY KEY (attivita_id, crisi_id),
	FOREIGN KEY (attivita_id) REFERENCES attivita(attivita_id),
	FOREIGN KEY (crisi_id) REFERENCES crisi(crisi_id)
);

-- Storico / Versioning

CREATE TABLE asset_storico (
	asset_id INTEGER,
	nome VARCHAR(255) NOT NULL,
	funzionalita VARCHAR(255) NOT NULL,
	aggiorn_manuale BOOLEAN NOT NULL,
	stato VARCHAR(50) NOT NULL CHECK (stato IN ('Attivo', 'In dismissione', 'Dismesso')),
	configurazione TEXT,
	macroarea VARCHAR(50) NOT NULL,
	criticita VARCHAR(50) NOT NULL CHECK (criticita IN ('Minima','Bassa','Media','Alta')),
	storico_id SERIAL PRIMARY KEY,
	data_modifica DATE,
	tipo_operazione VARCHAR(50)
);

CREATE TABLE fornitura_storico (
	fornitura_id INTEGER,
	tipo_fornitura VARCHAR(50) NOT NULL CHECK (tipo_fornitura IN ('Vendita','Acquisto')),
	tipologia VARCHAR(50) NOT NULL,
	nome VARCHAR(100),
	data_inizio DATE NOT NULL,
	data_fine DATE,
	livello_criticita VARCHAR(50) NOT NULL CHECK (livello_criticita IN ('Minimo', 'Basso', 'Medio','Alto')),
	asset_id INTEGER,
	stakeholder_id INTEGER NOT NULL,
	storico_id SERIAL PRIMARY KEY,
	data_modifica DATE,
	tipo_operazione VARCHAR(50)
);

CREATE TABLE utenze_storico (
	utenze_id  INTEGER,
	asset_id INTEGER NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	data_inizio DATE NOT NULL,
	data_fine DATE,
	credenziali BOOLEAN NOT NULL,
	tipo_accesso VARCHAR(50) NOT NULL CHECK (tipo_accesso IN ('Da remoto', 'In sede')),
	tempo_conservazione_log INTERVAL NOT NULL,
	concesso_da INTEGER NOT NULL,
	modalita_accesso TEXT NOT NULL,
	storico_id SERIAL PRIMARY KEY,
	data_modifica DATE,
	tipo_operazione VARCHAR(50)
);

CREATE TABLE personale_storico (
	personale_id  INTEGER,
	nome VARCHAR(50) NOT NULL,
	cognome VARCHAR(50) NOT NULL,
	mansione VARCHAR(50) NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	storico_id SERIAL PRIMARY KEY,
	data_modifica DATE,
	tipo_operazione VARCHAR(50)
);

CREATE TABLE esterno_storico (
	esterno_id  INTEGER,
	tipo_esterno VARCHAR(50) NOT NULL CHECK (tipo_esterno IN ('Cliente', 'Fornitore', 'Cliente-fornitore')),
	ragione_sociale VARCHAR(100) NOT NULL,
	cf_piva VARCHAR(50) NOT NULL,
	soggetto_nis2 BOOLEAN NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	storico_id SERIAL PRIMARY KEY,
	data_modifica DATE,
	tipo_operazione VARCHAR(50)
);

CREATE TABLE nomina_storico (
	nomina_id  INTEGER,
	nome VARCHAR(255) NOT NULL,
	descrizione TEXT NOT NULL,
	dati VARCHAR(50) NOT NULL,
	data_inizio DATE NOT NULL,
	data_fine DATE,
	link_documento TEXT NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	sostituto INTEGER NOT NULL,
	storico_id SERIAL PRIMARY KEY,
	data_modifica DATE,
	tipo_operazione VARCHAR(50)
);

CREATE TABLE stakeholder_storico (
	stakeholder_id  INTEGER,
	email_referente VARCHAR(50) NOT NULL,
	telefono_referente VARCHAR(50) NOT NULL,
	storico_id SERIAL PRIMARY KEY,
	data_modifica DATE,
	tipo_operazione VARCHAR(50)
);

CREATE TABLE squadra_stakeholder_storico (
	squadra_id INTEGER NOT NULL,
	stakeholder_id INTEGER NOT NULL,
	ruolo VARCHAR(50) NOT NULL CHECK (ruolo IN ('Responsible', 'Accountable', 'Consulted','Informed')),
	storico_id SERIAL PRIMARY KEY,
	data_modifica DATE,
	tipo_operazione VARCHAR(50)
);