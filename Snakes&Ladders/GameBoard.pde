class GameBoard {
  private int playerCurrentPosition = 0; // player starts at the begining
  private Tile[][] board;
  private boolean isWin = false;
  private int size;

  //cellN must be a square number
  public GameBoard(int cellN) {
    size = int(sqrt(cellN));
    //Initializing board game level X level size
    board = new Tile[size][size];

    //fill index values
    for (int i=0; i<size; i++) {
      for (int j=0; j<size; j++) {
        board[i][j] = new Tile(i*size + j);
      }
    }

    //Initialize traps and ladders
    board[3][3].setTrap(38, 2); // example, create ladder from 33 to 39
    board[4][5].setTrap(82, 2);
    board[0][7].setTrap(59, 2);

    board[2][2].setTrap(5, 1); // example, create snake from 22 to 2
    board[8][6].setTrap(51, 1);
    board[9][8].setTrap(1, 1);
  }

  public Tile getSpecificTile(int i, int j) {
    return board[i][j];
  }

  public int getSize() {
    return size;
  }

  public int getCurrentPos() {
    return playerCurrentPosition;
  }

  public int playTurn() {
    if (!isWin) {
      int qube = throwQube();
      int nextMove = playerCurrentPosition + qube;
      /*    ###DEBUG###
       println("NM: "+nextMove);
       println("QV: "+qube); */

      // In case he landed on special tile [Ladder or Snake]
      // I've add the value of the jump to 100 and the (DL) Draw Layer will 
      // extract it from there :)
      if (nextMove < size * size - 1 && board[nextMove/10][nextMove%10].getSpecial()) {
        int jumpLocation = board[nextMove/10][nextMove%10].getToward();
        playerCurrentPosition = jumpLocation;
        /* ###DEBUG###  println("JL: "+jumpLocation); */
        return (jumpLocation + 303);
      }

      // In case the player has landed sucessfuly on the FINISH tile
      if (nextMove == size * size - 1) {
        isWin = true;
      }

      // In case the player is very close to end && got a qube value that adding it 
      // to his current position, would pass over the finish tile 
      if (nextMove > size * size - 1) {
        int goBack = (qube - (int(pow(size, 2)) - 1 - playerCurrentPosition)); // qube - leftOver
        playerCurrentPosition = (int(pow(size, 2)) - 1) - goBack;
        /* ###DEBUG###  println("MB: "+playerCurrentPosition); */

        // There is a possibility that due to back movement, the player stapped on 
        // snake tile.
        if (nextMove < size * size - 1 && board[nextMove/10][nextMove%10].getSpecial()) {
          int jumpLocation = board[nextMove/10][nextMove%10].getToward();
          playerCurrentPosition = jumpLocation;
          /* ###DEBUG###  println("JL: "+jumpLocation); */
          return (jumpLocation + 303);
        }
        return  -goBack;

        // normal turn
      } else {
        playerCurrentPosition += qube;
      }
      return qube;
    }
    //GAME_OVER
    return 0;
  }
}
