public class Pile {
    public int size ;
    public Card [] pile;
    
    /**
     * @param size size of the pile
     */
    public Pile(int n){// object for a pile of n cards
        size = n;
       this.pile = new Card[size]; 
    }

    public int getSize(){//getter for the amount of card objects in the pile
        int actualSize = 0;
        for(int i=0;i<this.size;i++){
            if(this.pile[i] != null){
                actualSize+=1;
            }
        }
        return(actualSize);
    }

    /**
     * @param n specifier for a certain card in pile
     * @return the specified card
     */
    public Card getCard(int n){//getter for a specified card
        Card card = this.pile[n];
        return(card);
    }

    /**
     * @param c card to be added to pile
     * @param n location of card to be added to pile
     */
    public void setCard(Card c, int n){//setter for a card in pile
        this.pile[n] = c;
    }

    /**
     * @param suit suit of card to be added
     * @param no rank of card to be added
     * @param n location of card to be added in pile
     */
    public void setCard(Suit suit, Rank no, int n){// setter for a card in pile using suit and rank
        Card c = new Card(suit, no);
        this.pile[n] = c;
    }
}
