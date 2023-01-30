class FWater extends FLava {
  FWater(float x, float y, int num, int s) {
    super(x, y, num, s);
    setPosition(x, y);
    setName("water");
    f = (int) random(0, 3);
    setStatic(true);
    setSensor(true);
    numFrames = num;
    speed = s;
  }
  void act() {
    attachImage(water[f]);
    if (t < 15/speed) {
      t++;
    } else {
      t = 0;
      f++;
    }
    if (f == numFrames) f = 0;
  }
}
