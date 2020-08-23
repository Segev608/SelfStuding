class Cell {
  //holds the coordinate of the cell
  int x;
  int y;

  // this A* algorithm uses this formula to find 
  // the optimal solution: F(n) = G(n) + H(n)
  // which: n    - next node on the path
  //        G(n) - cost of the path from *source* to n
  //        H(n) - heuristic function that determine the cost of the 'cheapest'
  //               path from n to *destination*
  int f_val = 0;
  int g_val = 0;
  int h_val = 0;

  Cell previous;

  ArrayList<Cell> myNeighbors;

  // in order to implement obstacles 
  boolean wall;

  public Cell(int j, int i) {
    x = j;
    y = i;
    myNeighbors = new ArrayList<Cell>();
    previous = null;
    wall = (random(1) < wallDestribution/100.0)? true : false;
  }

  public void show(color c) {
    stroke(127);
    fill(c);
    if (wall) fill(0); // obstacles are black 
    rect(x * w, y * h, w-1, h-1);
  }

  public void addNeighbors() {
    // the ability to move: [UP, DOWN, LEFT, RIGHT]
    if (y > 0)
      myNeighbors.add(grid[y-1][x]); // UP
    if (y < rows-1)
      myNeighbors.add(grid[y+1][x]); // DOWN
    if (x > 0)
      myNeighbors.add(grid[y][x-1]); // LEFT
    if (x < cols-1)
      myNeighbors.add(grid[y][x+1]); // RIGHT

    // the ability to move in diagonal locations
    if (x > 0 && y > 0)
      myNeighbors.add(grid[y-1][x-1]); // UPPER_LEFT
    if (x > 0 && y < rows-1)
      myNeighbors.add(grid[y+1][x-1]); // BOTTOM_LEFT
    if (x < cols - 1 && y > 0)
      myNeighbors.add(grid[y-1][x+1]); // UPPER_RIGHT
    if (x < cols - 1 && y < rows-1)
      myNeighbors.add(grid[y+1][x+1]); // BOTTOM_RIGHT
  }
}
