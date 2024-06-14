class FRobot extends FGameObject {

  FGameObject robotdone;

  int explosion = 0;

  int direction = L;
  int speed = 100;
  int frame = 0;
  int health;
  boolean portaltrue = false;

  int pframe;

  int counter = 0;
  int threshold = 100;

  FRobot(float x, float y) {
    super();
    setPosition(x+50, y);
    setName("robot");
    setRotatable(false);
    setStatic(true);
    health = 3;

    portaltrue = false;
  }

  void act() {
    animate();
    collide();
    die();
  }


  void die() {
    if (health <= 0) {
      world.remove(this);
      FBox p = new FBox(gridSize, gridSize);
      p.setPosition(this.getX(), this.getY()-20);
      p.setStatic(true);
      p.setName("grabportal");
      p.setSensor(true);
      p.attachImage(portal);

      while (explosion < 10) {
        FGameObject e = new FGameObject(gridSize, gridSize);
        e.setPosition(this.getX(), this.getY());
        e.setVelocity(random(-100, 100), -400);
        e.setAngularVelocity(random(-20, 20));
        e.setSensor(true);
        e.setStatic(false);
        e.attachImage(flower);
        world.add(e);
        explosion += 1;
      }

      world.add(p);
      // println("created");
    }
  }



  void animate() {
    if (frame >= robotaction.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(plantaction[frame]);
      if (direction == L) attachImage(reverseImage(plantaction[frame]));
      frame++;
    }
  }


  void collide() {




    if (!isTouching("sword")) {
      robotaction = robotGif;
    }

    // println(health);
    if (isTouching("player")) {
      player.setVelocity(-400*random(-1,1);, -400);
    }

    if (isTouching("sword")) {
      robotaction = robothurt;
      health -= 1;
      if (health == 0) {
        world.remove(this);
        enemies.remove(this);
      }
    }
  }
}
