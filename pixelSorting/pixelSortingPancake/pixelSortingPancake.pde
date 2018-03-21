PImage img;
PImage sorted;
int i, j, t, kol;
int len;
void setup() {
  img = loadImage("image.jpg");
  //img = createImage(400, 400, RGB);
  size(800, 800);
  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  img.loadPixels();
  colorMode(HSB);
  //for (int i = 0; i < img.pixels.length; i++) {
  //  img.pixels[i] = color (random(256), 255, 255);
  //}
  sorted = img.get();
  len = sorted.pixels.length;
  kol = len/3;
}


void shellSort() {
}



void draw() {
  image(sorted, 0, 0, width, height);

  
  
   // if (kol == 0) kol =1;
    for (i = kol; i< len; i++) {
      j=0;
      while (i-j>=kol && sorted.pixels[i-j]<sorted.pixels[i-kol-j]) {
        t = sorted.pixels[i-j];
        sorted.pixels[i-j] = sorted.pixels[i-kol-j];
        sorted.pixels[i-kol-j] = t;
        j+=kol;

        sorted.updatePixels();
      }
    }
    //if (kol == 1) noLoop();
  
  kol/=3;
}