
import processing.video.*;

Capture video;
PImage img;

float[][] huemap;


void setup() {
  size(1280, 480);
  video = new Capture(this, 640, 480, 30);
  video.start(); 
  huemap = new float[video.width][video.height];
  img = createImage(video.width, video.height, HSB);
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      float d = dist(img.width/2,img.height/2,x,y);
        float h = map(d,0,img.width/2+img.height/2,0,255);
        huemap[x][y] = h;
    }
  }
}

int index(int x, int y) {
  return x + y * video.width;
}
void captureEvent(Capture video) {  
  video.read();
}

void draw() {
  video.loadPixels();
  img.loadPixels();
  colorMode(HSB);
  for (int y = 0; y < video.height-1; y++) {
    for (int x = 1; x < video.width-1; x++) {
      int index = index(x, y);
      color pix = video.pixels[index];
      img.pixels[index] = color(huemap[x][y],255,brightness(pix)); 
    }
  }
  img.updatePixels();
  image(video, 0, 0);
  image(img, 640, 0);
}