
import processing.video.*;

Capture video;
float treshold = 35;
PImage prevFr;
PImage movementFr;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480, 30);
  prevFr = createImage(video.width, video.height, RGB);

  video.start();  
  video.loadPixels();
  prevFr.loadPixels();
}

void captureEvent(Capture video) {

  prevFr.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  prevFr.updatePixels();
  video.read();
}

void draw() {  
  movementFr = createImage(video.width, video.height, RGB);
  for (int i = 0; i < movementFr.pixels.length; i++) {
    movementFr.pixels[i] = color(0);
  }
  movementFr.loadPixels(); 
  stroke(255);
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int index = video.width*y + x;
      color cur = video.pixels[index];
      color prev = prevFr.pixels[index];
      float d= difference(prev, cur);
      if (d < treshold) {
        movementFr.pixels[index] = color(255);
      }
    }
  }
  movementFr.updatePixels();
  image(movementFr, 0, 0);
}

float difference(color c1, color c2) {
  return (abs(green(c1)-green(c2))+abs(blue(c1)-blue(c2))+abs(red(c1)-red(c2)));
}