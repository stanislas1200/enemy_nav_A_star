
class Node{
  color c;
  PVector pos;
  boolean isWall;
  float g;
  float h;
  float f;
  ArrayList<Node> neighbors;
  Node previous;
  
  Node(int x, int y){
    this.c = color(255, 255, 255);
    this.pos = new PVector(x, y);
    this.isWall = false;
    this.g = 1000000.0;
    this.h = 0.0;
    this.f = 1000000.0;
    this.neighbors = new ArrayList<Node>();
  }
  
  void Show() {
    if(this.isWall == true){
      fill(0);
    } else {
      fill(this.c);
    }
    rect(this.pos.x * tileSize, this.pos.y * tileSize, tileSize, tileSize);
  }
  
  void assignNeighbors(){
    int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}}; // Define the four cardinal directions
    
    for (int[] dir : directions) {
        int i = (int) pos.x + dir[0];
        int j = (int) pos.y + dir[1];
        
        if (isLegal(i, j)) {
            Node n = nodes[i][j];
            if (!n.isWall) {
                this.neighbors.add(n);
            }
        }
    }
}

  
  void calculate(){
    this.f = this.g + Heuristic(this, end);
  }
}
