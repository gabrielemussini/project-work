CREATE TYPE stato_asset as ENUM ('Attivo', 'In dismissione', 'Dismesso');

CREATE TABLE hardware (
	HardwareID int AUTO_INCREMENT PRIMARY KEY,
	Categoria varchar(20),
	Mac varchar(8),
	IP varchar (15),
	Produttore varchar(255),
	Posizione varchar(255),
	Asset int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
	);

CREATE TABLE software (
	SoftwareID int AUTO_INCREMENT PRIMARY KEY,
	TipoLicenza varchar (20),
	Categoria varchar(20),
	SviluppoSicuro text (max),
	Asset int,
	FOREIGN KEY (Asset)	REFERENCES asset(AssetID)
	);

CREATE TABLE database (
	DatabaseID int AUTO_INCREMENT PRIMARY KEY,
	Contenuto varchar (255),
	Riservatezza varchar (20),
	Posizione varchar (20),
	Asset int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
);

CREATE TABLE servizi(
	NonSistemaID int AUTO_INCREMENT PRIMARY KEY,
	Categoria varchar (20),
	Asset int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
);

CREATE TABLE asset (
	AssetID int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar(255),
	Funzionlita varchar(255),
	AggiornAuto: BOOLEAN,
	Stato stato_asset,
	Configurazione text (max)
	);

CREATE TABLE macroarea (
	MacroareaID int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar(50),
	Descrizione text(max),
	Rilevanza varchar(20)
	);

CREATE TABLE fornitura(
	FornituraID int AUTO_INCREMENT PRIMARY KEY,
	TipoFornitura varchar(20),
	Tipologia varchar(50),
	Nome varchar(100),
	DataFornitura DATE,
	Asset int,
	Stakeholder int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID),
	FOREIGN KEY (Stakeholder) REFERENCES stakeholder(StakeholderID) 
);

CREATE TABLE livello_atteso(
	LivelloAttesoID int AUTO_INCREMENT PRIMARY KEY,
	Asset int,
	Metrica varchar(100),
	SogliaAllertaMax real,
	SogliaAllertaMin real,
	Raci int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID),
	FOREIGN KEY (Raci) REFERENCES raci(RaciID)
);

CREATE TABLE riesame(
	RiesameID int AUTO_INCREMENT PRIMARY KEY,
	DataRiesame DATE,
	Descrizione text(max),
	Esito text(max),
	LinkDocumenti text(max),
	Raci int,
	FOREIGN KEY (Raci) REFERENCES raci(RaciID)
);

CREATE TABLE flussi_rete(
	FlussoID int AUTO_INCREMENT PRIMARY KEY,
	EntitaOrigine varchar(100),
	AssetOrigine int,
	StakeholderOrigine int,
	EntitaDestinazione varchar(100),
	AssetDestiazione int,
	StakeholderDestinazione int,
	Direzione varchar(20),
	Scopo varchar(255),
	AutorizzatoDa int,
	DataAutorizzazione DATE,
	Stato stato_asset,
	FOREIGN KEY (AssetOrigine) REFERENCES asset(AssetID),
	FOREIGN KEY (StakeholderOrigine) REFERENCES stakeholder(StakehodlerID),
	FOREIGN KEY (AssetDestinazione) REFERENCES asset(AssetID),
	FOREIGN KEY (StakeholderDestinazione) REFERENCES stakeholder(StakehodlerID),
	FOREIGN KEY (AutorizzatoDa) REFERENCES raci(RaciID)
);

CREATE TABLE utenze (
	UtenzeID int AUTO_INCREMENT PRIMARY KEY,
	Asset int,
	Stakeholder int,
	DataInizio DATE,
	DataFine DATE,
	Credenziali BOOLEAN,
	TipoAccesso varchar(20),
	TempoConservazioneLog DATE,
	ConcessoDa int,
	ModalitaAccesso text(max),
	FOREIGN KEY (Asset) REFERENCES asset(AssetID),
	FOREIGN KEY (Stakehodler) REFERENCES stakeholder(StakeholderID),
	FOREIGN KEY (ConcessoDa) REFERENCES raci(RaciID)
);

CREATE TABLE stakeholder (
	StakehodlerID int AUTO_INCREMENT PRIMARY KEY
	Email varchar(30),
	Telefono varchar(20),
);

CREATE TABLE personale (
	PersonaleID int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar(50),
	Cognome varchar(50),
	Mansione varchar(50),
	Stakeholder int,
	FOREIGN KEY (Stakeholder) REFERENCES stakeholder(StakehodlerID)
);

