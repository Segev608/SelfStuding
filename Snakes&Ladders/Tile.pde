// Object that hold the information about 
// every tile in the game - board.
class Tile {
  private int index; // The current tile position in the grid
  private boolean isSpecial = false; // is Snake or Ladder
  private boolean isSnake = false;
  private boolean isLadder = false;
  private int toward = -1; // if isSpecial is true - define jump location

  public Tile(int index) {
    this.index = index;
  }

  public int getIndex() {
    return index;
  }

  public boolean getSpecial() {
    return isSpecial;
  }

  public int getToward() {
    return toward;
  }

  public boolean getSnake() {
    return isSnake;
  }

  public boolean getLadder() {
    return isLadder;
  }

  //type: [1:snake] [2:ladder]
  public void setTrap(int dstTrap, int type) {
    isSpecial = true;
    toward = dstTrap;
    switch(type) {
    case 1: 
      isSnake = true; 
      break;
    case 2: 
      isLadder = true; 
      break;
    }
  }
}
