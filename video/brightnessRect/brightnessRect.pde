
import processing.video.*;

Capture video;


float vScale=8;
boolean rectT = false;

void setup() {
  size(1280, 960);
  printArray(Capture.list());
  video = new Capture(this, 160, 120, 30);
  video.start();
}

int index(int x, int y) {
  return x + y * video.width;
}
void captureEvent(Capture video) {  
  video.read();
}
void mousePressed() {
  rectT = !rectT;
}
void draw() {
  video.loadPixels();
  background(0);
  colorMode(HSB);
  for (int y = 0; y < video.height-1; y++) {
    for (int x = 1; x < video.width-1; x++) {
      int index = index(x, y);
      color pix = video.pixels[index];      
      float w = map(brightness(pix), 0, 255, 0, vScale);
      fill(hue(pix), saturation(pix), 255);
      rectMode(CENTER);
      ellipseMode(CENTER);
      noStroke();
      
      if (!rectT)
      ellipse(x*vScale + vScale/2, y*vScale + vScale/2, w, w);
      else
      rect(x*vScale + vScale/2, y*vScale + vScale/2, w, w);
    }
  }
  image(video, 0, 0,160,120);
}