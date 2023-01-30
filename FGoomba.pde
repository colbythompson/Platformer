class FGoomba extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    setName("goombaClass");
    setRotatable(false);
  }
  void act() {
    animate();
    collide();
    move();
  }
  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(goomba[frame]);
      if (direction == L) attachImage(reverseImage(goomba[frame]));
      frame++;
    }
  }

  void collide() { //tracks collisions
    if (isTouching("wall")) {
      direction *= -1; //since left = -1 and right = 1, multiplying by -1 will change from negative to positive & vice versa
      setPosition(getX()+direction, getY()); //removes goomba from wall to allow movement
    }
    killEnemy();
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
  void killEnemy() {
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/2) {
        world.remove(this); //refers to whatever object (goomba) is calling collide function
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        playerDies();
      }
    }
  }
}
