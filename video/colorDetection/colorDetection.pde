
import processing.video.*;

Capture video;

color sColor = color(0);
int sX;
int sY;


void setup() {
  size(640, 480);
  background(0); 
  video = new Capture(this, 640, 480, 30);
  video.start();  
  video.loadPixels();
}

void captureEvent(Capture video) {  
  video.read();
}

void mousePressed(){
  int index = video.width*mouseY + mouseX;  
  sColor = video.pixels[index];
  println(red(sColor) + "," +green(sColor) + "," +blue(sColor) );
}
void draw() {  
  image(video, 0, 0);
  float rec = 255*3;
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int index = video.width*y + x;
      color pix = video.pixels[index];
      float d= difference(sColor, pix);
      if (d < rec) {
        rec = d;
        sX = x;
        sY = y;
      }
    }
  }
  if (blue(sColor) != 0 &&green(sColor) != 0&&red(sColor) != 0) {
    fill(sColor);
    stroke(255);
    ellipse(sX, sY, 10, 10);
  }
}

float difference(color c1, color c2) {
  return (abs(green(c1)-green(c2))+abs(blue(c1)-blue(c2))+abs(red(c1)-red(c2)));
}