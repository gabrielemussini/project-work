INSERT INTO asset (nome, funzionalita, aggiorn_manuale, stato, configurazione, macroarea, criticita) VALUES
('Server DELL PowerEdge R450', 'Funzionamento gestionale interno', FALSE, 'Attivo', 'Z:/config/server/Poweredge450', 'Infrastruttura IT', 'Alta'),
('CRM Clienti', 'Archiviazione dati anagrafici e contrattuali clienti', FALSE, 'Attivo', 'Z:/config/db/crmclienti', 'Gestione Dati', 'Alta'),
('RLK8-811B4', 'Sistema di videosorveglianza', TRUE, 'Attivo', 'Z:/config/NVR/RLK8', 'Sicurezza Fisica', 'Media'),
('Server DELL R760', 'Vecchio server per Backup', TRUE, 'Dismesso', 'Z:/config/server/Poweredge450', 'Infrastruttura IT', 'Minima'),
('Norton 360','Antivirus per PC',FALSE,'Attivo','','Infrastruttura IT','Alta'),
('Hosting Linux','Ospitare il sito aziendale',FALSE,'Attivo','','Infrastruttura IT','Minima');

INSERT INTO stakeholder (email_referente, telefono_referente) VALUES
('m.rossi@azienda.it', '0512345678'),
('l.bianchi@azienda.it', '0519876543'),
('a.verdi@azienda.it', '0511122233'),
('g.neri@azienda.it', '0514455667'),
('contatti@cloudhealth.it', '0221345678'),
('supporto@metalmec.it', '0298765432');

INSERT INTO squadra (nome) VALUES
('Team Sicurezza Informatica'),
('Team Infrastruttura IT'),
('Team Compliance NIS2'),
('Team Gestione Incidenti');

INSERT INTO hardware (categoria, mac, ip, produttore, posizione, asset_id) VALUES
('Server', 'a1b2c3d4', '192.168.1.10', 'Dell', 'Sala server sede centrale', 1),
('NVR', 'b2c3d4e5', '192.168.2.20', 'Hikvision', 'Reception', 3),
('Server', 'c3d4e5f6', '192.168.1.12', 'Dell', 'Magazzino (dismesso)', 4);

INSERT INTO software (tipo_licenza, categoria, sviluppo_sicuro, asset_id) VALUES
('Closed source', 'Antivirus', '', 5);

INSERT INTO database (contenuto, riservatezza, posizione, asset_id) VALUES
('Dati anagrafici clienti', 'Riservato', 'In loco', 2);

INSERT INTO servizi (categoria, asset_id) VALUES
('Hosting', 6);

INSERT INTO personale (nome, cognome, mansione, stakeholder_id) VALUES
('Maria', 'Rossi', 'Titolare', 1),
('Luca', 'Bianchi', 'Tecnico Informatico', 2),
('Anna', 'Verdi', 'Responsabile HR', 3),
('Giulia', 'Neri', 'Responsabile Logistica', 4);

INSERT INTO esterno (tipo_esterno, ragione_sociale, cf_piva, soggetto_nis2, stakeholder_id) VALUES
('Fornitore', 'CloudHealth Srl', 'IT01234567890', TRUE, 5),
('Fornitore', 'MetalMec SpA', 'IT09876543210', FALSE, 6);

INSERT INTO fornitura (tipo_fornitura, tipologia, nome, data_inizio, data_fine, livello_criticita, asset_id, stakeholder_id) VALUES
('Acquisto', 'Hosting cloud', 'Servizio hosting', '2024-01-01', NULL, 'Basso', 6, 5),
('Acquisto', 'Materia prima', 'Acciaio', '2023-06-15', NULL, 'Alto', NULL, 6),
('Acquisto', 'Manutenzione', 'Manutenzione hardware', '2022-01-01', '2025-01-01', 'Minimo', 4, 5);

INSERT INTO vulnerabilita (esterno_id, nome_vulnerabilita, gravita, note) VALUES
(1, 'Accessi senza autentificazione a due fattori', 'Alta', 'Controllare che il fornitore dia la possibilità'),
(2, 'Debolezza gestione dei dati', 'Media', 'In attesa di aggiornamento da parte del fornitore'),
(1, 'Credenziali di default non modificate', 'Bassa', 'Rilevata durante audit interno');

