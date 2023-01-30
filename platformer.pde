import fisica.FBox;
import fisica.FBox;
//Platformer
//Colby Thompson
//Jan 9, 2023

//"For" Loop
//for (int i = 10; i >= 0; i--) {
//println(i);
//}

import fisica.*;
FWorld world;

color white = #FFFFFF;
color black = #000000; //stone
color red = #FF0000; //bridge
color blue = #0000FF; //hammerBro
color orange = #F0A000; //lava
color cyan = #0088ff; //thwomp
color green = #00FF00;//arms of tree
color brown = #795548;//tree Trunk
color gray = #9e9e9e;  //spike
color beige = #ff9900;
color pink  = #ff00f2; //water
color yellow = #FFFF00; //goomba
color skyBlue = #99c2d4;
color purple = #aa00ff; //wall
color forestGreen = #009687;
color darkGray = #4a4a4a; //end tube
color darkGreen = #006400; //trampoline
color maroon = #800000; //beginning tube

//gameModes
final int PLAY      = 0;
final int GAMEOVER  = 1;
final int WIN = 2;

//terrain images
PImage map, ice, stone, treeTrunk, treeIntersect, treeCenter, treeR, treeL, spike, bridge, trampoline, lava0, lava1, lava2, lava3, lava4, lava5, hammer, regThwomp, angryThwomp, tube;
PFont AmericanCaptain;

int gridSize = 32, lives, randomFrame, Friction = 10, lifeNum; //lifeNum = variable to set lives
int mode; //gamemode
int startingYValue = 880, startingXValue = 40; //intitial position for player
float zoom = 1.5;

//keyboard
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey, spacekey;

//Mouse & Keyboard interaction variables
boolean mouseReleased;
boolean wasPressed;

//terrain list
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

//lava array
PImage[] lava;
PImage[] water;

//enemy arrays
PImage[] goomba;
PImage[] hammerBro;

//images for main character animation
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;

//creating objects from classes
FPlayer player;
Gif endAnimation;
Button playAgain;

void setup() {

  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  size(600, 600);
  Fisica.init(this);
  mode = PLAY;
  lifeNum = 3; //num of lives
  lives = lifeNum; //starting amount of lives

  playAgain = new Button ("Play Again", width/2, height/2, 150, 75, white, skyBlue);

  //instantiate FGameObject lists
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();


  //call forward load functions
  loadImages();
  loadWorld(map);
  loadPlayer();


  //load lava
  lava = new PImage[5];

  lava[0] = loadImage("terrain/lava1.png");
  lava[1] = loadImage("terrain/lava2.png");
  lava[2] = loadImage("terrain/lava3.png");
  lava[3] = loadImage("terrain/lava4.png");
  lava[4] = loadImage("terrain/lava5.png");

  //goomba
  goomba = new PImage[2];

  goomba[0] = loadImage("terrain/goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("terrain/goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  //hammerBro
  hammerBro = new PImage[2];

  hammerBro[0] = loadImage("terrain/hammerbro0.png");
  hammerBro[0].resize(gridSize, gridSize);
  hammerBro[1] = loadImage("terrain/hammerbro1.png");
  hammerBro[1].resize(gridSize, gridSize);

  water = new PImage[4];

  water[0] = loadImage("terrain/water1.png");
  water[1] = loadImage("terrain/water2.png");
  water[2] = loadImage("terrain/water3.png");
  water[3] = loadImage("terrain/water4.png");

  //Load Images & Gifs
  endAnimation = new Gif("frame_", "_delay-0.03s.gif", 75, 4, 0, 100, width, height*3/5);

  AmericanCaptain = createFont("AmericanCaptain.otf", 200); //Custom font
  textFont(AmericanCaptain);
}

void draw() {
  click();
  //sets gamemodes
  if (mode == PLAY) {
    play();
  } else if (mode == GAMEOVER) {
    gameOver();
  } else if (mode == WIN) {
    win();
  }
}

//load pictures
void loadImages() {

  //terrain images
  map = loadImage("w.png");
  ice = loadImage("terrain/blueBlock.png");
  stone = loadImage("terrain/brick.png");
  treeTrunk = loadImage("terrain/tree_trunk.png");
  treeIntersect = loadImage("terrain/tree_intersect.png");
  treeCenter = loadImage("terrain/treetop_center.png");
  treeR = loadImage("terrain/treetop_e.png");
  treeL = loadImage("terrain/treetop_w.png");
  spike = loadImage("terrain/spike.png");
  bridge = loadImage("terrain/bridge_center.png");
  trampoline = loadImage("terrain/trampoline.png");
  hammer = loadImage("terrain/hammer.png");
  regThwomp = loadImage("terrain/thwomp0.png");
  angryThwomp = loadImage("terrain/thwomp1.png");
  tube = loadImage("tube.png");
  tube.resize(gridSize, gridSize);


  //load actions for main player
  idle  = new PImage[2];
  idle[0] = loadImage("character/idle0.png");
  idle[1] = loadImage("character/idle1.png");

  jump  = new PImage[1];
  jump[0] = loadImage("character/jump0.png");

  run = new PImage[3];
  run[0] = loadImage("character/runright0.png");
  run[1] = loadImage("character/runright1.png");
  run[2] = loadImage("character/runright2.png");

  action = idle; 
}
//load player class
void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}
