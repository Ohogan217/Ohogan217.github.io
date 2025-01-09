public class Tableau extends Pile{
    public CardCollection cc;
    public int pileNo;
    
    /**
     * @param deck deck object that the tableau will be drawn from
     * @param n the tableau size, 1-7
     */
    public Tableau(Deck deck, int n) {//constructor for tableau object
        super(7);//create a pile of 20, the largest size a tableau can be
        pileNo = n;//set pile number
        int stock = 24, corr = 0;
        for(int i = 0; i<n; i++){//set a corrector for each pile
            corr = corr + i;
        }

        for(int i=0 ; i<n ; i++){//loop to set each of the forst n cards in the tableau
            this.setCard(deck.getCard(stock+i+corr), i);
            }

        cc = new CardCollection(this.getCard(this.getSize()-1));//create a card collection of the top card and any cards that can be added to it
        this.setCard(null, getSize()-1);
    }

    public void showTableau(){//method to display the sepcified tableau
        System.out.println("Lane -  " + this.pileNo + "\t[" 
        + (this.getSize()) + "]\t" + this.cc.getCCollection());
    }
    public void removeTop(){//method to remove the top cardcollection form the tableau and add a new top card
        if(getSize() >=1){
            this.cc = new CardCollection(getCard(getSize()-1));
            setCard(null, (getSize()-1));}
        else{
            this.cc = new CardCollection(null);
            this.cc.isFull = false;
        }
    }
    public void removeTopCard(){//method to remove the top cardcollection form the tableau and add a new top card
        if(cc.getSize() >1){
            this.cc.setCard(null, this.cc.getSize()-1);
        }
        else{
            removeTop();
        }
    }
}
