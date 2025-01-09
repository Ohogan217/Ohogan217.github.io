public class CardCollection extends Pile {
    static int n = 13;
    public boolean isFull = true;

    public CardCollection(Card c){//pile of 13 cards for completed ace to king sets
        super(n);
        this.setCard(c, 0);
    }
    public void removeCard(CardCollection cc){//method to remove the bottom card from the collection
        for(int i = 0; i<=cc.getSize()-1;i++){
                Card c = cc.getCard(i);
                this.setCard(c, this.getSize());
        }	
    }
    
    public void addCard(Tableau t){//method to add a card collection to the top card collection of another pile
        CardCollection cc = t.cc;
        Card c = cc.getCard(0);
        int n;
        if(this.getSize() != 0){
            if(this.getSize() ==0){
                n = 0;
            }
            else{n = this.getSize()-1;}
            if(this.getCard(n).checkAddToTableau(c)){
                this.removeCard(cc);
                t.removeTop();
            }
            else {
                for(int i = cc.getSize()-1; i >=0; i--){
                    if((cc.getCard(i).no == this.getCard(n).no )&& (cc.getCard(i).colour == this.getCard(n).colour)){
                        CardCollection tempcc = new CardCollection(null);

                        for(int j = 0; j<=cc.getSize()-i;j++){
                            tempcc.setCard(cc.getCard(i+j+1), j);
                        }
                        this.removeCard(tempcc);
                        for(int j = 0; j<this.size;j++){
                            for(int k=0;k<tempcc.getSize();k++){
                                if(tempcc.getCard(k)==(cc.getCard(j))) {
                                    cc.setCard(null,j);
                                }
                            }
                        }
                        break;
                    }
                }
            }
        }
        else{
            if(c.no == Rank.King){//if the pile is empty, onyl a king can be put there
                for(int i = 0; i<cc.getSize();i++){
                    this.setCard(cc.getCard(i), i);
                } 
                t.removeTop();
            }
        }
    }
    
    public void addCard(Foundations fs){//mehtod to adda card to a collection from foundations
        for(int i = 0; i<4; i++){
                       
            Foundation f = fs.getFoundation(i);
            if(f.getSize() != 0){
                Card c = f.getCard(0);

                if(this.getCard(0).checkAddToTableau(c)){
                    this.setCard(c, this.getSize());
                    f.setCard(null, (f.getSize()-1));
                    break;
                }
                else{
                }
            }
        }
    }

    public void addCard(Waste w){//method to add a card from the waste pile
        Card c = w.getCard(0);
        if(this.getSize() ==0){
            if(c.no == Rank.King){
                this.setCard(c,0);
                w.removeTop();
            }
            else{
                System.out.println("Invalid Move");
            }
        }
        else if(this.getCard(this.getSize()-1).checkAddToTableau(c)){

            this.setCard(c, this.getSize());
            w.removeTop();
        }
        else{
        }
    }
    public void addCardC(CardCollection cc){
        for(int i = 0;i<=cc.getSize()-1;i++){
            this.pile[this.getSize()+i] = cc.getCard(i);
        }
    }


    public String getCCollection(){//getter for the card collection
        String s = "";
        for(int i = 0; i<this.getSize();i++){
            if(getCard(i) == null){
                break;
            }
            else{
                s+= this.getCard(i).no.name() + " "+
                this.getCard(i).suit.name() + "\t";
            }
        }
        return(s);
    }
    
    
}
