class Button {

  //instance variables
  int x, y, w, h;
  boolean clicked;
  color highlight, normal;
  String text;
  PImage image;




  //image constructor
  Button(PImage img, int _x, int _y, int _w, int _h, color norm, color high) {
    x = _x;
    y = _y;
    image = img;
    w = _w;
    h = _h;
    highlight = high;
    normal = norm;
    clicked = false;
  }
  //constructor
  Button(String t, int _x, int _y, int _w, int _h, color norm, color high) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    text = t;
    highlight = high;
    normal = norm;
    clicked = false;
  }









  //behavior functions

  boolean touchingMouse() {
    if (mouseX > x-w/2+100 && mouseX < x+w/2+100 && mouseY > y-h/2+55 && mouseY < y+h/2+90) {
      return true;
    } else {
      return false;
    }
  }


  void show() {
    drawRect();
    drawLabel();
    checkForClick();
  }

  void drawRect() {
    if (touchingMouse()) {
      fill(highlight);
    } else {
      fill(normal);
    }
    stroke(0);
    strokeWeight(4);
    rect(x, y, w, h);
  }

  void drawLabel() {
    //text label
    if (touchingMouse()) {
      fill(normal);
    } else {
      fill(highlight);
    }



    if (image == null) {
      textSize(w/4);
      text(text, x+35, y+90);
    } else {
      image(image, x, y, w, h);
    }
  }

  void checkForClick() {
    if (mouseReleased && touchingMouse()) {
      clicked = true;
    } else {
      clicked = false;
    }

    //after click
    if (clicked) {
      background(normal);
    }
  }
}
