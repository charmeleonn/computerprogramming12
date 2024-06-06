class FCat extends FGameObject {


  int direction = L;
  int speed = 50;
  int frame = 0;

  FCat(float x, float y) {
    super();
    setPosition(x, y);
    setName("cat");
    setRotatable(false);
  }

  void act() {
    animate();
    collide();
    move();
  }

  void animate() {
    if (frame >= cat.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(cat[frame]);
      if (direction == L) attachImage(reverseImage(cat[frame]));
      frame++;
    }
  }

  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX() + direction +10*direction, getY());
    }
    if (isTouching("sword")) {
        world.remove(this);
        enemies.remove(this);
    }
    
    if (isTouching("player")) {
      player.setVelocity(300*direction, -300);
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
