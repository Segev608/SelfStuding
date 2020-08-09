int resolution = 10;
//before Setup loop starting
int w = 800;
int h = 600;
int[] probability = {0, 1, 0, 1, 0, 1, 0, 1, 0, 0}; // only 10% chance to get life in this cell\
int[][] board = new int[w/20][h/20];


void setup() {
  size(800, 600);
  background(255);

  //creating horizontical lines
  stroke(0);
  strokeWeight(1);
  for (int i=0; i<w/2; i += resolution)
    line(i*2, 0, i*2, height);

  //creating vertical lines
  for (int i=0; i<h/2; i+=resolution)
    line(0, i*2, width, i*2);
}

// the x'th block from right
// the y'th block from up
// operation - {true - produce, false - kill}
void controlLife(int x, int y, boolean operation) {
  fill(255 * (1-int(operation)));
  rect(20*x, 20*y, 20, 20);
}

//Initialize board with value from probability boarday [above]
//There are 2 option:
// case 1: glider generation
// case 2: random cell creator
void initializeBoard(int[][] board, int option) {

  switch(option) {
  case 1:
    // Gosper glider gun (from 48-97)
    board[1][5] = 1;
    board[1][6] = 1;
    board[2][5] = 1;
    board[2][6] = 1;

    board[11][5] = 1;
    board[11][6] = 1;
    board[11][7] = 1;

    board[12][4] = 1;
    board[12][8] = 1;

    board[13][3] = 1;
    board[13][9] = 1;

    board[14][3] = 1;
    board[14][9] = 1;

    board[15][6] = 1;

    board[16][4] = 1;
    board[16][8] = 1;

    board[17][5] = 1;
    board[17][6] = 1;
    board[17][7] = 1;

    board[18][6] = 1;

    board[21][3] = 1;
    board[21][4] = 1;
    board[21][5] = 1;

    board[22][3] = 1;
    board[22][4] = 1;
    board[22][5] = 1;

    board[23][2] = 1;
    board[23][6] = 1;

    board[25][1] = 1;
    board[25][2] = 1;
    board[25][6] = 1;
    board[25][7] = 1;

    board[35][3] = 1;
    board[35][4] = 1;
    board[36][3] = 1;
    board[36][4] = 1;
    break;

  case 2:
    for (int i=0; i<40; i++)
      for (int j=0; j<30; j++)
        board[i][j] = probability[int(random(0, 9))];
    break;
  }
}

// takes the game board and for every cell, counting the number of
// neighbors he has
int countNeighbors(int[][] board, int indexX, int indexY) {
  int sum = 0;
  int value = 0;
  for (int i=-1; i<2; i++) {
    for (int j=-1; j<2; j++) {
      if (i != 0 || j != 0) {
        value = board[(indexX + i + w/20) % 40][(indexY + j + h/20) % 30];
        sum += value;
      }
    }
  }
  return sum;
}

// gets the current board and creates anthoer one - upadted!
int[][] handleBoard(int[][] board) {
  int[][] temp = new int[w/20][h/20];
  boolean alive = false;
  int neighbors = 0;

  //copy the current board
  for (int i=0; i<w/20; i++) {
    for (int j=0; j<h/20; j++) {
      temp[i][j] = board[i][j];
    }
  }

  for (int i=0; i<w/20; i++) {
    for (int j=0; j<h/20; j++) {
      //in case the cell is black - it means that he is alive
      alive = (board[i][j] == 1) ? true:false;
      neighbors = countNeighbors(board, i, j);

      // over-population/under-population - cause this cell to die
      if (alive && (neighbors <= 1 || neighbors >= 4))
        temp[i][j] = 0;

      // reproduction - cause dead cell to born
      if (!alive && neighbors == 3)
        temp[i][j] = 1;
    }
  }

  //copy the updated board
  for (int i=0; i<w/20; i++) {
    for (int j=0; j<h/20; j++) {
      board[i][j] = temp[i][j];
    }
  }
  return board;
}

int x;
int y;
boolean flag = true;
boolean continueOn = false;
void draw() {
  if (flag) {
    // exceuting initialization only once
    initializeBoard(board, 1);
    flag = false;
  }

  board = handleBoard(board);
  for (x=0; x<width/20; x++)
    for (y=0; y<height/20; y++) {
      controlLife(x, y, boolean(board[x][y]));
    }
}
