// Game developed by Segev Burstein [11/08/2020]
// Processing 3.5.3


int cellsN = 100; 
int cell_width;
int cell_height;
int qube; // qube game (hold values between 1 to 6)
GameBoard gb;
int level;


void setup() {
  size(600, 600); // width and height initialized

  gb = new GameBoard(100);
  level = gb.getSize();

  //cell size
  cell_width = int(width / level);
  cell_height = int(height / level);
}

// Draw functionality

void createGrid() {
  strokeWeight(2);

  // Vertical lines
  int i=0;
  int j;
  for (i=0; i<level; i++) {
    line(i*cell_width, 0, i*cell_width, height);
    line(0, i*cell_height, width, i*cell_height);
  }

  // filling the grid with indexes
  int currentCell;
  // reset the position of the text to the center of the cell
  int movementX = cell_width/2; 
  int movementY = (cell_height/2)+10; // adding offset (10) to correct centralization
  for (i=0; i<level; i++) {
    for (j=0; j<level; j++) {
      currentCell = j*level + i;
      if (currentCell == 0) {
        textSize(18);
        textAlign(CENTER);
        text("Start", movementX, movementY);
        fill(0);
      } else if (currentCell == 99) {
        textSize(18);
        textAlign(CENTER);
        fill(255, 0, 0);
        text("Finish", movementX, movementY);
      } else {
        textSize(22);
        textAlign(CENTER);
        text(Integer.toString(currentCell), movementX, movementY);
        fill(0);
      }
      movementY += cell_height;
    }
    movementY = (cell_height/2)+10;
    movementX += cell_width;
  }
}

int throwQube() {
  return int(random(1, 7));
}

void colorPlayerPosition(int centerX, int centerY) {
  // color in red the current position of the player
  fill(255, 0, 0);
  rect(centerX * cell_width, centerY * cell_height, cell_width, cell_height, 7);
}

int playerX = 0;
int playerY = 0;
int move = 0;
void mousePressed() {
  int turn = gb.playTurn();
  if (turn > 0 && turn < 7) move += turn;
  else if (turn >= 100) move = (turn - 303); //atbs...
  // in case player needs to jump over finish cell - turn him back & try again! 
  else move = (level*level-1) + turn; 
  playerX = move % 10;
  playerY = move / 10;
  /* ###DEBUG###  println("playerX: " +playerX+ "  playerY: "+playerY); */
}

//if isLadder true -> draw Ladder portal
//else             -> draw Snake portal
void drawSpeicalJumpCell(int srcX, int srcY, int dstX, int dstY, boolean isLadder) {
  strokeWeight(4);
  if (isLadder)
    stroke(198, 146, 62);
  else
    stroke(27, 247, 69);

  // ENTERENCE PORTAL LADDER
  ellipseMode(RADIUS); 
  noFill(); 
  ellipse((srcX) * (cell_width) + cell_width/2, (srcY) * (cell_height) + cell_height/2, 30, 30); 

  ellipseMode(CENTER); 
  noFill();
  ellipse((srcX) * (cell_width) + cell_width/2, (srcY) * (cell_height) + cell_height/2, 40, 40); 

  // EXIT PORTAL LADDER
  ellipseMode(RADIUS); 
  noFill(); 
  ellipse((dstX) * (cell_width) + cell_width/2, (dstY) * (cell_height) + cell_height/2, 30, 30); 

  ellipseMode(CENTER); 
  noFill();
  ellipse((dstX) * (cell_width) + cell_width/2, (dstY) * (cell_height) + cell_height/2, 40, 40); 

  stroke(0);
}

void handleTrapCreation(GameBoard board) {
  for (int i=0; i<level; i++) {
    for (int j=0; j<level; j++) {
      if (board.getSpecificTile(i, j).getSpecial()) {
        int location = board.getSpecificTile(i, j).getToward();
        boolean drawLadder = board.getSpecificTile(i, j).getLadder();
        drawSpeicalJumpCell(j, i, location%10, location/10, drawLadder);
      }
    }
  }
}

void draw() {
  background(255); 
  createGrid();
  handleTrapCreation(gb);
  colorPlayerPosition(playerX, playerY);
}
