public class Waste extends Pile{
    /**
     * @param stock the stock pile that will be used to fill up the waste pile
     */
    public Waste(Stock stock) {//constructor for waste pile in game
        super(stock.size+1);  
    }
    public void showWaste(){//method to display the top card of the waste pile as well as its size
        if(this.getCard(0) == null){
        System.out.println("Uncovered Pile - P -" + "\t" + "____" + "\t"  +  " - ["+ this.getSize()+"]\n");    
        }
        else{
        System.out.println("Uncovered Pile - P -" + this.getCard(0).no +  " " + this.getCard(0).suit  + "\t"+ " - [" + (this.getSize()-1) + "]\n");
        }
    }

    public void removeTop() {
        if (this.getSize() > 0) {
            for (int i = 0; i < getSize() - 1; i++)
                setCard(getCard(i + 1), i);
            setCard(null, getSize() - 1);
        } else {
            System.out.println("Waste pile is empty!");
        }
    }
}
