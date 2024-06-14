class FPlant extends FGameObject {

  FGameObject flowerdone;

  int explosion = 0;

  int direction = L;
  int speed = 100;
  int frame = 0;
  int health;
  boolean portaltrue = false;

  int pframe;

  int counter = 0;
  int threshold = 100;

  FPlant(float x, float y) {
    super();
    setPosition(x+50, y);
    setName("plant");
    setRotatable(false);
    setStatic(true);
    health = 3;

    portaltrue = false;
  }

  void act() {
    animate();
    collide();
    flowerattack();
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

  void flowerattack() {
    if (mode == 1) {

      if (counter >= threshold) {
        FGameObject b = new FGameObject(gridSize, gridSize);
        b.setPosition(this.getX(), this.getY());
        b.setVelocity(random(80, 300), -600);
        b.setAngularVelocity(20);
        b.setSensor(true);
        b.setStatic(false);
        b.setName("flower");
        b.attachImage(flower);
        world.add(b);
        //  println("created");

        flowerdone = b;
        counter = 0;
      }

      if (flowerdone != null && flowerdone.isTouching("ground")) {
        world.remove(flowerdone);
        flowerdone = null; // Reset flowerdone to avoid further null checks
      }

      counter++;
    }
  }


  void animate() {
    if (frame >= plantaction.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(plantaction[frame]);
      if (direction == L) attachImage(reverseImage(plantaction[frame]));
      frame++;
    }
  }


  void collide() {




    if (!isTouching("sword")) {
      plantaction = plantGif;
    }

    // println(health);
    if (isTouching("player")) {
      player.setVelocity(-400, -400);
    }

    if (isTouching("sword")) {
      plantaction = planthurt;
      health -= 1;
      if (health == 0) {
        world.remove(this);
        enemies.remove(this);
      }
    }
  }
}
