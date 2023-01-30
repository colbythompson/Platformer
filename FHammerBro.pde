class FHammerBro extends FGoomba {

  FHammerBro(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("FHammerBro");
    setRotatable(false);
  }

  void act() {
    animate();
    changeDirection();
    move();
    throwHammer();
    killEnemy();
  }

  void animate() {
    if (frame >= hammerBro.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(hammerBro[frame]);
      if (direction == L) attachImage(reverseImage(hammerBro[frame]));
      frame++;
    }
  }
  void changeDirection() {
    if (frameCount % 200 == 0) {
      direction *= -1; //since left = -1 and right = 1, multiplying by -1 will change from negative to positive & vice versa
      setPosition(getX()+direction, getY()); //removes goomba from wall to allow movement
    }
  }


  void throwHammer() {
    if (frameCount % 100 == 0) {
      FBox loadHammer = new FBox(gridSize, gridSize);
      loadHammer.setName("hammer");
      loadHammer.attachImage(hammer);
      loadHammer.setPosition(getX(), getY());
      if (direction == R) loadHammer.setVelocity(100, -400);
      if (direction == L) loadHammer.setVelocity(-100, -400);
      loadHammer.setAngularVelocity(75);
      loadHammer.setSensor(true);
      world.add(loadHammer);
    }
  }
}
