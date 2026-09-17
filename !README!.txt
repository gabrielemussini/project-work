!READ ME!

Prerequisiti:
 Bisogna avere installati questi programmi:
 - PostgreSQL ≥ 14 (per il supporto completo a INTERVAL, CHECK, trigger PL/pgSQL)
 - pgAdmin

1. Crea il database:
 a) Apri pgAdmin 4 ed effettua l'accesso inserendo la password del tuo server.
 b) Espandi il server desiderato nella struttura ad albero a sinistra.
 c) Fai clic con il tasto destro sulla voce Databases.
 d) Seleziona Create dal menu contestuale e poi clicca su Database...
 e) Nella scheda General della finestra che si apre, inserisci il Name (il nome del tuo nuovo database).
 f) Clicca sul pulsante Save in basso per confermare la creazione

2. Eseguire le Query e le istruzioni SQL:
 a) Nel pannello a sinistra (Object Explorer), espandi il server e la voce Databases.
 b) Fai clic destro sul nome del database su cui vuoi lavorare.
 c) Seleziona la voce Query Tool dal menu contestuale (oppure vai nel menu in alto su Tools -> Query Tool).
 d) Si aprirà una nuova scheda nell'area di lavoro: trascina qua le Query o l'istruzione.
 
3. Ordine da seguire per eseguire le istruzioni SQL (sono dentro la cartella SQL):
 a) create_table.sql
 b) trigger.sql
 c) insert.sql
 
4. (Opzionale): Verificare il popolamento delle tabelle con Query generiche come:
	SELECT * FROM asset;
	
5. Eseguire le Query:
 Le Query sono quattro e si trovano nella cartella Select, dentro la cartella SQL. Non c'è un ordine per eseguire.