INSERT INTO livello_atteso (asset_id, metrica, soglia_allerta_max, soglia_allerta_min, squadra_id) VALUES
(1, 'Uptime sito web (%)', NULL, 99.5, 2),
(2, 'Tempo risposta query (ms)', 200, NULL, 2),
(3, 'Ore di funzionamento continuo', NULL, 95, 1);

INSERT INTO riesame (data_riesame, descrizione, esito, link_documento, squadra_id) VALUES
('2025-01-15', 'Riesame annuale politiche di sicurezza', 'Politiche confermate con lievi aggiornamenti', 'V:/Doc/riesami/2501', 1),
('2025-05-10', 'Riesame ruoli e responsabilita', 'Aggiornata matrice RACI', 'V:/Doc/riesami/2505', 3),
('2026-01-18', 'Riesame annuale politiche di sicurezza', 'Nessuna modifica necessaria', 'V:/Doc/riesami/2601', 4);


INSERT INTO flussi_rete (entita_origine, asset_origine, stakeholder_origine, entita_destinazione, asset_destinazione, stakeholder_destinazione, direzione, scopo, autorizzato_da, data_autorizzazione, stato) VALUES
('Sito web aziendale', 6, NULL, 'Database Clienti', NULL, 2, 'Monodirezionale', 'Inserire nuovi clienti', 2, '2024-01-05', 'Attivo'),
('Server', 1, NULL, 'Agenzia delle entrate', NULL, NULL, 'Monodirezione', 'Trasmissione fatture elettroniche', 1, '2024-06-20', 'Attivo'),
('Tecnico Informatico', NULL, 2, 'Hosting', 6, 5, 'Bidirezionale', 'Aggiornamento sito internet', 2, '2024-02-01', 'Attivo'),
('Server',4,NULL,'Manutentore server',NULL,5,'Bidirezionale','Manutenzione del server',2,'2023-03-04','In dismissione');

INSERT INTO utenze (asset_id, stakeholder_id, data_inizio, data_fine, credenziali, tipo_accesso, tempo_conservazione_log, concesso_da, modalita_accesso) VALUES
(1, 2, '2023-01-10', NULL, TRUE, 'Da remoto', '2 years', 2, 'VPN aziendale con autenticazione a due fattori'),
(2, 4, '2022-05-01', NULL, TRUE, 'In sede', '2 years', 1, 'Accesso diretto da postazione aziendale'),
(3, 1, '2021-09-01', '2024-09-01', FALSE, '2 years', '2025-09-01', 1, 'Accesso fisico con badge');

INSERT INTO piano_formazione (contenuto, descrizione, data_creazione, specializzato, approvato) VALUES
('Formazione base sicurezza informatica', 'Corso annuale obbligatorio per tutto il personale', '2025-11-01', FALSE, TRUE),
('Formazione avanzata per amministratori di sistema', 'Configurazione sicura sistemi e gestione minacce', '2025-11-15', TRUE, TRUE),
('Simulazione phishing', 'Esercitazione pratica di riconoscimento phishing', '2026-02-01', FALSE, FALSE);

INSERT INTO formazione (personale_id, piano_id, data_formazione, mod_verifica) VALUES
(1, 1, '2025-12-01', 'Test scritto online'),
(2, 1, '2025-12-01', 'Test scritto online'),
(2, 2, '2025-12-10', 'Verifica pratica su configurazione firewall'),
(3, 1, '2025-12-02', 'Test pratico');

INSERT INTO squadra_stakeholder (squadra_id, stakeholder_id, ruolo) VALUES
(1,2, 'Accountable'),
(1,2, 'Responsible'),
(1,3, 'Responsible'),
(1,5, 'Consulted'),
(2,2, 'Accountable'),
(2,2, 'Responsible'),
(2,4, 'Responsible'),
(2,1, 'Informed'),
(2,5, 'Consulted'),
(3,1, 'Accountable'),
(3,2, 'Responsible'),
(4,1, 'Accountable'),
(4,3, 'Responsible'),
(4,4, 'Consulted');

INSERT INTO nomina (nome, descrizione, dati, data_inizio, data_fine, link_documento, stakeholder_id, sostituto) VALUES
('Punto di Contatto NIS2', 'Nomina del punto di contatto per gli adempimenti NIS2', 'Dati riservati', '2025-01-01', NULL, 'Z:doc/nomina/NIS2/puntodicontatto', 1, 2),
('Referente CSIRT', 'Nomina del referente per interlocuzione con CSIRT Italia', 'Dati sensibili', '2025-01-01', NULL, 'Z:doc/nomina/NIS2/csirt', 3, 2),
('Responsabile Compliance NIS2', 'Nomina responsabile adempimenti normativi', 'Dati pubblici', '2024-06-01', NULL, 'Z:doc/nomina/NIS2/cpmliance', 4, 1);

