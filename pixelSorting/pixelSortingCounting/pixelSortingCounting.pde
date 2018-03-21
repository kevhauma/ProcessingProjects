PImage img;
PImage sorted;
ColorHue[] count;
int c =0;

float scale;
void setup() {
  img = loadImage("image.jpg");
  //img = createImage(500, 500, RGB);
  size(1500, 1500);

  float scaleX = float(width) / img.width;
  float scaleY = float(height) / img.height;

  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  img.loadPixels();
  colorMode(HSB);
  //for (int i = 0; i < img.pixels.length; i++) {
  //  img.pixels[i] = color (random(256), 255, 255);
  //}
  sorted = img.get();
  count = new ColorHue[256];
  
  for(int k = 0; k < count.length;k++){
    count[k] = new ColorHue(k);
  }  

  if (scaleX < scaleY) scale = scaleX;
  if (scaleX > scaleY) scale = scaleY;
}
int m = 0, i=0;
int total =0;
boolean counted = false;
void draw() {
  image(sorted, 0, 0, sorted.width*scale, sorted.height*scale);
  stroke(0);
  strokeWeight(1);
  for (int f = 0; f <sorted.width*scale; f++) { 
    if (!counted) {
      color v = sorted.pixels[i];
      
      int h = floor(hue(v));
      count[h].addColor(v);   
      
      int x = i % sorted.width;
      int y = floor(i / sorted.width);
      point(x*scale, y*scale);
    }
    i++;
    if (i >= sorted.pixels.length) counted = true;
  }
  if (counted) {
    for (int l = 0; l<count[c].colors.size(); l++) {
      sorted.pixels[m] = count[c].colors.get(l);      
      m++;
    }
    c++;
  }
  sorted.updatePixels();
  if (m >= sorted.pixels.length)noLoop();
}


class ColorHue {
  int hue;
  ArrayList<Integer> colors;
  ColorHue(int _hue){
  this.hue = _hue;
   colors = new ArrayList();
  }
  void addColor(color cl){
    this.colors.add(cl);
  }
  
}
  
  
  