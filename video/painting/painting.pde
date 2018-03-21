
import processing.video.*;

Capture video;
int vScale =8;
Particle[] parts;

void setup() {
  size(1280, 1280);
  video = new Capture(this, 160, 120, 30);
  video.start();
  
  parts = new Particle[500];
  for (int i = 0; i< parts.length; i++)
    parts[i] = new Particle();

  fill(255);
  rect(0, 0, video.width*vScale, video.height*vScale);
}

void captureEvent(Capture video) {  
  video.read();
}

void draw() {
  //frameRate(1);
  video.loadPixels();
  colorMode(HSB);
  image(video, 0, 0);

  for (int i = 0; i< parts.length; i++) {
    parts[i].update();
    parts[i].show();
  }
}

class Particle {
  float x;
  float y;
  float r;

  float px;
  float py;
  Particle() {
    this.x = random(video.width*vScale);
    this.y = random(video.height*vScale);
    this.r = random(5, 10);
    this.px = this.x;
    this.py = this.y;
  }
  void update() {
    this.x += random(-vScale*2, vScale*2);
    this.y += random(-vScale*2, vScale*2);
    this.edges();
  }
  void edges() {
    if (this.x >= video.width*vScale) {
      this.x -= video.width*vScale;
      this.px = x;
    }
    if (this.y >= video.height*vScale) { 
      this.y -= video.height*vScale;
      this.py = y;
    }
    if (this.x <= 0) {
      this.x += video.width*vScale;
      this.px = x;
    }
    if (this.y <= 0) {
      this.y += video.height*vScale;
      this.py = y;
    }
  }
  void show() {
    strokeWeight(r);
    stroke(getColor(this.x, this.y),50);
    line(x, y, px, py);
    noStroke();
    fill(getColor(this.x, this.y),50);
    ellipse(x, y, r, r);
    py = y;
    px=x;
  }
}

int getColor(float _x, float _y) {

  int y = floor(_y/vScale);
  int x = floor(_x/vScale);
  int index = x+ y*video.width;
  return video.pixels[index];
}