class FThwomp extends FGameObject {

  FThwomp(float x, float y) {
    super(2*gridSize, 2*gridSize);
    setPosition(x+gridSize/2, y+gridSize/2);
    setName("Thwomp");
    setRotatable(false);
    setStatic(true);
    attachImage(regThwomp);
  }
  void act() {
    animate();
    collide();
  }
  void animate() {
  }


  void collide() {
    if (player.getX() < getX() + gridSize && player.getX() > getX() - gridSize && player.getY() > getY()) {
      setStatic(false);
      attachImage(angryThwomp);
    }
    if (isTouching("player")) {
      playerDies();
    }
  }
}
