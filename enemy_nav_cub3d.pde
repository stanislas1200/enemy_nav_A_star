int cols = 30;
int rows = 20;
int[][] grid = new int[cols][rows];
int tileSize = 0;
Enemy enemy;

void setup() {
  size(1080, 720);
  tileSize = height/20;

  // Initialize the grid with zeros
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = 0;
    }
  }
}

void draw() {
  background(255);
  
  // Draw grid
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int x = i * tileSize;
      int y = j * tileSize;
      switch (grid[i][j]) {
        case 0 :
          fill(150);
          break;
        case 1 :
          fill(0, 0, 255);
          break;
        case -1:
          fill(255,255,255);
          break;
      }
      stroke(0);
      rect(x, y, tileSize, tileSize);
    }
  }
  
  if (enemy != null)
  {
    if (enemy.state == EnemyState.MOVING)
    {
      enemy.followPath();
      enemy.move();
    }
    enemy.display();
  }
}


void mousePressed() {
  // Convert mouse coordinates to grid coordinates
  int i = mouseX / tileSize;
  int j = mouseY / tileSize;
  
  // Toggle the value of the clicked tile
  if (i >= 0 && i < cols && j >= 0 && j < rows) {
    if (mouseButton == LEFT)
      grid[i][j] = 1;
    else
      enemy = new Enemy(i * tileSize + tileSize/4, j * tileSize + tileSize/4, 5); // Create an enemy object
  }
}

void keyPressed() {
  int i = mouseX / tileSize;
  int j = mouseY / tileSize;
  if (key == 'f' || key == 'F') {
     if (i >= 0 && i < cols && j >= 0 && j < rows) {
      grid[i][j] = 1;
     }
  }
  else if (key == 'm') {
    println("start A star");
    Astar((int)enemy.x / tileSize, (int)enemy.y / tileSize, i, j);
    enemy.setPath(path);
  }
}
