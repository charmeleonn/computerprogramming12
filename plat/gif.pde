class Gif {

  String before;
  String after;
  int numFrames;
  int speed;
  int x;
  int y;
  float w;
  float h;
  PImage[] gif;
  int f;



  Gif(String _before, String _after, int _numFrames, int _speed, int _x, int _y) {
    before = _before;
    after = _after;
    numFrames = _numFrames;
    speed = _speed;
    x = _x;
    y = _y;
    gif = new PImage[_numFrames];
    load();
    f = 0;
  }

  Gif(String _before, String _after, int _numFrames, int _speed, int _x, int _y, float _w, float _h) {
    before = _before;
    after = _after;
    numFrames = _numFrames;
    speed = _speed;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    gif = new PImage[_numFrames];
    load();
    f = 0;
  }


  void load() {
    for (int i = 0; i < numFrames; i++) {
      gif[i] = loadImage(before + i + after);
    }
  }

  void show() {



    if (w == 0.0) {

      image(gif[f], x, y);
      if (frameCount % speed == 0) f++;


      if (f == numFrames) {
        f = 0;
      }
    } else {



      image(gif[f], x, y, w, h);
      if (frameCount % speed == 0) f++;
      if (f == numFrames) {
        f = 0;
      }
    }
  }
}
