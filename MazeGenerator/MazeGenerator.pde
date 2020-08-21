import java.util.ArrayDeque;

int cols, rows;
int sqrSize = 40;

Cell[][] maze;
Cell current;
ArrayDeque<Cell> stack = new ArrayDeque<Cell>();

void setup() {
  size(800, 800);
  stack = new ArrayDeque<Cell>();
  cols = int(height/sqrSize);
  rows = int(width/sqrSize);
  maze = new Cell[rows][cols];

  for (int y=0; y<cols; y++) {
    for (int x=0; x<rows; x++) {
      maze[y][x]=  new Cell(x, y);
    }
  }
  current = maze[0][0];
}

//remove wall between c1 to c2
public void removeWalls(Cell c1, Cell c2) {
  int diffX = c1.x - c2.x;
  if (diffX == 1) {
    c1.walls[3] = false;
    c2.walls[1] = false;
  } else if (diffX == -1) {
    c1.walls[1] = false;
    c2.walls[3] = false;
  }

  int diffY = c1.y - c2.y;
  if (diffY == 1) {
    c1.walls[0] = false;
    c2.walls[2] = false;
  } else if (diffY == -1) {
    c1.walls[2] = false;
    c2.walls[0] = false;
  }
}



Cell next;
int lengthM = rows * cols;
void draw() {
  background(51);
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      maze[i][j].show();
    }
  }
  current.display();
  current.visited();
  next = current.checkNeighbors();
  if (next != null) {
    next.visited();
    
    stack.push(current);
    
    removeWalls(current, next);
    current = next;
  }else if(stack.size() > 0){
    current = stack.pop();
    
    
  }

  
}
