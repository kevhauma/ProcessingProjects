PImage img;
PImage sorted;
int i = 0;
void setup() {
  img = createImage(400,400,RGB);
  size(800, 801);
  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  img.loadPixels();
    colorMode(HSB);
  for(int i = 0; i < img.pixels.length;i++){
      img.pixels[i] = color (random(256),255,255);
  }
  i = 0;  
  sorted = img.get();
  //for(int i = 0; i < sorted.pixels.length;i++){
  //  float rec = -1;
  //  int sel = i;
  //  for(int j = i; j < sorted.pixels.length;j++){
  //    color p = sorted.pixels[j];
  //    float b = brightness(p);      
  //    if(b > rec){
  //      sel = j;
  //      rec = b;
  //    }
  //  }
  //  color temp =  sorted.pixels[i];
  //  sorted.pixels[i] =sorted.pixels[sel];
  //  sorted.pixels[sel]= temp;
  //}


  //sorted.updatePixels();
}

void draw() {  
 // image(img, 0, 0);
  image(sorted, 0, 0);
  println(frameRate);
  if (i < sorted.pixels.length) {
    for (int k = 0; k < 100; k++) {
      float rec = -1;
      int sel = i;
      for (int j = i; j < sorted.pixels.length; j++) {
        color p = sorted.pixels[j];
        float b = hue(p);      
        if (b > rec) {
          sel = j;
          rec = b;
        }
      }
      color temp =  sorted.pixels[i];
      sorted.pixels[i] =sorted.pixels[sel];
      sorted.pixels[sel]= temp;

      sorted.updatePixels();
      i++;
    }
  }
}