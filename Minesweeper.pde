import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
int NUM_ROWS = 20;
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    bombs = new ArrayList <MSButton> ();
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for( int r = 0; r < NUM_ROWS; r++)
        for( int c = 0; c < NUM_COLS; c++)
            buttons[r][c] = new MSButton(r,c);
    
    setBombs();
}
public void setBombs()
{
    //your code
    for( int i = 0; i < NUM_ROWS; i++)
    {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);

    if (!bombs.contains(buttons[r][c]))
        {
            bombs.add(buttons[r][c]);
        }
   }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(!bombs.contains(buttons[r][c]) && !buttons[r][c].isClicked())
                return false;
        }

    return true;

}
public void displayLosingMessage()
{
    //your code here
    buttons[10][5].setLabel("L");
    buttons[10][6].setLabel("O");
    buttons[10][7].setLabel("S");
    buttons[10][8].setLabel("E");
    buttons[10][9].setLabel("R");
    
    for (int r = 0; r < NUM_ROWS; r++)
     {
        for (int c = 0; c < NUM_COLS; c++)
            {
                if (bombs.contains(buttons[r][c]))
                    buttons[r][c].mousePressed();
            }
     }

}
public void displayWinningMessage()
{
    //your code here
    buttons[11][5].setLabel("W");
    buttons[11][6].setLabel("I");
    buttons[11][7].setLabel("N");
    buttons[11][8].setLabel("N");
    buttons[11][9].setLabel("E");
    buttons[11][10].setLabel("R");

    
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;

    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
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

        //your code here
        if(keyPressed == true)
        {
            marked = !marked;
            if(marked == false)
            {
                clicked = false;
            }
        }
        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c) > 0)
        {
            setLabel(""+countBombs(r,c));
        }
        else
        {
            if(isValid(r,c-1) && buttons[r][c-1].isClicked() == false)
                (buttons[r][c-1]).mousePressed();
            if(isValid(r,c+1) && buttons[r][c+1].isClicked() == false)
                (buttons[r][c+1]).mousePressed();
            if(isValid(r-1,c) && buttons[r-1][c].isClicked() == false)
                (buttons[r-1][c]).mousePressed();
            if(isValid(r+1,c) && buttons[r+1][c].isClicked() == false)
                (buttons[r+1][c]).mousePressed();
            if(isValid(r-1,c-1) && buttons[r-1][c-1].isClicked() == false)
                (buttons[r-1][c-1]).mousePressed();
            if(isValid(r+1,c+1) && buttons[r+1][c+1].isClicked() == false)
                (buttons[r+1][c+1]).mousePressed();
            if(isValid(r+1,c-1) && buttons[r+1][c-1].isClicked() == false)
                (buttons[r+1][c-1]).mousePressed();
             if(isValid(r-1,c+1) && buttons[r-1][c+1].isClicked() == false)
                (buttons[r-1][c+1]).mousePressed();


        }
        
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

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
        //your code here
        if(((r >= NUM_ROWS) && (r < 10)) && ((c >= NUM_COLS) && (c < 10)))
        {
            return true;
        }
        else
        {
             return false;
        }
       
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(r+1,c)&&bombs.contains(buttons[r+1][c]))
        {
            numBombs++;
        }
         if(isValid(r+1,c-1)&&bombs.contains(buttons[r+1][c-1]))
        {
            numBombs++;
        }
         if(isValid(r-1,c)&&bombs.contains(buttons[r-1][c]))
        {
            numBombs++;
        }
         if(isValid(r+1,c+1)&&bombs.contains(buttons[r+1][c+1]))
        {
            numBombs++;
        }
         if(isValid(r-1,c+1)&&bombs.contains(buttons[r-1][c+1]))
        {
            numBombs++;
        }
        return numBombs;
    }
}



