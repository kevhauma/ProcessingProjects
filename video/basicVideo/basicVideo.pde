
import processing.video.*;

Capture video;

color sColor = color(0);
int sX;
int sY;


void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480, 30);
  video.start();  
  video.loadPixels();
}

void captureEvent(Capture video) {  
  video.read();
}

void draw() {  
  image(video, 0, 0);
  
}