class Cell {
  private int x; 
  private int y;
  private boolean[] walls = {true, true, true, true}; // up, right, bottom, left
  private boolean isVisited; 

  public Cell(int x, int y) {
    this.x = x;
    this.y = y;
    isVisited = false;
  }

  public void show() {
    int currX = x * sqrSize;
    int currY = y * sqrSize;

    stroke(127);

    if (walls[0])//up line
      line(currX, currY, currX + sqrSize, currY);

    if (walls[1])//right line
      line(currX + sqrSize, currY, currX + sqrSize, currY + sqrSize);

    if (walls[2])//bottom line
      line(currX + sqrSize, currY + sqrSize, currX, currY + sqrSize);

    if (walls[3])//left line
      line(currX, currY + sqrSize, currX, currY);

    if (isVisited) {
      noStroke();
      fill(255, 0, 127, 100);
      rect(currX, currY, sqrSize, sqrSize);
    }
  }


  public Cell checkNeighbors() {
    Cell[] neighbors = new Cell[4]; //[up,right,down,left]

    Cell top = (y != 0)?maze[y-1][x]:null;
    Cell right =(x != cols-1)? maze[y][x+1]:null;
    Cell bottom = (y != rows-1)?maze[y+1][x]:null;
    Cell left = (x != 0)?maze[y][x-1]:null;

    //Check edge cases
    if (top != null && !top.isVisited)
      neighbors[0] = top;

    if (right != null && !right.isVisited) 
      neighbors[1] = right;

    if (bottom != null && !bottom.isVisited)
      neighbors[2] = bottom;

    if (left != null && !left.isVisited) 
      neighbors[3] = left;


    printArray(neighbors);


    int len = arrLength(neighbors); 
    if (len > 0) {
      while (true) {
        int index = int(random(0, 4));
        if (neighbors[index] != null)
          return neighbors[index];
      }
    } else
      return null;
  }


  public void visited() {
    isVisited = true;
  }

  public void display() {
    int currX = x * sqrSize;
    int currY = y * sqrSize;

    noStroke();
    fill(0, 255, 0, 100);
    rect(currX, currY, sqrSize, sqrSize);
  }

  public int arrLength(Cell[] l) {
    int counter = 0;
    for (Cell c : l) {
      if (c != null)
        counter++;
    }
    println(counter);
    return counter;
  }
}
