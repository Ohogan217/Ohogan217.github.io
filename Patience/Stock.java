public class Stock extends Pile{
    static int n = 24;

    public Stock(Deck deck) {//constructor for the stock object
        super(n);
        for(int i=0;i<n;i++){
            this.setCard(deck.getCard(i), i);
        }
    }
    /**
     * @param waste Waste pile that is destination for drawn card
     */
    public void drawCard(Waste waste){//method to draw a card from the stock to the waste
        int wsize = waste.getSize();
        if(this.getSize()>=1){ // check that stock is not empty, if it is, the waste will become the stock
            for(int i =waste.getSize();i>0;i--){
                waste.setCard(waste.getCard(i-1), i);    
            }
            waste.setCard(this.getCard(0),0);

            for(int i =1;i<this.getSize();i++){
                this.setCard(this.getCard(i), i-1);    
            }
            this.setCard(null, this.getSize()-1);
        }
        else{
            for(int i =0; i<wsize;i++){
            this.setCard(waste.getCard(i), (wsize-1-i));
            waste.setCard(null, i);
            }
        }
    }

    public void showStock(){ //method to print the stock
        System.out.println("Stock - [" + (this.getSize()) + "] - D - Draw");
    }

}
