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
    float[] vistaPedina = new float[bho]; //TODO Gli input della rete neurale, da decidere se impletementare qua o altrove
    float[] decisioneReteNeurale; //Come prima todo da decidere, Output RN

    /*********************************************************************
    /END VAR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START CONSTRUCTOR DECLARATION
    *********************************************************************/

    Pedina()
    {
        
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
        fill(100);
        stroke(0);

        rect(0, 0, 10, 10)
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