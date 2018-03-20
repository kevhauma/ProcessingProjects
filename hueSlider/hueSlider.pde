PImage img;
float h =0;
void setup() {
  size(1800, 1800);
  img = createImage(width, height, RGB);
  
}

void draw() {  
  colorMode(HSB);
  image(img, 0, 0);
  println(frameRate);
  
}
void mousePressed(){
  h = map(mouseY,0,width,0,255);
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int index  = y * img.width + x;
     float s  = map(y,0,width,255,0);  
  float b  = map(x,0,width,0,255);
      img.pixels[index] = color(h,s,b);
      
      
    }
  }
  img.updatePixels();
}