INSERT INTO raci (nome) VALUES
('Team Sicurezza Informatica'),
('Team Infrastruttura IT'),
('Team Compliance NIS2'),
('Team Gestione Incidenti');

INSERT INTO ruolo_raci (raci_id, nomina_id, ruolo) VALUES
INSERT INTO squadra_stakeholder (squadra_id, stakeholder_id, ruolo) VALUES
(1,2, 'Accountable'),
(1,3, 'Responsible'),
(2,2, 'Accountable'),
(2,2, 'Responsible'),
(2,1, 'Informed'),
(3,1, 'Accountable'),
(3,2, 'Responsible'),
(4,1, 'Accountable'),
(4,3, 'Responsible');

INSERT INTO attivita (asset_id, tipologia, nome, Procedimento, data_inizio, data_fine, link_documento, esito, squadra_id, note) VALUES
(1, 'Monitoraggio', 'Monitoraggio continuo server web', 'Controllo automatico uptime e prestazioni tramite tool di monitoring', '2026-01-01', NULL, NULL, 'In corso, nessuna anomalia rilevata', 2, NULL),
(2, 'Backup effettuato', 'Backup giornaliero database clienti', 'Backup automatico incrementale ogni notte', '2026-09-01', '2026-09-01', NULL, 'Backup completato con successo', 2, NULL),
(4, 'Dismissione', 'Dismissione vecchio server di backup', 'Cancellazione sicura dei dati e smaltimento hardware', '2025-01-01', '2025-01-15', NULL, 'Server dismesso e smaltito correttamente', 2, 'Sostituito da soluzione cloud'),
(6, 'Test vulnerabilità', 'Penetration test annuale hosting del sito web', 'Test di sicurezza condotto da team esterno specializzato', '2026-03-01', '2026-03-05', 'Z:doc/penetrationtest/260301', 'Rilevate 2 vulnerabilita minori, risolte', 1, NULL),
(1, 'Installazione', 'Installazione antivirus', 'Installazione antivirus Norton sul server', '2026-02-01', '2026-02-02', NULL, 'Installazione completata', 2, NULL),
(NULL, 'Miglioramento','Migrazione backup su supporti cifrati','Sono stati spostati i backup su NAS cifrati','2026-05-25','2026-05-30',NULL,'Trasferimento riuscito',1,NULL),
(NULL, 'Comunicazione attività','Comunicato esito penetration test','La squadra ha comunicato tramite i canali appositi l''esito del Penetration Test','2026-03-06','2026-03-06',NULL,'Comunicazione riuscita',3,NULL);

INSERT INTO installazione (attivita_id, asset_su_cui_e_installato) VALUES
(5, 5);

INSERT INTO monitoraggio (attivita_id, metrica, valore) VALUES
(1, 'Uptime (%)', 99.98),
(1, 'Tempo di risposta medio (ms)', 120),
(1, 'Numero richieste al secondo', 45);

INSERT INTO test_vulnerabilita (attivita_id, tipo_test) VALUES
(4, 'Penetration test'),
(4, 'Vulnerability assessment');

INSERT INTO miglioramento (nome, descrizione, scopo, stato, priorita, scadenza, raci_id) VALUES
('Rafforzamento autenticazione', 'Implementare MFA su tutti gli accessi remoti', 'Ridurre il rischio di accessi non autorizzati', 'In corso di attuazione', 'Alta', '2026-12-31', 3),
('Aggiornamento piano di formazione', 'Includere modulo su ransomware', 'Aumentare consapevolezza del personale', 'Da attuare', 'Media', '2027-03-31', 4),
('Migrazione backup su cloud cifrato', 'Spostare i backup offline su soluzione cloud con cifratura end-to-end', 'Migliorare la resilienza e la sicurezza dei backup', 'Attuato', 'Alta', '2026-01-31', 3);

INSERT INTO miglioramento_attuato (attivita_id, miglioramento_id) VALUES
(6, 1);

INSERT INTO backup_eff (attivita_id, tipo_backup, backup_pos, cifratura) VALUES
(2, 'Incrementale', 'In cloud', TRUE);

