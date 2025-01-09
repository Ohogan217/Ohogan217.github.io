public class Deck extends Pile{
    static int n = 52;

    public Deck(){//deck object that creates a pile of 52 cards and shufles it
        super(n);
        Suit[] suits = Suit.values();
        Rank[] ranks = Rank.values(); 
        for(int i= 0; i<this.size; i++){//for loop to fill in deck using the suits and ranks enum
            Suit suit;
            Rank  no;
            suit = suits[(int) i%suits.length];
            no = ranks[(int) Math.floor(i/(suits.length))];
            this.setCard(suit, no, i);
        } 
        int ra, rb; //shuffle deck by swapping 2 cards for n=100 times
        Card a, b;
        int n = 100;
        for(int i = 0; i < n; i++){
            ra = (int) Math.floor(Math.random()*(this.size));
            rb = (int) Math.floor(Math.random()*(this.size));
            a = this.getCard(ra);
            b = this.getCard(rb);
            this.setCard(b, ra);
            this.setCard(a, rb);
        }
    }
        
}
  
