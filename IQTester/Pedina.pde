class Pedina
{
    /*********************************************************************
    /START VAR DECLARATION
    *********************************************************************/

    PVector posizione; //Forse non serve, dipende da come si implementa il tabellone
    PVector tmp; //Forse non serve

    int durataPedina = 0; //Giusto per statistica
    int movimentiRestanti; //Forse non serve
    int pedineMangiate = 0;
    long fitness = 0; //Qualità della pedina, forse non serve
    boolean statoPedina = true; //TRUE: Presente
    boolean test = false; //TRUE: Fase testing; FALSE: Fase training
    float[] vistaPedina = new float[24]; //TODO Gli input della rete neurale, da decidere se impletementare qua o altrove
    float[] decisioneReteNeurale; //Come prima todo da decidere, Output RN

    /*********************************************************************
    /END VAR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START CONSTRUCTOR DECLARATION
    *********************************************************************/

    Pedina()
    {
        posizione = new PVector();

        /*
        Imposta la posizione su un punto randomico
        +400 per sportare la scheramta a destra e non farla sovrapporre alle statistiche
        */
        posizione.x = 400+floor(random(0, 40)) * 10; 
        posizione.y = floor(random(0, 40)) * 10;
    }

    /*********************************************************************
    /END CONSTRUCTOR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START METHODS DECLARATION
    *********************************************************************/

    /*
    Mostra graficamente la pedina
    TODO
    */
    void printPedina()
    {
        fill(255);
        stroke(0);
        rect(posizione.x, posizione.y, 10, 10);
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
}
