public class Foundations {
    Foundation [] foundations = new Foundation[4];
    public boolean [] won = new boolean[4];//boolean to check if game is won
    public Foundations(){//object of the 4 foundation piles that would be used in the game
        for(int i =0; i<4; i++){
            Suit s = Suit.values()[i];
            foundations[i] = new Foundation(s);
        }
    }
    /**
     * @param c card to be checked if it can be added
     * @return card can be added to foundation
     */
    public boolean checkToAddCardEmpty(Card c){//checks that the card to be added in is an ace if the pile is empty
        int n = CheckSuit(c);
        Boolean b = (foundations[n].getSize() ==0 && c.no ==Rank.Ace);
        return b;
    }
    /**
     * @param c card to be checked if it can be added
     * @return card can be added to foundation
     */
    public boolean checkToAddCardFilled(Card c){//checks that the card to be added in is of a rank higher than the previous card
        int n = CheckSuit(c);
        Boolean b = (foundations[n].getCard(foundations[n].getSize()-1).no.ordinal() ==c.no.ordinal()-1);
        return b;
    }
    public void showFoundations(){//method to print all 4 the foundation piles
        System.out.println("Foundations - F ");
        for(int i =0; i<4; i++){
            this.foundations[i].showFoundation();;
        }
        this.checkFull();
        System.out.println("");
    }
    
    /**
     * @param n specifier for specific foundation
     * @return specified foundation
     */
    public Foundation getFoundation(int n){//getter for a specified foundation
        return(foundations[n]);
    }
    /**
     * @param c Card with suit to be returned
     * @return the suit of the card
     */
    public int CheckSuit(Card c){//method to give an interger value of the suit of a card/foundation
        int n = 0;
        switch(c.suit){
            case Hearts: n = 0;
            break;
            case Spades:  n = 1;
            break;
            case Diamonds:  n = 2;
            break;
            case Clubs: n = 3;
            break;
        }
        return(n);
    }
    /**
     * @param c card to be checked if it can be added
     * @return card can be added to foundation
     */
    public boolean checkAddCard(Card c){//method to see if a card can be added to a certain foundation
        int n = CheckSuit(c);
        Boolean b = false;
        if(checkToAddCardEmpty(c)){// checks if the foundation is empty
            b = true;
        }
        else if(foundations[n].getSize()!=0){
            if(checkToAddCardFilled(c)){// check if the card can be added if the foundation is partially full
                b = true;
            }
        }
        else{
            b = false;
        }
        return b;
    }
        
    /**
     * @param c Card to be added
     */
    public void addCard(Card c){//method to add a card to the foundation
        int n = CheckSuit(c);
        this.foundations[n].addCard(c);
    }

    /**
     * @param w waste pile from which card to be added to foundation
     */
    public void addCard(Waste w){//method to add a card to the foundation directly from waste pile
        if(w.getSize()!=0){
            Card c = w.getCard(0);
            if(this.checkAddCard(c)){
                this.addCard(c);
                w.removeTop();
                Interface.score.addScore(10);
            }
        else{System.out.println("\nInvalid Move");}
        }
        else{System.out.println("\nInvalid Move");}

    }

    /**
     * @param t Tableau from which the card to be added to the foundation
     */
    public void addCard(Tableau t){
       Card c = t.cc.getCard(t.cc.getSize()-1);
       if(this.checkAddCard(c)){
            addCard(c);
            t.removeTopCard();
            Interface.score.addScore(20);
       }
       else{System.out.println("\nInvalid Move");}
    }
    public void checkFull(){//method to check if all foudnations are full
        for(int i = 0; i<4; i++){
            if(foundations[i].isFull == true){
                won[i] = true;
            }
        }

    }
}
