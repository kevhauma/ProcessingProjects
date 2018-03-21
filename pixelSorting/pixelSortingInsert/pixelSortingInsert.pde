PImage img;
PImage sorted;
float scale;

void setup() {
  img = loadImage("image.jpg");
  //img = createImage(100, 100, RGB);
  size(800, 800);
  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  img.loadPixels();
  colorMode(HSB);
  //for (int i = 0; i < img.pixels.length; i++) {
  //  img.pixels[i] = color (random(256), 255, 255);
  //}
  sorted = img.get();
    
  float  scaleX = float(width) / img.width;
  float scaleY = float(height) / img.height;
  
  if (scaleX < scaleY) scale = scaleX;
  if (scaleX > scaleY) scale = scaleY;
  
}


int i=1;
color x;
void draw() {
  image(sorted, 0, 0,sorted.width*scale,sorted.height*scale);
  for (int p = 0; p<150; p++) {  
    x =sorted.pixels[i];
    while (i-1 >= 0 && hue(x) < hue(sorted.pixels[i-1])) {
      sorted.pixels[i] = sorted.pixels[i-1];
      i--;
    }
    sorted.pixels[i] = x; 

    if (i>= sorted.pixels.length) noLoop();
    i++;
  }
  sorted.updatePixels();
}