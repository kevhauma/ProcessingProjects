import processing.video.*;
Capture video;
color[] rowsCopy;
int middle; 
PImage slitScan;

int columns = 0;

void setup() {
  size(1500, 480);
  background(0); 
  video = new Capture(this, 640, 480, 30);
  video.start();
  middle = video.width/2;
  rowsCopy = new color[height];
  slitScan = createImage(width, height, RGB);
}

void captureEvent(Capture video) {  
  video.read();
}


void draw() {
  image(slitScan, 0, 0);
  rowsCopy = new color[height];

  video.loadPixels();
  for (int rows = 0; rows < height-1; rows++) {
    int index = video.width * rows + middle;
    rowsCopy[rows] = video.pixels[index];
  }
  slitScan.loadPixels();
  for (int rows = 0; rows < height; rows++) {
    int index = slitScan.width * rows + columns;
    slitScan.pixels[index] =rowsCopy[rows];
  }
  columns++;
  if (columns >= width) columns =0;
  slitScan.updatePixels();
}