INSERT INTO comunicazione_attivita (attivita_id, direzione, tipo_comunicazione, comunicazione, destinatari, canale_trasmissione) VALUES
(4, 'Esterna', 'Riscontrate vulnerabilità', 'Rilevate 2 vulnerabilita minori, risolte entro 48 ore', 'ACN, CSIRT Italia', 'Portale segnalazioni.acn.gov.it');

INSERT INTO attivita_successiva (attivita_partenza, attivita_seguente) VALUES
(4, 7);

INSERT INTO procedura (raci_id, finalita, tipologia, nome, procedimento, con_attivazione, con_disattivazione, proced_report, data_creazione, data_dimissione, link_documento, approvato) VALUES
(1, 'Gestione del ripristino sistemi videosorveglianza dopo incidente', 'Ripristino', 'Procedura di ripristino sistemi critici', 'Passo 1: ...; Passo 2: ...', 'Rilevazione di compromissione confermata', 'Sistemi ripristinati e verificati funzionanti', 'Report finale entro 5 giorni lavorativi', '2025-01-01', NULL, 'Z:doc/procedura/ripristino/videosorveglianza', TRUE),
(2, 'Esecuzione backup periodici', 'Backup', 'Procedura di backup dati critici', 'Passo 1:...; Passo 2:...', 'Una volta a settimana', 'Mai', 'Log giornaliero di esito backup', '2024-05-01', NULL, 'Z:doc/procedura/ripristino/videosorveglianza', TRUE),
(3, 'Comunicazione incidenti agli stakeholder', 'Comunicazione', 'Procedura di comunicazione incidenti', 'Passo 1: comunica tramite il sito dell''ACM e rispetta gli obblighi NIS2', 'Dichiarazione di incidente', 'Chiusura formale incidente', 'Relazione finale su richiesta CSIRT', '2025-06-01', NULL, 'Z:doc/procedura/ripristino/comunicazione', TRUE);


INSERT INTO asset_procedura (risorse_id, procedura_id) VALUES
(3, 1),
(2, 2);

INSERT INTO comunicazione_procedura (procedura_id, direzione, tipo_comunicazione, comunicazione, destinatari, canale_trasmissione) VALUES
(3, 'Esterna', 'Notifica incidente significativo', 'Template di pre-notifica CSIRT Italia', 'CSIRT Italia', 'Portale segnalazioni.acn.gov.it');

INSERT INTO procedura_successiva (procedura_partenza, procedura_seguente) VALUES
(1, 3);

INSERT INTO ripristino (procedura_id, tempo_ripristino, costi_ripristino) VALUES
(1, '2 days', 1500.00);

INSERT INTO rischio (test_vulnerabilita_id, nome, data_rilevazione, tipologia_rischio, descrizione, analisi_rischio_prob, analisi_rischio_grav, stato, note) VALUES
(1, 'Accesso non autorizzato tramite vulnerabilita hosting', '2024-01-10', 'Cyber/informatico', 'Vulnerabilita RCE rilevata sulla piattaforma di hosting cloud', 'Media', 'Bassa', 'Mitigato', 'Patch applicata dal fornitore'),
(NULL, 'Interruzione servizio per guasto hardware', '2025-06-01', 'Operativo/tecnico', 'Rischio di fermo prolungato per guasto server critico', 'Media', 'Alta', 'Attivo', 'Da mitigare con ridondanza'),
(2, 'Errore umano in configurazione firewall', '2026-02-15', 'Umano', 'Configurazione errata durante installazione nuovo firewall', 'Bassa', 'Media', 'Accettato', NULL);

INSERT INTO rischio_miglioramenti (rischio_id, miglioramento_id) VALUES
(1, 1),
(2, 3);

INSERT INTO crisi (squadra_id, tipologia_crisi, data_inizio, data_fine, descrizione, report, causa, conseguenze, gravita, stato) VALUES
(4, 'Cyber/informatico', '2025-03-10', '2025-03-12', 'Tentativo di intrusione rilevato sul server web', 'Incidente contenuto entro 48 ore, nessun dato esfiltrato', 'Sfruttamento vulnerabilita nota non ancora patchata', 'Nessun impatto su servizi ai clienti', 'Alta', 'Mitigata'),
(4, 'Operativo/tecnico', '2026-06-01', NULL, 'Guasto hardware su server database', NULL, 'Usura componente hardware', 'Rallentamento servizi per 3 ore', 'Media', 'In corso');