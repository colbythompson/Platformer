class FLava extends FGameObject {


  PImage[] img;
  int i, f, t; //i = counter variable,  f = page num of array, t = counter for speed
  int numFrames;
  int speed;
  int currentFrame;


  FLava(float x, float y, int num, int s) {
    super();
    setPosition(x, y);
    setName("lava");
    setStatic(true);
    numFrames = num;
    f = (int) random(0, 4);
    speed = s;
  }

  void act() {
    attachImage(lava[f]);
    if (t < 15/speed) {
      t++;
    } else {
      t = 0;
      f++;
    }
    if (f == numFrames) f = 0;
  }
}
