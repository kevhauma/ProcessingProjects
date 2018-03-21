PImage img;
PImage sorted;
int i = 1;
float scale;
void setup() {
  img = loadImage("image.jpg");
  //img = createImage(400, 400, RGB);
  size(800, 533);
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

void draw() {
  image(sorted, 0, 0,sorted.width*scale,sorted.height*scale);
  if (i < sorted.pixels.length) {
    for (int k = 0; k < 10; k++) {
      for (int j = i; j < sorted.pixels.length-i; j++) {
        color p = sorted.pixels[j];
        color pP = sorted.pixels[j+1];
        if (hue(p)> hue(pP)) {
          sorted.pixels[j] = pP;
          sorted.pixels[j+1]= p;
        }
      }
      sorted.updatePixels();
      i++;
    }
  }
}