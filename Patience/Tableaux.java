public class Tableaux{
    int noPiles = 7;
    Tableau[] tableaux = new Tableau[noPiles];

    public Tableaux(Deck deck){
        for(int i=1; i<=7; i++){
            tableaux[i-1] = new Tableau(deck, i);
        }
    }
    public Tableau getTableau(int n){
        return(this.tableaux[n]);
    }
    public void showTableaux(){
        System.out.println("Lanes - No");
        for(int i = 0; i<this.noPiles; i++){
            this.getTableau(i).showTableau();
        }
    }
}
