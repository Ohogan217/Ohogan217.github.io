import java.util.Arrays;
import java.util.Scanner;

public class Patience {
  String userip;

  public static void main(String[]args){
    for(;;){//for loop to make game replayable
      Deck deck = new Deck();//initiailise new values for the game
      Stock stock = new Stock(deck);
      Waste waste = new Waste(stock);
      Tableaux tableaux = new Tableaux(deck);
      Score score = new Score();
      Foundations foundations = new Foundations();
      String ip;
      Scanner scan;

      Interface interf = new Interface(stock, waste, tableaux, score, foundations);
      for(;;){//for loop to input the moves

        System.out.println("Enter Move");
        scan = new Scanner(System.in);
        ip = scan.nextLine();
        if(ip.equalsIgnoreCase("q")){//check if user wants to quit game
          System.out.println("Game aborted");
          break;
        }
        if(Arrays.asList(interf.foundations.won).contains(false)){
        // }
        // else{
            System.out.println("Game won!!!!!\nScore: "+ score.score);
            break;
        }
        interf.inputValues(ip);
        
      }
      System.out.println("Play again? Y/N");
      scan = new Scanner(System.in);
      ip = scan.nextLine();
      if(ip.equalsIgnoreCase("n")){
        System.out.println("Ciao");
        break;
      }
    }

  }
}




