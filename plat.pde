import fisica.*;
FWorld world;


int mode = 0;
final int INTRO = 0;
final int LEVELONE = 1;
final int LEVELTWO = 2;
final int GAMEOVER = 3;

color black = #000000;
color white = #FFFFFF;
color orange = #ffa800;
color green = #a8e61d;
color grey = #b4b4b4;
color blue = #00b7ef;
color red = #ed1c24;

color brown = #9c5a3c;
color maron = #990030;

Gif ani, lvl2, lvl3;

PImage map, map2, grass, sword, flower, portal, ice, brick;

boolean mouseReleased;
boolean wasPressed;

PImage[] Gif;
PImage[] Lvl2Gif;
PImage[] action;
PImage[] run;
PImage[] idle;
PImage[] jumpup;
PImage[] jumpdown;
PImage[] chargeup;
PImage[] cat;
PImage[] plantGif;
PImage[] plantaction;
PImage[] planthurt;
PImage[] lava;

boolean newlevell = true;

float zoom = 1.5;
int gridSize = 32;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, qkey, spacekey, ekey;
FPlayer player;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

boolean hasSword = true;

FBox sworddone, portaldone;

Button introButton = new Button("JUMP!", 210, 400, 200, 150, white, black);

void setup() {
  size(600, 600);
  ani = new Gif("frame_", ".gif", 32, 5, 0, 0, 700, 600);
  lvl2 = new Gif("frame_", "_delay-0.14s.gif", 8, 5, 0, 0, 700, 600);
  lvl3 = new Gif("frame_", "_delay-0.1s.gif", 13, 5, 0, 0, 700, 600);
  Fisica.init(this);
  loadImages();
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();

  loadWorld(map);
  loadPlayer();
  mode = INTRO;
}

void loadImages() {
  map = loadImage("map.png");
  brick = loadImage("brick.png");
  map2 = loadImage("map2.png");
  ice = loadImage("ice.png");
  grass = loadImage("grass.png");
  sword = loadImage("sword.png");
  flower = loadImage("flower.png");
  flower.resize(gridSize, gridSize);
  sword.resize(gridSize, gridSize);
  brick.resize(gridSize, gridSize);
  ice.resize(gridSize, gridSize);
  portal = loadImage("frame_4_delay-0.1s.png");
  portal.resize(gridSize*2, gridSize*2);

  planthurt = new PImage[1];
  planthurt[0] = loadImage("planthurt.png");

  //portal = new PImage[9];
  //portal[0] = loadImage("frame_0_delay-0.1s.png");
  //portal[1] = loadImage("frame_1_delay-0.1s.png");
  //portal[2] = loadImage("frame_2_delay-0.1s.png");
  //portal[3] = loadImage("frame_3_delay-0.1s.png");
  //portal[4] = loadImage("frame_4_delay-0.1s.png");
  //portal[5] = loadImage("frame_5_delay-0.1s.png");
  //portal[6] = loadImage("frame_6_delay-0.1s.png");
  //portal[7] = loadImage("frame_7_delay-0.1s.png");
  //portal[8] = loadImage("frame_8_delay-0.1s.png");


  // portal = loadImage("frame_3_delay-0.1s.png");


  run = new PImage[3];
  run[0] = loadImage("tile1.png");
  run[1] = loadImage("tile2.png");
  run[2] = loadImage("tile2.png");

  cat = new PImage[4];
  cat[0] = loadImage("cat1.png");
  cat[0].resize(gridSize, gridSize);
  cat[1] = loadImage("cat2.png");
  cat[1].resize(gridSize, gridSize);
  cat[2] = loadImage("cat3.png");
  cat[2].resize(gridSize, gridSize);
  cat[3] = loadImage("cat4.png");
  cat[3].resize(gridSize, gridSize);

  plantGif = new PImage[4];
  plantGif[0] = loadImage("plant_0.gif");
  plantGif[0].resize(gridSize*4, gridSize*4);
  plantGif[1] = loadImage("plant_1.gif");
  plantGif[1].resize(gridSize*4, gridSize*4);
  plantGif[2] = loadImage("plant_2.gif");
  plantGif[2].resize(gridSize*4, gridSize*4);
  plantGif[3] = loadImage("plant_3.gif");
  plantGif[3].resize(gridSize*4, gridSize*4);

  lava = new PImage[6];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");



  idle = new PImage[1];
  idle[0] = loadImage("tile0.png");

  jumpup = new PImage[1];
  jumpup[0] = loadImage("tile5.png");

  jumpdown = new PImage[1];
  jumpup[0] = loadImage("tile5.png");

  chargeup = new PImage[1];
  chargeup[0] = loadImage("tile4.png");

  plantaction = plantGif;
  action = run;
}

void draw () {
  //  println(mode, player.getY());

  click();

  if (mode == LEVELONE) {
   background(white);
    // ani.show();
    drawWorld();
    actWorld();
    if (newlevell == true) {
      mode += 1;
      loadWorld(map2);
      loadPlayer();
    }
  } else if (mode == INTRO) {
    Intro();
  }
  if (mode == LEVELTWO) {
    background(white);
  // lvl3.show();
    drawWorld();
    actWorld();
  }

  player.act();
}




void loadWorld(PImage p) {
  world = new FWorld(-10000, -10000, 10000, 10000);
  world.setGravity(0, 1000);


  for (int y = 0; y < p.height; y++) {
    for (int x = 0; x < p.width; x++) {
      color c = p.get(x, y);
      color s = p.get(x, y+1);
      color e = p.get(x+1, y);
      color w = p.get(x-1, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == black) {
        b.attachImage(grass);
        b.setFriction(10);
        b.setName("ground");
        world.add(b);
      }
      if (c == brown) {
        b.attachImage(brick);
        b.setFriction(10);
        b.setName("brick");
        world.add(b);
      }
      if (c == maron) {
        FLava lava = new FLava(x*gridSize, y*gridSize);
        
        
        terrain.add(lava);
        world.add(lava);
      }

      if (c == orange) {


        b.attachImage(sword);
        b.setSensor(true);

        b.setName("grabsword");
        world.add(b);

        sworddone = b;
      }
      if (c == green) {
        FCat ct = new FCat(x*gridSize, y*gridSize);
        enemies.add(ct);
        world.add(ct);
      }
      if (c == grey) {
        b.setName("wall");
        b.setSensor(true);
        b.setNoFill();
        b.setNoStroke();
        world.add(b);
      }
      if (c == red) {
        FPlant plt = new FPlant(x*gridSize, y*gridSize);
        enemies.add(plt);
        world.add(plt);
      }
    }
  }
}

void actWorld() {
  player.act();

  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }

  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
 // 
 player.setPosition(500, 470);

  // best set point player.setPosition(250, 4470);

  if (mode == 2) {
    //best player.setPosition(800, 2200);
  }
}

void drawWorld() {
  pushMatrix();


  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);

  world.step();
  world.draw();

  popMatrix();
}
