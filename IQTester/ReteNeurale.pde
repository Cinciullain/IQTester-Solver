class ReteNeurale
{
    /*********************************************************************
    /START VAR DECLARATION
    *********************************************************************/

    int neuroniInput; //Numero di neuroni di input
    int neuroniNascosti; //Numero di neuroni nascosti
    int neuroniOutput; //Numero di neuroni in output

    Matrice weightsInputNascosti; //Matrice contenente i weights tra i neuroni in input e quelli nascosti 
    Matrice weightsNascostiNascosti; //Matrice contenente i weights tra i neuroni nascosti del primo, e del secondo strato (nascosto)
    Matrice weightsOutputNascosti; //Matrice contenente i weights tra il secondo strato di neuroni nascosti e i neuroni in output

    /*********************************************************************
    /END VAR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START CONSTRUCTOR DECLARATION
    *********************************************************************/

    ReteNeurale(int neuroniI, int neuroniN, int neuroniO)
    {
        neuroniInput = neuroniI;
        neuroniNascosti = neuroniN;
        neuroniOutput = neuroniO;

        //Crea i weights del primo strato
        weightsInputNascosti = new Matrice(neuroniNascosti, neuroniInput + 1);

        //Crea i weights del secondo strato
        weightsNascostiNascosti = new Matrice(neuroniNascosti, neuroniNascosti + 1);

        //Crea i weights del terzo strato
        weightsOutputNascosti = new Matrice(neuroniOutput, neuroniNascosti + 1);

        //Setta le matrici con valori randomici
        weightsInputNascosti.randomizzaWeight();
        weightsNascostiNascosti.randomizzaWeight();
        weightsOutputNascosti.randomizzaWeight();
    }

    /*********************************************************************
    /END CONSTRUCTOR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START METHODS DECLARATION
    *********************************************************************/

    /*
    Applica la funzione di mutazione ai pesi
    */
    void muta(float rateoMutazione)
    {
        weightsInputNascosti.muta(rateoMutazione);
        weightsNascostiNascosti.muta(rateoMutazione);
        weightsOutputNascosti.muta(rateoMutazione);
    }

    /*
    Calcola i valori di output (ultimo strato) e li restituisce in un array
    pesati tramite sigmoidea
    */
    float[] outputReteNeurale(float[] arrayInput)
    {
        /*
        1) Converto array in matrice
        2) Aggiungo bias
        3) Applico i pesi del primo strato agli input (Passa dal primo layer al secondo)
        4) Applico la funzione sigmoidea
        5) Aggiungo bias
        */
        Matrice primoLayer = weightsOutputNascosti.matriceSingolaColonnaDaArray(arrayInput);
        Matrice primoLayerBias = primoLayer.aggiungiBias;
        Matrice secondoLayer = weightsInputNascosti.dot(primoLayerBias);
        Matrice secondoLayerSigmoidea = secondoLayer.applicaSigmoidea();
        Matrice secondoLayerBias = secondoLayerSigmoidea.aggiungiBias();

        //Applico gli stessi passaggi per il terzo layer
        Matrice terzoLayer = weightsNascostiNascosti.dot(secondoLayerBias);
        Matrice terzoLayerSigmoidea = terzoLayer.applicaSigmoidea();
        Matrice terzoLayerBias = terzoLayerSigmoidea.aggiungiBias();

        //Applico i pesi del terzo strato e "ativo il risultato"
        Matrice output = weightsOutputNascosti.dot(terzoLayerBias);
        return output.applicaSigmoidea().arrayDaMatrice();
    }

    /*
    Funzione di crossover dell'algoritmo genetico
    Creo una nuova ReteNeurale fondendo quella attuale e quella parametro
    */
    ReteNeurale crossover(ReteNeurale partner)
    {
        ReteNeurale figlio = new ReteNeurale(neuroniInput, neuroniNascosti, neuroniOutput);
        figlio.weightsInputNascosti = 
            weightsInputNascosti.crossover(partner.weightsInputNascosti);
        figlio.weightsNascostiNascosti = 
            weightsNascostiNascosti.crossover(partner.weightsNascostiNascosti);
        figlio.weightsOutputNascosti = 
            weightsOutputNascosti.crossover(partner.weightsOutputNascosti);
    }

    /*
    Restituisce il clone della rete neurale
    */
    ReteNeurale clone()
    {
        ReteNeurale clone = new ReteNeurale(neuroniInput, neuroniNascosti, neuroniOutput);
        clone.weightsInputNascosti = weightsInputNascosti.clone();
        clone.weightsNascostiNascosti = weightsNascostiNascosti.clone();
        clone.weightsOutputNascosti = weightsOutputNascosti.clone();

        return clone;
    }

    /*
    Converte le Matrici contenenti i wheights in una tabella 
    Utilizzata per salvare le reti neurali in un file excell
    */
    Table reteNeuraleInTabella()
    {
        Table tabella = new Table();

        float[] arrayWeightsInputNascosti = weightsInputNascosti.arrayDaMatrice();
        float[] arrayWeightsNascostiNascosti = weightsNascostiNascosti.arrayDaMatrice();
        float[] arrayWeightsOutputNascosti = weightsOutputNascosti.arrayDaMatrice();

        //Imposto la quantità di colonne nella tabella
        int i;
        for(i = 0; i < max(arrayWeightsInputNascosti.length, 
            arrayWeightsNascostiNascosti.length, 
                arrayWeightsOutputNascosti.length); i++)
                {
                    tabella.addColumn();
                }
        
        //Imposto la prima riga come weightsInputNascosti
        TableRow rigaTabella = tabella.addRow();
        for(i = 0; i < arrayWeightsInputNascosti.lenght; i++)
        {
            rigaTabella.setFloat(i, arrayWeightsInputNascosti[i]);
        }

        //Imposto la seconda riga come weightsNascostiNascosti
        rigaTabella = tabella.addRow();
        for (i = 0; i < arrayWeightsNascostiNascosti.length; i++) 
        {
            rigaTabella.setFloat(i, arrayWeightsNascostiNascosti[i]);
        }

        //Imposto la terza riga come weightsOutputNascosti
        rigaTabella = tabella.addRow();
        for (i = 0; i< arrayWeightsOutputNascosti.length; i++)
        {
            rigaTabella.setFloat(i, arrayWeightsOutputNascosti[i]);
        }

        return tabella;
    }

    /*
    Prende la tabella salvata e la trasforma in rete neurale 
    Carica i dati dal file
    */
    void reteNeuraleDaTabella(Table tabella)
    {
        float[] arrayWeightsInputNascosti = 
            new float[weightsInputNascosti.righe * weightsInputNascosti.colonne];
        float[] arrayWeightsNascostiNascosti = 
            new float[weightsNascostiNascosti.righe * weightsNascostiNascosti.colonne];
        float[] arrayWeightsOutputNascosti = 
            new float[weightsOutputNascosti.righe * weightsOutputNascosti.colonne];

        //Imposta l'array weightsInputNascosti come prima riga della tabella
        int i;
        TableRow rigaTabella = tabella.getRow(0);
        for (i = 0; i < arrayWeightsInputNascosti.length; i++)
        {
            arrayWeightsInputNascosti[i] = rigaTabella.getFloat(i);
        }

        //Imposta l'array weightsNascostiNascosti come seconda riga della tabella
        rigaTabella = tabella.getRow(1);
        for (i = 0; i < arrayWeightsNascostiNascosti.length; i++)
        {
            arrayWeightsNascostiNascosti[i] = rigaTabella.getFloat(i);
        }

        //Imposta l'array WeightsOutputNascosti come terza riga della tabella
        rigaTabella = tabella.getRow(2);
        for (i = 0; i < arrayWeightsOutputNascosti.length; i++)
        {
            arrayWeightsOutputNascosti[i] = rigaTabella.getFloat(i);
        }

        weightsInputNascosti.matriceDaArray(arrayWeightsInputNascosti);
        weightsNascostiNascosti.matriceDaArray(arrayWeightsNascostiNascosti);
        weightsOutputNascosti.matriceDaArray(arrayWeightsOutputNascosti);
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
