public class Score {
    int score;
    public Score(){//constructor for score object, at 0 at game start
        score = 0;
    }
    public void showScore(){//method to show score
        System.out.println("Score - " + this.score +"\t\t Q - Quit");
    }
    public void setScore(int n){//method to set score
        score = n;
    }
    public void addScore(int n){//method to add to score
        score +=n;
    }
}
