


float p = 0.45; // wall probability
int w = 30;
int h = 20;
Node[][] nodes;
Node start;
Node end;
Node current;
Node temp;
Node n;
ArrayList<Node> closed; // already evaluated
ArrayList<Node> open;
ArrayList<Node> path;

void Astar(int start_i, int start_j, int end_i, int end_j) {
  nodes = new Node[w][h];
  
  for(int i = 0; i < w; i++){
    for(int j = 0; j < h; j++){
      nodes[i][j] = new Node(i, j);
      if (grid[i][j] == 1)
        nodes[i][j].isWall = true;
    }
  }
  
  closed = new ArrayList<Node>(); 
  open = new ArrayList<Node>();
  path = new ArrayList<Node>();
  println(start_i, start_j);
  start = nodes[start_i][start_j];
  start.g = 0;
  end = nodes[end_i][end_j];
  open.add(start);
  start.isWall = false;
  start.c = color(0, 255, 0);
  end.isWall = false;
  end.c = color(255, 0, 0);
  
  for(int i = 0; i < w; i++){
    for(int j = 0; j < h; j++){
      nodes[i][j].assignNeighbors();
      nodes[i][j].calculate();
    }
  }
  find_path();
}

void find_path() {
  while(!open.isEmpty()) {
  if(open.size() > 0){
    int winner = 0;
    for(int i = 0; i < open.size(); i++){
      if(open.get(i).f < open.get(winner).f){
        winner = i;
      }
    }
    current = open.get(winner);
    
    if(current == end){
      print("~~~ end! ~~~");
      //noLoop();
      //ShowPath(current);
      makePath(current);
      return;
    }
    
    open.remove(winner);
    closed.add(current);
    
    for(int i = 0; i < current.neighbors.size(); i++){
      n = current.neighbors.get(i);
      if(Contains(closed, n) == true){
        continue;
      }
      if(Contains(open, n) == false){
        open.add(n);
      }
      float tgs = current.g + dist(current.pos.x, current.pos.y, n.pos.x, n.pos.y);
      if(tgs < n.g){
        n.g = tgs;
      }
      n.previous = current;
      n.g = tgs;
      n.calculate();
    }
  } else {
    print("no solution!");
    noLoop();
    return;
  }
  
  for(int i = 0; i < closed.size(); i++){
    closed.get(i).c = color(150);
  }
  for(int i = 0; i < open.size(); i++){
    open.get(i).c = color(200);
  }
    
  /*for(int i = 0; i < w; i++){
    for(int j = 0; j < h; j++){
      nodes[i][j].Show();
    }
  }
  
  ShowPath(current);
  */
}
}

void makePath(Node n) {
  Clear(path);
  temp = n;
  while(temp.previous != null){
    grid[(int)temp.pos.x][(int)temp.pos.y] = -1;
    path.add(temp.previous);
    temp = temp.previous;
  }
}
/*
void ShowPath(Node n){
  Clear(path);
  temp = n;
  path.add(temp);
  while(temp.previous != null){
    stroke(255, 0, 0);
    line(temp.pos.x * tileSize + tileSize/2, temp.pos.y * tileSize + tileSize/2, temp.previous.pos.x * tileSize + tileSize/2, temp.previous.pos.y * tileSize + tileSize/2);
    path.add(temp.previous);
    temp = temp.previous;
  }
  println(" size: " + path.size() + " n.x " + n.pos.x + " n.y " + n.pos.y);
  stroke(0);
}*/

boolean isLegal(int x, int y){
  if(x >= 0 && y >= 0 && x < w && y < h){
    return true;
  } else {
    return false;
  }
}

boolean Contains(ArrayList<Node> A, Node e){
  boolean contains = false;
  for(int i = 0; i < A.size(); i++){
    if(A.get(i) == e){
      contains = true;
    }
  }
  return contains;
}

void Clear(ArrayList<Node> A){
  for(int i = A.size() - 1; i >= 0; i--){
    grid[(int)A.get(i).pos.x][(int)A.get(i).pos.y] = 0;
    A.remove(i);
  }
}

float Heuristic(Node a, Node b){
  return abs(a.pos.x - b.pos.x) + abs(a.pos.y - b.pos.y);
}
