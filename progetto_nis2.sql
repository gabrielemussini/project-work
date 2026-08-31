CREATE TYPE stato_asset as ENUM ('Attivo', 'In dismissione', 'Dismesso');

CREATE TABLE asset (
	AssetID int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar(255),
	Funzionlita varchar(255),
	Trasferimento varchar(255),
	Dismissione varchar(255),
	Stato stato_asset,
	Configurazione text (max),
	AccessoRemoto BOOLEAN,
	);

CREATE TABLE hardware (
	HardwareID int AUTO_INCREMENT PRIMARY KEY,
	Categoria varchar(255),
	Mac varchar(8),
	IP varchar (15),
	Produttore varchar(255),
	Posizione varchar(255),
	Asset int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
	);

CREATE TABLE software (
	SoftwareID int AUTO_INCREMENT PRIMARY KEY,
	installazione text (max),
	TipoLicenza varchar (255),
	Categoria varchar(255),
	AggiornAuto BOOLEAN,
	DataAggiorn DATE,
	SviluppoSicuro text (max),
	Asset int,
	FOREIGN KEY (Asset)	REFERENCES asset(AssetID)
	);

CREATE TABLE database (
	DatabaseID int AUTO_INCREMENT PRIMARY KEY,
	Contenuto varchar (255),
	Riservatezza varchar (255),
	Posizione text (max),
	Asset int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
);

CREATE TABLE non_sistema(
	NonSistemaID int AUTO_INCREMENT PRIMARY KEY,
	Categoria varchar (255),
	Asset int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
);

CREATE TABLE fornitura(
	FornituraID int AUTO_INCREMENT PRIMARY KEY,
	Tipologia varchar(255),
	Nome varchar(255),
	DataInizio DATE,
	DataFine DATE,
	Asset int,
	Stakeholder int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID),
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

CREATE TABLE flussi_rete(
	FlussoID int AUTO_INCREMENT PRIMARY KEY,
	Tipo varchar(255)
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

CREATE TABLE requisiti_sicurezza_forn (
	RequisitiID int AUTO_INCREMENT PRIMARY KEY,
	Fornitore int,
	Ambito varchar(255),
	Verificato BOOLEAN,
	DataVerifica DATE,
	FOREIGN KEY (Fornitore) REFERENCES fornitori(FornitoreID)
);

CREATE TABLE utenze (
	UtenzeID int AUTO_INCREMENT PRIMARY KEY,
	Asset int,
	Stakeholder int,
	DataInizio DATE,
	DataFine DATE,
	Credenziali BOOLEAN,
	AccessoRemoto BOOLEAN,
	AccessoFisico BOOLEAN,
	Ruolo varchar(255),
	ConcessoDa int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID),
	FOREIGN KEY (Stakehodler) REFERENCES stakeholder(StakeholderID),
	FOREIGN KEY (ConcessoDa) REFERENCES stakeholder(StakeholderID)
);

CREATE TABLE stakeholder (
	StakehodlerID int AUTO_INCREMENT PRIMARY KEY,
	LinkDocumenti text(max),
	AccessoSistemInfo: BOOLEAN,
	AcessoPropIntell: BOOLEAN
);

CREATE TABLE personale (
	PersonaleID int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar(255),
	Cognome varchar(255),
	Email varchar(255),
	Telefono varchar(255),
	Mansione varchar(255),
	Ruolo varchar(255),
	Stakeholder int,
	FOREIGN KEY (Stakeholder) REFERENCES stakeholder(StakehodlerID)
);

CREATE TABLE fornitori (
	FornitoreID int AUTO_INCREMENT PRIMARY KEY,
	RagioneSociale varchar(255),
	CFPIVA varchar(255),
	LivelloCriticita int,
	CriterioCriticita varchar(255),
	TelefonoReferente varchar(255),
	EmailReferente varchar(255),
	SoggettoNIS2 BOOLEAN,
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

