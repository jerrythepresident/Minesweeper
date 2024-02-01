

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 30
public final static int NUM_ROWS=30;
public final static int NUM_COLS=30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs=new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup()
{
    size(600, 600);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for(int row=0;row<NUM_ROWS;row++)
        for(int col=0;col<NUM_COLS;col++)
            buttons[row][col]=new MSButton(row,col);
    for(int i=0;i<30;i++)    
        setBombs();
}
public void setBombs()
{
    int row=(int)(Math.random()*NUM_ROWS);
    int col=(int)(Math.random()*NUM_COLS);
    if(bombs.contains(buttons[row][col])==false)
        bombs.add(buttons[row][col]);
}

public void draw ()
{
    background(0);
    if(isWon())
        displayWinningMessage();
    
}
public boolean isWon()
{
    for(int r=0;r<NUM_ROWS;r++)
        for(int c=0;c<NUM_COLS;c++)
        {
            if(bombs.contains(buttons[r][c])&&buttons[r][c].isMarked()==false)
                return false;
            if(bombs.contains(buttons[r][c])==false&&buttons[r][c].isMarked())
                return false;
        }
    return true;
}
public void displayLosingMessage()
{
    for(int i=0;i<bombs.size();i++)
        if(bombs.get(i).isClicked()==false)
            bombs.get(i).mousePressed();
        buttons[16][11].setLabel("Y");
        buttons[16][12].setLabel("O");
        buttons[16][13].setLabel("U");
        buttons[16][14].setLabel(" ");
        buttons[16][15].setLabel("L");
        buttons[16][16].setLabel("O");
        buttons[16][17].setLabel("S");
        buttons[16][18].setLabel("E");
        buttons[16][19].setLabel("!");
}
public void displayWinningMessage()
{
    if(isWon()==true)
    {
        buttons[16][11].setLabel("Y");
        buttons[16][12].setLabel("O");
        buttons[16][13].setLabel("U");
        buttons[16][14].setLabel(" ");
        buttons[16][15].setLabel("W");
        buttons[16][16].setLabel("I");
        buttons[16][17].setLabel("N");
        buttons[16][18].setLabel("!");
    }
}   

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 600/NUM_COLS;
        height = 600/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed==true)
        {
            marked=!marked;
            if(!marked)
                clicked=false;
        }
        
        else if(bombs.contains(this))
        {
            displayLosingMessage();
            /*for(int r=0;r<NUM_ROWS;r++)
            {
                for(int c=0;c<NUM_COLS;c++)
                {
                    if(bombs.contains(buttons[r][c]))
                    {
                        buttons[r][c].mousePressed();
                    }
                }
            }
            */
            for(int i=0;i<bombs.size();i++)
                if(bombs.get(i).isClicked()==false)
                bombs.get(i).mousePressed();

            
        }
        else if(countBombs(r,c)>0)
            setLabel(str(countBombs(r,c)));
        else
        {
            
            if(isValid(r-1,c-1))
                if(!buttons[r-1][c-1].isClicked())
                    buttons[r-1][c-1].mousePressed();
            if(isValid(r-1,c))
                if(!buttons[r-1][c].isClicked())
                    buttons[r-1][c].mousePressed();
            if(isValid(r-1,c+1))
                if(!buttons[r-1][c+1].isClicked())
                    buttons[r-1][c+1].mousePressed();
            if(isValid(r,c-1))
                if(!buttons[r][c-1].isClicked())
                    buttons[r][c-1].mousePressed();
            if(isValid(r,c+1))
                if(!buttons[r][c+1].isClicked())
                    buttons[r][c+1].mousePressed();
            if(isValid(r+1,c-1))
                if(!buttons[r+1][c-1].isClicked())
                    buttons[r+1][c-1].mousePressed();
            if(isValid(r+1,c))
                if(!buttons[r+1][c].isClicked())
                    buttons[r+1][c].mousePressed();
            if(isValid(r+1,c+1))
                if(!buttons[r+1][c+1].isClicked())
                    buttons[r+1][c+1].mousePressed();
        }

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if(clicked && bombs.contains(this)) 
            fill(255,0,0);
        else if(clicked)
            fill(200);
        else 
            fill(100);

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r<NUM_ROWS&&c<NUM_COLS&&c>=0&&r>=0)
            return true;
        else
            return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row-1,col-1))
            if(bombs.contains(buttons[row-1][col-1]))
                numBombs++;
        if(isValid(row-1,col))
            if(bombs.contains(buttons[row-1][col]))
                numBombs++;
        if(isValid(row-1,col+1))
            if(bombs.contains(buttons[row-1][col+1]))
                numBombs++;
        if(isValid(row,col-1))
            if(bombs.contains(buttons[row][col-1]))
                numBombs++;
        if(isValid(row,col+1))
            if(bombs.contains(buttons[row][col+1]))
                numBombs++;
        if(isValid(row+1,col-1))
            if(bombs.contains(buttons[row+1][col-1]))
                numBombs++;
        if(isValid(row+1,col))
            if(bombs.contains(buttons[row+1][col]))
                numBombs++;
        if(isValid(row+1,col+1))
            if(bombs.contains(buttons[row+1][col+1]))
                numBombs++;
        return numBombs;
    }
}
