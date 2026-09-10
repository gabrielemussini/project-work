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
	Squadra int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID),
	FOREIGN KEY (Squadra) REFERENCES squadra(SquadraID)
);

CREATE TABLE riesame(
	RiesameID int AUTO_INCREMENT PRIMARY KEY,
	DataRiesame DATE,
	Descrizione text(max),
	Esito text(max),
	LinkDocumenti text(max),
	Squadra int,
	FOREIGN KEY (Squadra) REFERENCES squadra(SquadraID)
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
	FOREIGN KEY (AutorizzatoDa) REFERENCES squadra(SquadraID)
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
	FOREIGN KEY (ConcessoDa) REFERENCES squadra(SquadraID)
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

CREATE TABLE esterno (
	EsternoID int AUTO_INCREMENT PRIMARY KEY,
	TipoEsterno varchar(20),
	RagioneSociale varchar(100),
	CFPIVA varchar(30),
	SoggettoNIS2 BOOLEAN,
	Stakeholder int,
	FOREIGN KEY (Stakeholder) REFERENCES stakeholder(StakeholderID)
);

CREATE TABLE vulnerabilita (
	VulnerabilitaID int AUTO_INCREMENT PRIMARY KEY,
	Esterno int,
	NomeVulnerabilita varchar(100),
	Gravita varchar(20),
	Note text(max),
	FOREIGN KEY (Esterno) REFERENCES esterno(EsternoID)
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
	Approvato BOOLEAN
);

CREATE TABLE squadra_stakeholder (
	OperStakID int AUTO_INCREMENT PRIMARY KEY,
	Squadra int,
	Stakeholder int,
	Ruolo varchar(20),
	FOREIGN KEY Squadra REFERENCES squadra(SquadraID),
	FOREIGN KEY Stakehodler REFERENCES stakeholder(StakeholderID)
);

CREATE TABLE squadra (
	SquadraID int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar(100)
);

CREATE TABLE nomina (
	NominaID int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar(255),
	Descrizione text(max),
	Dati varchar(20),
	DataInizio DATE,
	DataFine DATE,
	LinkDocumenti text(max),
	Stakeholder int,
	Sostituto int,
	FOREIGN KEY (Stakeholder) REFERENCES stakeholder(StakeholderID),
	FOREIGN KEY (Sostituto) REFERENCES stakeholder(StakeholderID)
);

CREATE TABLE ruolo_raci (
	Raci int NOT NULL,
	Nomina int NOT NULL,
	Ruolo varchar(20),
	PRIMARY KEY (Raci, Nomina),
	FOREIGN KEY Raci REFERENCES raci(RaciID),
	FOREIGN KEY Nomina REFERENCES nomina(NominaID)
);

CREATE TABLE raci (
	RaciID int AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE attivita (
	Attivita int AUTO_INCREMENT PRIMARY KEY,
	Asset int,
	Tipologia varchar(50),
	Nome varchar(100),
	Procedimento text(max),
	DataInizio DATE,
	DataFine DATE,
	LinkDocumento text(max),
	Esito text(max),
	Squadra int,
	Note text(max),
	FOREIGN KEY Asset REFERENCES asset(AssetID),
	FOREIGN KEY Squadra REFERENCES squadra(SquadraID)
);

CREATE TABLE installazione (
	InstallazioneID int AUTO_INCREMENT PRIMARY KEY,
	Attivita int,
	AssetSuCuiEInstallato int,
	FOREIGN KEY Attivita REFERENCES attivita(AttivitaID),
	FOREIGN KEY AssetSuCuiEInstallato REFERENCES asset(AssetID)
);

CREATE TABLE installazione (
	InstallazioneID int AUTO_INCREMENT PRIMARY KEY,
	Attivita int,
	AssetSuCuiEInstallato int,
	FOREIGN KEY Attivita REFERENCES attivita(AttivitaID),
	FOREIGN KEY AssetSuCuiEInstallato REFERENCES asset(AssetID)
);

CREATE TABLE monitoraggio (
	MonitoraggioID int AUTO_INCREMENT PRIMARY KEY,
	Attivita int,
	Metrica varchar(100),
	Valore real,
	FOREIGN KEY Attivita REFERENCES attivita(AttivitaID)
);

CREATE TABLE test_vulnerabilita (
	TestID int AUTO_INCREMENT PRIMARY KEY,
	Attivita int,
	TipoTest varchar(40),
	FOREIGN KEY Attivita REFERENCES attivita(AttivitaID)
);

CREATE TABLE miglioramento_attuato (
	MiglioramentoAttID int AUTO_INCREMENT PRIMARY KEY,
	Attivita int,
	Miglioramento int,
	FOREIGN KEY Attivita REFERENCES attivita(AttivitaID),
	FOREIGN KEY Miglioramento REFERENCES miglioramento(MiglioramentoID)
);

CREATE TABLE backupEff (
	BackupID int AUTO_INCREMENT PRIMARY KEY,
	Attivita int,
	TipoBackup varchar(50),
	BackupPos varchar(100),
	Cifratura BOOLEAN,
	FOREIGN KEY Attivita REFERENCES attivita(AttivitaID)
);

CREATE TABLE test_backup(
	TestBackupID int AUTO_INCREMENT PRIMARY KEY,
	Asset int,
	BackupTestato int,
	FOREIGN KEY (Asset) REFERENCES asset(AssetID),
	FOREIGN KEY (BackupTestato) REFERENCES backupEff(BackupID)
);

CREATE TABLE comunicazione_attivita(
	ComunicazioneID int AUTO_INCREMENT PRIMARY KEY,
	Asset int,
	TipoComunicazione varchar(20),
	Destinatari text(max),
	CanaleTrasmissione varchar(100),
	FOREIGN KEY (Asset) REFERENCES asset(AssetID)
);

CREATE TABLE procedura (
	ProceduraID int AUTO_INCREMENT PRIMARY KEY,
	Raci int,
	Finalita varchar(255),
	Tipologia Varchar(100),
	Nome varchar(255),
	Procedimento text(max),
	ConAttivazione text(max),
	ConDisattivazione text(max),
	ProcedReport text(max),
	DataCreazione DATE,
	DataDimissione DATE,
	LinkDocumento text(max),
	Approvato BOOLEAN,
	FOREIGN KEY (Raci) REFERENCES raco(RaciID)
);

CREATE TABLE asset_procedura (
	Risorse int NOT NULL,
	Procedura int NOT NULL,
	PRIMARY KEY (Risorse, Procedura),
	FOREIGN KEY Risorse REFERENCES asset(AssetID),
	FOREIGN KEY Procedura REFERENCES procedura(ProceduraID)
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

