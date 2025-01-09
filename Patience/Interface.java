public class Interface {
    Stock stock;
    Waste waste;
    Tableaux tableaux;
    public static Score score;
    Foundations foundations;//Declare values of variables of the interface

    /**
     * @param st the Patience stock pile for the game
     * @param w the Patience waste pile for the game
     * @param t the Patience tableau piles for the game
     * @param sc the Patience score pile for the game
     * @param f the Patience foundation piles for the game
     */
    public Interface(Stock st, Waste w, Tableaux t, 
    Score sc, Foundations f){//constructor for interface
    stock = st;
    waste = w;
    tableaux = t;
    score = sc;
    foundations = f;
    run();
    }
    public void run(){//method to run the interface and display the game
        score.showScore();
        stock.showStock();
        waste.showWaste();
        tableaux.showTableaux();
        System.out.println("\n");
        foundations.showFoundations();
    }
    public void draw(){//method to draw a card from the stock to the waste pile
        stock.drawCard(waste);
        this.run();
    }
    /**
     * @param i1 the identifier of the first tableau pile
     * @param i2 the identifier of the second tableau pile
     */
    public void tableauToTableau(int i1, int i2){//method to move cards between the tableaux piles
        if(tableaux.getTableau(i1-1).cc.getCard(0)!=null){
            tableaux.getTableau(i2-1).cc.addCard(tableaux.getTableau(i1-1));
            score.addScore(5);
        }
        else{
            System.out.println("Invalid move");

        }
        run();
    }
    /**
     * @param n identifier of the specified tableau pile
     */
    public void wasteToPile(int n){//method to move cards from the waste pile to a specified tableau pile
        tableaux.getTableau(n-1).cc.addCard(waste);
        run();
    }
    /**
     * @param t identifier of the specified tableau pile
     */
    public void pileToFound(int n){//method to move cards from a specified tableau pile to the foundation piles
        if(tableaux.getTableau(n-1).cc.getCard(0) != null){
            foundations.addCard(tableaux.getTableau(n-1));
        }
        else{
            System.out.println("Invalid move");
        }
        run();
    }
    public void wasteToFound(){//method to move cards from the waste pile to the foundation piles
        foundations.addCard(waste);
        this.run();
    }
    /**
     * @param n identifier of the specified tableau pile
     */
    public void foundToPile(int n){//method to move cards from the foundation back to the tableaux
        tableaux.getTableau(n-1).cc.addCard(foundations);
    }
    /**
     * @param ip Input String by user
     */
    public void inputValues(String ip){//method to read inputs
        int ip1, ip2;
        ip = ip.toUpperCase();

        if((ip.length())>2||ip.length() ==0){//ensure that inputs a string that is not too long
            run();
            System.out.println("Invalid Move");
            return;
        }
        else if(ip.length() == 1){
            if(ip.equalsIgnoreCase("D")){//read in if user wanted to draw a new card
                draw();
                return;
            }
            else if(ip.equalsIgnoreCase("n")){
                for(int i = 0; i<4;i++){
                    foundations.getFoundation(i).isFull = true;
                }
                foundations.checkFull();
            }
            else{System.out.println("Invlaid Move");}
        }
        else if(ip.matches("[0-9]+")&& ip.length() ==2){//read in if the user wanted to move cards between tableaux
               ip1 = Integer.valueOf(ip.charAt(0))- 48;
               ip2 = Integer.valueOf(ip.charAt(1))- 48;
               tableauToTableau(ip1, ip2);
               return;
           }
        else if(Character.isDigit(ip.charAt(0)) && ((Character) ip.charAt(1)).equals('F') && ip.length() ==2){//check if user wants to move cards from a tableau to a foundation
            ip1 = Integer.valueOf(ip.charAt(0))-48;
            pileToFound(ip1);
        }       
        else if(Character.isDigit(ip.charAt(1)) && ((Character) ip.charAt(0)).equals('F') && ip.length() ==2){//check if user wants to move cards from a foundation to a tableau
            ip1 = Integer.valueOf(ip.charAt(0))-66;
            foundToPile(ip1);
        }
        else if(Character.isDigit(ip.charAt(1)) && ((Character) ip.charAt(0)).equals('P') && ip.length() ==2){//check if user wants to move cards from waste to a tableau
            ip1 = Integer.valueOf(ip.charAt(1))-48;
            wasteToPile(ip1); 
        }
        else if(((Character) ip.charAt(0)).equals('P')  && ((Character) ip.charAt(1)).equals('F') && ip.length() ==2){//check if user wants to move cards from a the waste pile to a foundation
            wasteToFound();
        }  
        else {
            System.out.println("Invalid Move");
        }
    }
}
