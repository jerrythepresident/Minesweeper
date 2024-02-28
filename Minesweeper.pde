private MSButton[][] buttons;
private ArrayList <MSButton> bombs;
private int rows = 30;
private int columns = 30;
private boolean isLost = false;
private int tileCount = 0;

void setup ()
{
    textAlign(CENTER,CENTER);
    size(900, 900);
    buttons = new MSButton[rows][columns];
    bombs = new ArrayList <MSButton>();
    for(int j = 0;j<columns;j++){
        for(int i = 0; i < rows;i++){
            buttons[i][j]= new MSButton(i,j);
    }
} 
    setBombs();
}

public void setBombs(){  
  for (int i = 0; i < 150; i++) {
    final int r1 = (int)(Math.random()*30);
    final int r2 = (int)(Math.random()*30);
    if ((bombs.contains (buttons[r1][r2])) == false) {
      bombs.add(buttons[r1][r2]);
    }
    else {i+=-1;}
}
}

public void draw (){
    background(0);
    if(isWon()){
        WinningMessage();
    }
    for (int i = 0; i < rows; i++) {
     for (int j = 0; j < columns; j++) {
        buttons[i][j].draw();
      } 
    }
}

public boolean isWon()
{
  return false;
}

public void LosingMessage()
{     
    for(int i=0;i<bombs.size();i++){
        if(bombs.get(i).isClicked()==false){
            bombs.get(i).mousePressed();
        }
    }
    isLost = true;
    buttons[rows/2][(columns/2)-4].setLabel("Y");
    buttons[rows/2][(columns/2)-3].setLabel("O");
    buttons[rows/2][(columns/2-2)].setLabel("U");
    buttons[rows/2][(columns/2-1)].setLabel("");
    buttons[rows/2][(columns/2)].setLabel("L");
    buttons[rows/2][(columns/2+1)].setLabel("O");
    buttons[rows/2][(columns/2+2)].setLabel("S");
    buttons[rows/2][(columns/2+3)].setLabel("E");
}

public void WinningMessage()
{
    isLost = true;
    buttons[rows/2][(columns/2)-4].setLabel("Y");
    buttons[rows/2][(columns/2)-3].setLabel("O");
    buttons[rows/2][(columns/2-2)].setLabel("U");
    buttons[rows/2][(columns/2-1)].setLabel("");
    buttons[rows/2][(columns/2)].setLabel("W");
    buttons[rows/2][(columns/2+1)].setLabel("I");
    buttons[rows/2][(columns/2+2)].setLabel("N");
    buttons[rows/2][(columns/2+3)].setLabel("!");
}

public void mousePressed (){
  int mX = mouseX;
  int mY = mouseY;
  buttons[(int)(mY/30)][(int)(mX/30)].mousePressed();
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;   
    public MSButton (int rr, int cc){
        width = 900/columns;
        height = 900/rows;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
    }

public boolean isMarked(){
        return marked;
}

public boolean isClicked(){
        return clicked;
}
    
public void mousePressed (){
      if (isLost == false) {
        if (mouseButton == RIGHT && buttons[r][c].isClicked()) {     
        }
        else if (mouseButton == RIGHT) {
          marked = !marked;
        }
        else if (marked == true) {}
        else if (bombs.contains(this)) {
          clicked = true;
          LosingMessage();
        }
        else if (countbomb(r,c) > 0) {
          label = ""+countbomb(r,c);
          if (!clicked) {tileCount+=1;}
          if (tileCount == 900-bombs.size()) {WinningMessage();}
          clicked = true;
        }
        else {
          if (!clicked) {tileCount+=1;}
          if (tileCount == 900-bombs.size()) {WinningMessage();}
          clicked = true;
          
          if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked()) {
          buttons[r-1][c-1].mousePressed();} 
          if(isValid(r-1,c) && !buttons[r-1][c].isClicked()) {
          buttons[r-1][c].mousePressed();}
          if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked()){
          buttons[r-1][c+1].mousePressed();}
          
          if(isValid(r,c-1) && !buttons[r][c-1].isClicked()){
          buttons[r][c-1].mousePressed();}
          if(isValid(r,c+1) && !buttons[r][c+1].isClicked()){
          buttons[r][c+1].mousePressed();}
          
          if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked()){
          buttons[r+1][c-1].mousePressed();}
          if(isValid(r+1,c) && !buttons[r+1][c].isClicked()){
          buttons[r+1][c].mousePressed();}
          if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked()){
          buttons[r+1][c+1].mousePressed();}
        }
      }
    }

public void draw () {    
if (marked){
    fill(0);
}
         else if( !marked && clicked && bombs.contains(this) ) {
             fill(255,0,0);
         }
         else if( marked && bombs.contains(this) ) {
             fill(100);
         }
         else if(!marked && clicked && !bombs.contains(this)) {
             fill(200);
         }
        else if(clicked){
            fill(200);
        }
        else {
            fill(100);
        }
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
}

public void setLabel(String newLabel){
        label = newLabel;
}

public boolean isValid(int r, int c){
        if (r <rows && r >= 0 && c < columns && c >= 0) {
        return true;
      }
        return false;
 }

public int countbomb(int row, int col){
        int bombnum = 0;
        if (isValid(row-1,col) == true && bombs.contains(buttons[row-1][col]))
        {
            bombnum++;
        }
        if (isValid(row+1,col) == true && bombs.contains(buttons[row+1][col]))
        {
            bombnum++;
        }
         if (isValid(row,col-1) == true && bombs.contains(buttons[row][col-1]))
        {
            bombnum++;
        }
         if (isValid(row,col+1) == true && bombs.contains(buttons[row][col+1]))
        {
            bombnum++;
        }
         if (isValid(row-1,col+1) == true && bombs.contains(buttons[row-1][col+1]))
        {
            bombnum++;
        }
         if (isValid(row-1,col-1) == true && bombs.contains(buttons[row-1][col-1]))
        {
            bombnum++;
        }
         if (isValid(row+1,col+1) == true && bombs.contains(buttons[row+1][col+1]))
        {
            bombnum++;
        }
         if (isValid(row+1,col-1) == true && bombs.contains(buttons[row+1][col-1]))
        {
            bombnum++;
        }
        return bombnum;
    }
}
