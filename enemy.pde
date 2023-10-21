enum EnemyState {
  IDLE, MOVING, ATTACKING;
}

class Enemy {
  float x, y;
  float speed;
  PVector target; // Position of the target
  EnemyState state;
  ArrayList<Node> path; // store path

  Enemy(float x, float y, float speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.state = EnemyState.IDLE;
    this.target = new PVector(0, 0); // Initialize target position
    this.path = null;
  }

  void move() {
    if (state == EnemyState.MOVING) {
      println("move");
      PVector direction = PVector.sub(target, new PVector(x, y));
      direction.normalize();
      direction.mult(speed);
      x += direction.x;
      y += direction.y;

      // Check if enemy has reached the target
      if (PVector.dist(target, new PVector(x, y)) < speed) {
        if (!path.isEmpty())
          setIdle();
        else
          followPath();
      }
    }
  }

  void setPath(ArrayList<Node> path) {
    this.path = path;
    this.path.remove(path.size()-1);
    setMoving(path.get(path.size()-1).pos.x * tileSize + tileSize / 4, path.get(path.size()-1).pos.y * tileSize + tileSize / 4);
  }
    

  void followPath() {
    if (state == EnemyState.MOVING && path != null && !path.isEmpty()) {
      Node targetNode = path.get(path.size()-1);
      setMoving(targetNode.pos.x * tileSize + tileSize / 4, targetNode.pos.y * tileSize + tileSize / 4);

      // Check if enemy has reached the target
      if (dist(targetNode.pos.x * tileSize + tileSize / 4, targetNode.pos.y * tileSize + tileSize / 4, x, y) < tileSize) {
          println("remove");
        path.remove(path.size()-1);
        if (path.isEmpty()) setIdle();
      }
    }
    else
      println("no");
  }

  void attack() {
    if (state != EnemyState.ATTACKING) {
      state = EnemyState.ATTACKING;
      // Add attack behavior
    }
  }

  void setIdle() {
    state = EnemyState.IDLE;
  }

  void setMoving(float targetX, float targetY) {
    state = EnemyState.MOVING;
    target.set(targetX, targetY);
  }

  void display() {
    fill(255, 0, 0);
    noStroke();
    rect(x, y, 20, 20); 
  }
}
