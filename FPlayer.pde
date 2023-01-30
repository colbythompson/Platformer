class FPlayer extends FGameObject {

  int frame;
  int direction;


  FPlayer() {
    super();
    frame = 0;
    setPosition(startingXValue, startingYValue);
    direction = R;
    setName("player");
    setRotatable(false);
    setFillColor(blue);
  }

  void act() {
    handleInput();
    collisions();
  }

  void handleInput() {
    //using WASD
    float vy = getVelocityY();
    float vx = getVelocityX();

    if (abs(vy) > 0.1) action = jump;
    if (vy == 0) {
      action = idle;
    }
    if (akey) {
      setVelocity(-350, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(350, vy);
      action = run;
      direction = R;
    }
    if (isTouching("stone") || isTouching("bridge") || isTouching("tree") || isTouching("trampoline")) {
      if (wkey) setVelocity(vx, -350);
    }
  }

  void collisions() {
    if (isTouching("spike") || isTouching("lava") || isTouching("hammer")) {
      playerDies();
    }
    if (getY() > 1500) { //out of bounds
      playerDies();
    }
    if (isTouching("endTube") && skey) {
      mode = WIN;
    }
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void show() {
    fill(black);
    textSize(20);
    text(lives, 40, 40);
  }
}
