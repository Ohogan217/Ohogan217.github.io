public class Foundation extends CardCollection{
    static int n = 13;
    public Suit suit;
    boolean isFull = false;

    /**
     * @param s specified suit for this foudnation pile
     */
    public Foundation(Suit s) {//constructor of the foundation pile that is a card collection with a specified suit
        super(null);
        suit = s;
    }

    public void showFoundation(){ //method to display the foundation piles
        if(this.getCard(Math.abs(getSize()-1)) ==null){
            System.out.println("Foundation " + this.suit + "\t[____]");//print the suit and a blank space if the pile is empty
        }
        else{
            System.out.println("Foundation " + this.suit + "\t["+this.getCard(getSize()-1).no+"]");//print the suit and rank of the highest card in the pile
        }
    }

    public void addCard(Card c){//method to add a card to the foundation and check if its full
        this.setCard(c, this.getSize());
        checkFull();
        
    } 
    public void checkFull(){//method to check if foundation is full
        if(this.getSize()==13){
            isFull = true;
        }
        else{
            isFull = false;
        }
    }   
}
