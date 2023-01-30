class FGameObject extends FBox {

  final int L = -1;
  final int R = 1;
  float x, y, w, h;

  FGameObject() {
    super(gridSize, gridSize);
  }

  FGameObject(int w, int h) {
    super(w, h);
  }

  void act() {
  }

  boolean isTouching(String n) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(n)) {
        return true;
      }
    }
    return false;
  }

  void playerDies() {
    lives--;
    player.setPosition(startingXValue, startingYValue);
    player.setVelocity(0, 0);
  }
}
