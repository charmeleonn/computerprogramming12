class FPlant extends FGameObject {

  FGameObject flowerdone;

  int direction = L;
  int speed = 100;
  int frame = 0;
  int health;

  int counter = 0;
  int threshold = 100;

  FPlant(float x, float y) {
    super();
    setPosition(x+50, y);
    setName("plant");
    setRotatable(false);
    setStatic(true);
    health = 3;
  }

  void act() {
    animate();
    collide();
    flowerattack();
  }


  void die() {
    if (health >= 0) {
      world.remove(this);
      FBox p = new FBox(gridSize, gridSize);
      p.setPosition(this.getX(), this.getY());

      p.setStatic(true);
      p.setName("portal");
      p.attachImage(portal);
      world.add(p);
      println("created");
    }
  }

  void flowerattack() {
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
      println("created");

      flowerdone = b;
      counter = 0;
    }

    if (flowerdone != null && flowerdone.isTouching("ground")) {
      world.remove(flowerdone);
      flowerdone = null; // Reset flowerdone to avoid further null checks
    }

    counter++;
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

    println(health);
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
