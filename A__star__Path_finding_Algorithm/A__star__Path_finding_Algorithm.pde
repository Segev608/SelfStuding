int cols = 30; // x movement
int rows = 30; // y movement
int w, h;

Cell[][] grid;
ArrayList<Cell> optimalRoute;

ArrayList<Cell> openSet;
ArrayList<Cell> closedSet;

// A* algorithm would find the optimal route from
// src cell to dst cell (configurable)

Cell source, destination; 

void setup() {
  size(800, 800);

  //Initialize the width & height of every cell
  w = width / cols;
  h = height / rows;

  // each and every cell in the grid represents a vertex
  // in the graph 
  grid = new Cell[rows][cols];

  // Initialize each and every Cell object with it's coordinates
  for (int y=0; y<cols; y++) {
    for (int x=0; x<rows; x++) {
      grid[y][x] = new Cell(x, y);
    }
  }

  for (int y=0; y<cols; y++) {
    for (int x=0; x<rows; x++) {
      grid[y][x].addNeighbors();
    }
  }

  openSet = new ArrayList<Cell>();
  closedSet = new ArrayList<Cell>();
  optimalRoute = new ArrayList<Cell>();

  // Initialize start & end
  source = grid[0][0];
  destination = grid[rows-1][cols-1];

  // make sure that the src & dst aren't obstecles
  source.wall = false;
  destination.wall = false;

  openSet.add(source);
}

Cell getCell(ArrayList<Cell> group, int index) {
  Cell c = null;
  if (group.size() > 0)
    c = group.get(index);
  return c;
}

// some helpful local variables
int index;
Cell current;
Cell neighbor;
Cell temp;
int tempG;
float wallDestribution = 60.0; // 10% for now

//define the color for each set
color open = color(0, 255, 0, 150);
color closed = color(255, 0, 0, 150);
color path = color(0, 0, 255, 150);

void draw() {
  if (openSet.size() > 0) {
    // there are more vertex to check or 
    // it has not reached the destination yet

    // search after the cell with the lowest 'current' F(n)
    int lowestIndex = 0;
    for (index=0; index<openSet.size() - 1; index++) {
      if (getCell(openSet, index).f_val < getCell(openSet, lowestIndex).f_val)
        lowestIndex = index;
    }

    current = getCell(openSet, lowestIndex);

    // the algorithm has reached the destination
    if (current == destination) {
      closedSet.add(current);
      noLoop();
      println("DONE!");
    } else {
      openSet.remove(lowestIndex);
      closedSet.add(current);
    }

    for (index = 0; index<current.myNeighbors.size(); index++) {
      neighbor = getCell(current.myNeighbors, index);

      // the distance from the source cell has increased by 1
      // and so - the cost!
      // but it sould be checked that this cell might be got better g from another neighbor
      if (!closedSet.contains(neighbor) && !neighbor.wall) {
        tempG = current.g_val + 1;
        if (openSet.contains(neighbor)) { // if this neighbors was not evaluated yet
          if (tempG < neighbor.g_val)
            neighbor.g_val = tempG; // we found for this cell g value
        } else {
          neighbor.g_val = tempG;
          //because of this neighbors was not in the openSet - insert it
          openSet.add(neighbor);
        }
        // our educated guess for the 'left over' distance 
        neighbor.h_val = heuristic(neighbor, destination);
        neighbor.f_val = neighbor.g_val + neighbor.h_val;
        neighbor.previous = current;
      }
    }
  } else {
    // the algorithm has checked everything and it give 2 option
    // 1. it reached the end - found the optimal route
    // 2. it got stuck - no route found!
    failMessage();
    noLoop();
    return;
  }

  // show grid
  for (int r=0; r<rows; r++) {
    for (int c=0; c<cols; c++) {
      grid[r][c].show(color(255));
    }
  }

  // show openSet
  for (index = 0; index<openSet.size() - 1; index++) {
    getCell(openSet, index).show(open);
  }

  // show closedSet
  for (index = 0; index<closedSet.size() - 1; index++) {
    getCell(closedSet, index).show(closed);
  }

  optimalRoute = new ArrayList<Cell>();
  temp = current;
  optimalRoute.add(temp);
  while (temp.previous != null) {
    optimalRoute.add(temp.previous);
    temp = temp.previous;
  }

  // show path
  for (index = 0; index<optimalRoute.size() - 1; index++) {
    getCell(optimalRoute, index).show(path);
  }
}

// returns the heuristic, "educated guess", of the distance that 
// this cell is far from the destination
public int heuristic(Cell a, Cell b) {
  //return (int)(abs(a.x - b.x) + abs(a.y - b.y));
  return (int)dist(a.x, a.y, b.x, b.y);
}

public void failMessage() {
  textSize(120);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("NO PATH", width/2, height/2);
}
