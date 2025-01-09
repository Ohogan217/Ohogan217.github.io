public class Card {
    Suit suit;
    Rank no;
    Colour colour;
       
    /**
     * @param s card's suit
     * @param n card's rank
     */
    public Card(Suit s, Rank n){//constructor for card object with rank and suit
        suit = s;
        no = n;
        if(suit == Suit.Hearts || suit == Suit.Diamonds){//set colour of card
            colour = Colour.red;
        }
        else{
            colour = Colour.black;
        }
    } 
    /**
     * @param s suit of card
     * @param n rank of card
     */
    public void setCard(Suit s, Rank n){//setter for card using suit and rank
        this.suit = s;
        this.no = n;
    }
    /**
     * @param c card to be set
     */
    public void setCard(Card c){//setter for card using card object
        this.suit = c.suit;
        this.no = c.no;
    }
    /**
     * @param c card to check if it can be added to tableau
     * @return card can be added to specified tableau
     */
    public boolean checkAddToTableau(Card c) {//method to check if a card can be added to the tableau

        boolean bool = (this.colour !=c.colour && 
        (Rank.valueOf(this.no.name())).ordinal() 
        == (Rank.valueOf(c.no.name())).ordinal()+1);

        return(bool);
    }
        
}
