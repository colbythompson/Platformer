void play() {
  background(skyBlue);
  drawWorld();
  player.show();
  actWorld();
  if (lives == 0) {
    mode = GAMEOVER;
  }
}

//load act functions
void actWorld() {
  player.act();
  player.animate();

  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }

  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom + width/2, -player.getY()*zoom + height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
void loadWorld(PImage img) {

  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  //process pixels for y
  for (int y = 0; y < img.height; y++) {
    //process pixels for x
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y); //color of current pixel
      color d = img.get(x, y+1); //color below current pixel
      color w = img.get(x + 1, y); //color west current pixel
      color e = img.get(x - 1, y); //color east current pixel
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == black) { //stone block
        b.attachImage(stone);
        b.setFriction(Friction);
        b.setName("stone");
        world.add(b);
      } else if (c == purple) { //wall for enemies
        b.attachImage(stone);
        b.setName("wall");
        world.add(b);
      } else if (c == gray) { //spike
        b.attachImage(spike);
        b.setFriction(Friction);
        b.setName("spike");
        world.add(b);
      } else if (c == darkGreen) {//trampoline
        b.attachImage(trampoline);
        b.setFriction(Friction);
        b.setRestitution(1.4);
        b.setName("trampoline");
        world.add(b);
        //} else if (c == cyan) { //ice block
        //  b.attachImage(ice);
        //  b.setFriction(0);
        //  b.setName("ice");
        //  world.add(b);
      } else if (c == brown) { //tree trunk
        b.attachImage(treeTrunk);
        b.setSensor(true);//allows player to pass through
        b.setName("tree");
        world.add(b);
      } else if (c == green && w == green && e != green) { //west end
        b.attachImage(treeL);
        b.setFriction(Friction);
        b.setName("tree");
        world.add(b);
      } else if (c == green && e == green && w != green) { //east end
        b.attachImage(treeR);
        b.setFriction(Friction);
        b.setName("tree");
        world.add(b);
      } else if (c == green && d == brown) { //intersection piece
        b.attachImage(treeIntersect);
        b.setFriction(Friction);
        b.setName("tree");
        world.add(b);
      } else if (c == green && w == green && e == green && d != brown) { //connecting pieces
        b.attachImage(treeCenter);
        b.setFriction(Friction);
        b.setName("tree");
        world.add(b);
      } else if (c == red) { //bridge
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == orange) {
        FLava myLava = new FLava(x*gridSize, y*gridSize, 5, 1); //lava
        terrain.add(myLava);
        world.add(myLava);
      } else if (c == yellow) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize); //goomba
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == blue) {
        FHammerBro hb = new FHammerBro(x*gridSize, y*gridSize); //hammer bro
        enemies.add(hb);
        world.add(hb);
      } else if (c == cyan) {
        FThwomp tw = new FThwomp(x*gridSize, y*gridSize); //Thwomp
        terrain.add(tw);
        world.add(tw);
      } else if (c == pink) {
        FWater myWater = new FWater(x*gridSize, y*gridSize, 4, 1); //water
        terrain.add(myWater);
        world.add(myWater);
      } else if (c == maroon) {
        b.attachImage(tube);
        b.setFriction(Friction);
        b.setName("endTube");
        world.add(b);
      } else if (c == darkGray) {
        b.attachImage(tube);
        b.setFriction(Friction);
        b.setName("beginningTube");
        world.add(b);
      }
    }
  }
}

void reset() {
  world.clear();
  setup();
}
