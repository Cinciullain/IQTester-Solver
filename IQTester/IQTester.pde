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
    boolean mostraTutti = false; //TRUE: Mostra tutte le partite
    boolean faseTraningNNM = false; //TRUE: Training 5 NN migliori; FALSE: Fase normale
    boolean mostraNNMigliore = false; //TRUE: Fase testing una delle 5 NN
    boolean superNN = false; //TRUE: Fase testing fusione delle 5 NN
    boolean trainingManuale = false; //TRUE: Training tramite interazione
    
    Pedina pedina;

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
        pedina = new Pedina();
    }

    /*
    Fase di esecuzione della sessione
    */
    void draw()
    {
        background(40);
        mostraDati();
        pedina.printPedina();
    }

    /*
    */
    void mostraDati()
    {
        stroke(255, 50, 50);
        line(400, 0, 400, 400);
        fill(255);
        textSize(30);
        
        /*
        Fase training/evolutiva delle 5 NN
        */
        if(faseTraningNNM)
        {
            text("Training NN Migliori", 10, 50);
            fill(#3DB274);
            text("Generazione: " + (mondoS.generazione), 25, 100); 
            text("Velocità: " + frameRate, 25, 150);
            text("Punteggio migliore: " + (mondoS.recordMondiale), 25, 200);
            text("Rateo mutazione: " + rateoMutazione, 25, 250);
        }

        /*
        Fase testing NN migliore selezionata
        */
        else if(mostraNNMigliore)
        {
            text("Esecuzione NN Migliore: "+ (numeroNNMigliore), 10, 50);
            fill(#3DB274);
            text("Punteggio: "  , 25, 100); 
            text("Mosse: " , 25, 150);
        }

        /*
        Fase testing fusione delle 5 NN
        */
        else if(superNN)
        {
            text("Esecuzione superNN", 10, 50);
            fill(#3DB274);
            text("Punteggio: "  , 25, 100);
            text("Mosse: "  , 25, 150);
            text("Mosse Restanti: "  , 25, 200);
            text("NN Seguita: "  , 25, 250);
        }

        /*
        Fase normale di evoluzione/testing della popolazione
        */
        else
        {
            text("Training Popolazione", 10, 50);
            fill(#3DB274);
            text("Generazione: " + (mondo.generazione), 25, 100);
            text("Velocità: " + frameRate, 25, 150);
            text("Punteggio migliore: " + (mondo.recordMondiale), 25, 200);
            text("Rateo mutazione: " + rateoMutazione, 25, 250);
        }
    }
    
    /*
    Gestione tasti rapidi
    */
    void keyPressed()
    {
        switch(key)
        {
            //Disattiva/Attiva "Mostra tutti"
            case ' ':
            {
                mostraTutti = !mostraTutti;
                break;
            }

            //Aumenta fps
            case '+':
            {
                frameRate += 10;
                frameRate(frameRate);
                break;    
            }
                
            //Diminuisce fps
            case '-':
            {
                if (frameRate > 10)
                {
                    frameRate -= 10;
                    frameRate(frameRate);
                }
                break;
            } 
                
            //Avvia sessione superNN
            case 'f':
            {
                superNN = !superNN;
                //mondo.creaSuperNN();
                break;        
            }
                
            //Test NN Migliore 0
            case '5':
            {
                mostraNNMigliore = !mostraNNMigliore;
                mostraNNMigliore = 5;
                mondo.testNNMigliore(0);
                break;    
            } 
                
            //Test NN Migliore 1
            case '1':
            {
                mondo.testNNMigliore(1);
                mostraNNMigliore = 1;
                mostraNNMigliore = !mostraNNMigliore;
                break;        
            } 
                
            //Test NN Migliore 2
            case '2':
            {
                mondo.testNNMigliore(2);
                mostraNNMigliore = 2;
                mostraNNMigliore = !mostraNNMigliore;
                break;
            } 
                
            //Test NN Migliore 3
            case '3':
            {
                mondo.testNNMigliore(3);
                mostraNNMigliore = 3;
                mostraNNMigliore = !mostraNNMigliore;
                break;
            } 
                
            //Test NN Migliore 4
            case '4':
            {
                mondo.testNNMigliore(4);
                mostraNNMigliore = 4;
                mostraNNMigliore = !mostraNNMigliore;
                break;
            }
                
            //Segnala una delle NN Migliori nel caso sia di bassa qualità
            case 's':
            {
                //TODO
                break;
            }
                
            //Dimezza il rateo di mutazione
            case 'd':
            {
                rateoMutazione /= 2;
                break;
            }
                
            //Raddoppia il rateo di mutazione
            case 'r':
            {
                rateoMutazione *= 2;
                break;
            }
                
            //Allena le NN migliori
            case 'l':
            {
                faseTraningNNM = !faseTraningNNM;
                //Carica le 5 NN migliori dal file e inizializza il mondo
                if (faseTraningNNM == true) { 
                //mondo.carica();
                //mondoSM = new Mondo(1000, mondo.);
                }
            } 
                
            //Fase "Manuale" di training; Comandi per imparare da un giocatore
            case 'm' :
            {
                trainingManuale = !trainingManuale;
                if(keyCode == UP) 
                {
                    println("up");
                } 
                else if(keyCode == DOWN) 
                {
                    println("down");
                } 
                else if(keyCode == LEFT) 
                {
                    println("left");
                } 
                else if(keyCode == RIGHT) 
                {
                    println("right");
                }
            } 
                
        }   
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
