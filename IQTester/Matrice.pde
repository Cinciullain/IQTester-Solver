class Matrice //TODO: Riga 196
{
    /*********************************************************************
    /START VAR DECLARATION
    *********************************************************************/

    int righe;
    int colonne;
    float[][] matrice;

    /*********************************************************************
    /END VAR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START CONSTRUCTOR DECLARATION
    *********************************************************************/

    Matrice(int r, int c)
    {
        righe = r;
        colonne = c;
        matrice = new float[r][c];
    }

    Matrice(float m[][])
    {
        matrice = m;
        colonne = m.length;
        righe = m[0].length;  
    }

    /*********************************************************************
    /END CONSTRUCTOR DECLARATION
    *********************************************************************/

    /*********************************************************************
    /START METHODS DECLARATION
    *********************************************************************/

    /*
    Setta la Matrice con int randomici tra -1 e 1 
    (Server per i weight della rete neurale)
    */
    void randomizzaWeight()
    {
        for(int i = 0; i < righe; i++)
        {
            for(int j = 0; j < colonne; j++)
            {
                matrice[i][j] = random(-1, 1);
            }
        }
    }

    /*
    Crea e restituisce una matrice a singola colonna dall'array parametro
    (Non un vettore)
    */
    Matrice matriceSingolaColonnaDaArray(float[] array)
    {
        Matrice nuovaMatrice = new Matrice(array.length, 1);
        for(int i = 0; i < nuovaMatrice.righe; i++)
        {
            nuovaMatrice.matrice[i][0] = array[i];
        }
        
        return nuovaMatrice;
    }

    /*
    Crea una Matrice dall'array parametro   
    */
    void matriceDaArray(float[] array)
    {
        for(int i = 0; i < righe; i++)
        {
            for(int j = 0; j < colonne; j++)
            {
                matrice[i][j] = array[j + (i * colonne)];
            }
        }
    }

    /*
    Trasforma la Matrice in array
    */
    float[] arrayDaMatrice()
    {
        float[] nuovoArray = new float[righe * colonne];
        for(int i = 0; i < righe; i++)
        {
            for(int j = 0; j < colonne; j++)
            {
                nuovoArray[j + (i * colonne)] = matrice[i][j];
            }
        }
        
        return nuovoArray;
    }

    /*
    Restituisce una nuova Matrice con l'aggiunta del Bias 
    */
    Matrice aggiungiBias()
    {
        Matrice nuovaMatrice = new Matrice(righe + 1, 1);
        for(int i = 0; i < righe; i++)
        {
            nuovaMatrice.matrice[i][0] = matrice[i][0];
        }

        nuovaMatrice.matrice[righe][0] = 1;
        return nuovaMatrice;
    }

    /*
    Funzione Sigmoidea
    */
    float sigmoide(float x)
    {
        return (1 / (1 + pow((float)Math.E, -x)));
    }

    /*
    Applica la funzione sigmoidea ad ogni elemento della matrice
    */
    Matrice applicaSigmoidea()
    {
        Matrice nuovaMatrice = new Matrice (righe, colonne);
        for(int i = 0; i < righe; i++)
        {
            for(int j = 0; j < colonne; j++)
            {
                nuovaMatrice.matrice[i][j] = sigmoide(matrice[i][j]);
            }
        }

        return nuovaMatrice;
    }

    /*
    Mutazione secondo l'algoritmo genetico
    */
    void muta(float rateoMutazione)
    {
        for(int i = 0; i < righe; i++)
        {
            for(int j = 0; j < colonne; j++)
            {
                float numeroRandom = random(1);

                //TRUE: Adatto per mutazione
                if(numeroRandom < rateoMutazione)
                {
                    /*
                    //Aggiunge un valore random. Ho scelto randomGaussian() perchè genera
                    un numero senza floating point, che può essere negativo
                    */
                    matrice[i][j] += randomGaussian() / 5;
                }

                /*
                Imposto i limiti dei valori fra 1 e -1
                Nel caso fossero andati oltre col gaussiano
                */
                if(matrice[i][j] > 1)
                {
                    matrice[i][j] = 1;
                }
                if(matrice[i][j] < -1)
                {
                    matrice[i][j] = -1;
                }
            }
        }
    }

    /*
    Restituisce una Matrice che risulterà una fusione randomica
    tra la matrice invocante e quella parametro
    */
    Matrice crossover(Matrice partner)
    {
        Matrice figlio = new Matrice(righe, colonne);

        //Prendo un punto casuale nella matrice
        int rigaRandom = floor(random(righe));
        int colonnnaRandom = floor(random(colonne));

        for(int i = 0; i < righe; i++)
        {
            for(int j = 0; j < colonne; j++)
            {
                /*
                Se il punto in cui siamo arrivati col for è prima del punto random, 
                allora copia la parte della matrice invocante
                */
                if((i < rigaRandom) || (i == rigaRandom && j <= colonnnaRandom))
                {
                    figlio.matrice[i][j] = matrice[i][j];
                }

                /*
                Se invece il for è arrivato al punto random, 
                copia la parte della matrice parametro
                */
                else
                {
                    figlio.matrice[i][j] = partner.matrice[i][j];
                }
            }
        }

        return figlio;
    }

    /*
    Restituisce un clone della matrice
    */
    Matrice clone()
    {
        Matrice clone = new Matrice(righe, colonne);
        for(int i = 0; i < righe; i++)
        {
            for(int j = 0; j < colonne; j++)
            {
                clone.matrice[i][j] = matrice[i][j];
            }
        }

        return clone;
    }

    /*
    Restituisce il dot product tra la matrice e quella parametro
    */
    Matrice dot(Matrice parametro){
        Matrice risultato = new Matrice(righe, parametro.colonne);
        float somma;

        if(colonne == parametro.righe)
        {
            for(int i = 0; i < righe; i++)
            {
                for(int j = 0; j < parametro.colonne; j++)
                {
                    somma = 0;
                    for(int k = 0; k < colonne; k++)
                    {
                        somma += matrice[i][k] * parametro.matrice[k][j];
                    }

                    risultato.matrice[i][j] = somma;
                }
            }
        }

        return risultato;
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
