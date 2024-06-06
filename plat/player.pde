class FPlayer extends FGameObject {

  int charge = 0;
  int clock = 0;
  boolean knifeReady = false;
  int frame;
  int maxCharge = 60;
  int direction;
  final int L = -1;
  final int R = 1;
  int px;
  
  boolean charging = false;

  boolean isJumping = false;
  float lastY = 0;

  FGameObject leftSensor, rightSensor;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    
    
    
    
    //setPosition(350, 800);
    //setPosition(200, 2300);
    //setPosition(250, 2200);
    setName("player");
    setRotatable(false);
    setFillColor(white);
    addSensors();
  }



  void act() {
    float vy = getVelocityY();
    float vx = getVelocityX();

    
if (mode == 1) {
  if (getY() >= 5500) {
      setPosition(100, 4400);
    }
} else if (mode == 2) {
  if (getY() >= 3000) {
      setPosition(200, 2300);
    }
}

    sensors();
    collisions();

    if (lastY == getY() && vy == 0) {
      isJumping = false;
    }
    lastY = getY();

    attack();

    handleInput();

    animate();
  }

  void collisions() {
    if (isTouching("grabsword")) {
      if (spacekey) {
        hasSword = true;
        world.remove(sworddone);
      }
    }
    if (isTouching("flower")) {
       setVelocity(300*direction,-500);
    }
    
  }
  

  void addSensors() {
    leftSensor = new FGameObject(10, 20);
    leftSensor.setSensor(true);
    rightSensor = new FGameObject(10, 20);
    rightSensor.setSensor(true);

    world.add(leftSensor);
    world.add(rightSensor);
    leftSensor.setNoFill();
    leftSensor.setNoStroke();
    leftSensor.setName("left");
    rightSensor.setName("right");
    rightSensor.setNoFill();
    rightSensor.setNoStroke();
  }

  void sensors() {
    float vy = getVelocityY();
    float vx = getVelocityX();
    leftSensor.setPosition(getX()-gridSize/2, getY());
    rightSensor.setPosition(getX()+gridSize/2, getY());
    leftSensor.setVelocity(getVelocityX(), getVelocityY());
    rightSensor.setVelocity(getVelocityX(), getVelocityY());

    if (leftSensor.isTouching("ground")) {
      setVelocity(400, vy);
    }
    if (rightSensor.isTouching("ground")) {
      setVelocity(-400, vy);
    }
  }

  void attack() {

    println(clock);

    if (clock >= 200) {
      knifeReady = true;
    } else {
      knifeReady = false;
    }
    if (hasSword == true) {
      if (spacekey && knifeReady) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(getX(), getY());
        b.setVelocity(0, 200);
        b.setSensor(true);
        b.setStatic(false);
        b.setName("sword");
        b.attachImage(sword);
        world.add(b);
        println("created");
        clock = 0;
      } else {
        clock += 1;
      }
    }
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void handleInput() {
    float vy = getVelocityY();
    float vx = getVelocityX();

    if (abs(vy) < 0.1) {
      action = idle;
      if (akey && !charging) {
        setVelocity(-200, vy);
        action = run;
        direction = L;
      }
      if (dkey && !charging ) {
        setVelocity(200, vy);
        action = run;
        direction = R;
      }
    } else {
      action = jumpup;
    }



    if (direction == L) {
      px = charge*-6;
    } else if (direction == R) {
      px = charge*6;
    }

    if (wkey && !isJumping) {
      action = chargeup;
      charging = true;
    }

    if (wkey && !isJumping && charge < maxCharge) {
      charge++;
    }
    if (!wkey && charge > 0 && !isJumping) {
      setVelocity(px, charge*-15);
      charge = 0;
      isJumping = true;
      charging = false;
    }
  }
}