CREATE TABLE fornitori (
	FornitoreID int AUTO_INCREMENT PRIMARY KEY,
	RagioneSociale varchar(100),
	CFPIVA varchar(30),
	SoggettoNIS2 BOOLEAN,
	Stakeholder int,
	FOREIGN KEY (Stakeholder) REFERENCES stakeholder(StakeholderID)
);

CREATE TABLE vulnerabilita_forn (
	VulnerabilitaID int AUTO_INCREMENT PRIMARY KEY,
	Fornitore int,
	NomeVulnerabilita varchar(100),
	Gravita varchar(20),
	Note text(max),
	FOREIGN KEY (Fornitore) REFERENCES fornitori(FornitoreID)
);

CREATE TABLE clienti (
	ClientiID int AUTO_INCREMENT PRIMARY KEY,
	RagioneSociale varchar(100),
	CFPIVA varchar(30),
	SoggettoNIS2 BOOLEAN,
	Stakeholder int,
	FOREIGN KEY (Stakeholder) REFERENCES stakeholder(StakeholderID)
);

CREATE TABLE test_backup(
	TestBackupID int AUTO_INCREMENT PRIMARY KEY,
	Asset int,
	DataTest DATE,
	Esito BOOLEAN,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
);

CREATE TABLE manutenzione(
	ManutenzioneID int AUTO_INCREMENT PRIMARY KEY,
	Asset int,
	DataMan DATE,
	DescManutenzione text(max),
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
);

CREATE TABLE monitoraggio(
	MonitoraggioID int AUTO_INCREMENT PRIMARY KEY,
	Asset int,
	DataMon DATE,
	Esito BOOLEAN,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
);

CREATE TABLE rischio_asset (
	Asset int NOT NULL,
	Valutazione int NOT NULL,
	PRIMARY KEY (Asset, Valutazione),
	FOREIGN KEY (Asset) REFERENCES asset(AssetID),
	FOREIGN KEY (Valutazione) REFERENCES valutazione_rischio(ValutazioneID) 
);

CREATE TABLE nomina (
	NominaID int AUTO_INCREMENT PRIMARY KEY,
	Ruolo varchar(255),
	Descrizione text(max),
	DataInizio DATE,
	DataFine DATE,
	LinkDocumenti text(max),
	Stakeholder int,
	FOREIGN KEY (Stakeholder) REFERENCES stakeholder(StakeholderID)
);

CREATE TABLE valutazione_rischio (
	ValutazioneID int AUTO_INCREMENT PRIMARY KEY,
	ResponsabileValutaz int,
	DataVal DATE,
	Test varchar(255),
	Rischio int,
	FOREIGN KEY (ResponsabileValutaz) REFERENCES nomina(NominaID),
	FOREIGN KEY (Rischio) REFERENCES rischio(RischioID)
);

CREATE TABLE rischio (
	RischioID int AUTO_INCREMENT PRIMARY KEY,
	Denominazione varchar(255),
	TipologiaRischio varchar(255),
	AnalisiRIschioProb int,
	AnalisiRischioGrav int,
	LinkDocumentiVal text(max),
	PonderazioneRischioSpiegazione varchar(255),
	PonderazioneRischioTipo varchar(255),
	TrattamentoRischioResponsabile int,
	TrattamentoRischioScadenza DATE,
	TrattamentoRischioAzione varchar(255),
	StatoTrattRischio varchar(255),
	FOREIGN KEY TrattamentoRischioResponsabile REFERENCES stakeholder(StakeholderID)
);

CREATE TABLE formazione (
	Personale int NOT NULL,
	Piano int NOT NULL,
	DataFormazione DATE,
	ModVerifica varchar(255),
	PRIMARY KEY (Personale, Piano),
	FOREIGN KEY Personale REFERENCES personale(PersonaleID),
	FOREIGN KEY Piano REFERENCES piano_formazione(PianoID)
);

CREATE TABLE piano_formazione(
	PianoID int AUTO_INCREMENT PRIMARY KEY,
	Contenuto varchar(255),
	Descrizione varchar(255),
	DataCreazione DATE,
	Specializzato BOOLEAN,
);

CREATE TABLE gestione_crisi(
	GestioneID int AUTO_INCREMENT PRIMARY KEY,
	Rischio int,
	ProceduraNotifiche text(max),
	ProceduraComunInt text(max),
	ProceduraComunEst text(max),
	ProceduraReport text(max),
	ModalitaComm text(max),
	Responsabile int,
	FOREIGN KEY Rischio REFERENCES rischio(RischioID),
	FOREIGN KEY Responsabile REFERENCES stakeholder(StakehodlerID)
);

