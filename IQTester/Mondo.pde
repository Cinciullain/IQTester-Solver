class Mondo
{
    /*********************************************************************
    /START VAR DECLARATION
    *********************************************************************/

    SuperNN superNN;
    //robe
    ReteNeurale[] retiNeuraliMigliori; //Array contenenti le 5 NN
    Popolazione[] popolazione;

    int generazione = 1; //Generazione corrente
    int recordMondiale; //Il miglior punteggio
    int posizionePartitaMigliore; //Posizione nell'array del tabellone con miglior punteggio

    /*********************************************************************
    /END VAR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START CONSTRUCTOR DECLARATION
    *********************************************************************/

    Mondo(int numeroPopolazione, int grandezzaPopolazione)
    {
        popolazione = new Popolazione[numeroPopolazione];
    }

    /*********************************************************************
    /END CONSTRUCTOR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START METHODS DECLARATION
    *********************************************************************/

    ;

    /*********************************************************************
    /END METHODS DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START ADDITIONAL COMMENTS/CONTENT DECLARATION
    *********************************************************************/

    /*********************************************************************
    /END ADDITIONAL COMMENTS/CONTENT DECLARATION
    *********************************************************************/
}