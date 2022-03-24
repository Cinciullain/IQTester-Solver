    /*********************************************************************
    /START PROJECT DECLARATION                                           *
    *                                                                    *
    /DESCRIZIONE:Questo progetto è una riproduzione del gioco "IQTester",*
    *sviluppato in processing, con l'obbiettivo di adeguarsi             *
    *all'indentazione e al sistema di organizzazione è commenti di alto  *
    *livello.                                                            *
    *Il progetto ha anche l'obbiettivo di ripassare alcuni meccanismi    *
    *base per l'implementazione di sistemi basati su AI.                 *
    *Il sistema implementato è un meccanismo base di reinforcement       *
    *learning, con l'aggiunta dell'algoritmo genetico.                   *
    *                                                                    *
    *AUTORE: Alessandro Casula                                           *
    *DATA INIZIO: 21/03/2022                                             *
    *LINGUAGGIO: Processing4                                             *
    *DATA FINE: N/A                                                      *
    *                                                                    *
    /END PROJECT DECLARATION                                             *
    *********************************************************************/
    
    /*********************************************************************
    /START IMPORT DECLARATION
    *********************************************************************/

    import java.io.File;

    /*********************************************************************
    /END IMPORT DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START VAR DECLARATION
    *********************************************************************/

    Mondo mondo; //Il container delle generazioni di partite
    Mondo mondoS; //Il container delle 5 NN migliori

    //Variabili utilizzate per modificare le opzioni durante l'esecuzione
    int frameRate = 60;
    int numeroNNMigliore; //La NN selezionata (1 - 5)
    float rateoMutazione = 0.01;
    boolean mostratutti = false; //TRUE: Mostra tutte le partite
    boolean faseTraningS = false; //TRUE: Training 5 NN migliori; FALSE: Fase normale
    boolean mostraNNMigliore = false; //TRUE: Fase testing una delle 5 NN
    boolean superNN = false; //TRUE: Fase testing fusione delle 5 NN
    boolean trainingManuale = false; //TRUE: Training tramite interazione

    /*********************************************************************
    /END VAR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START CONSTRUCTOR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /END CONSTRUCTOR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START METHODS DECLARATION
    *********************************************************************/

    /*
    Setup della sessione
    */
    void setup()
    {
        frameRate(frameRate);
        size(800, 400); //Dimensione finestra
        mondo = new Mondo(5, 5); //Quante "popolazioni" e quante partite per ognuna
    }

    /*
    Fase di esecuzione della sessione
    */
    void draw()
    {
        background(40);
        mostraDati();
    }

    /*
    */
    void mostraDati()
    {
        stroke(255, 50, 50);
        line(400, 0, 400, 400);
        fill(255);
        textSize(30);
    }

    /*********************************************************************
    /END METHODS DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START ADDITIONAL COMMENTS/CONTENT DECLARATION
    *********************************************************************/

    /*********************************************************************
    /END ADDITIONAL COMMENTS/CONTENT DECLARATION
    *********************************************************************/
