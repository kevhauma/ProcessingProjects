PImage img;
PImage sorted;
int count =0;
void setup() {
  img = createImage(100, 100, RGB);
  size(800, 800);
  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  img.loadPixels();
  colorMode(HSB);
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color (random(256), 255, 255);
  }
  sorted = img.get();  
}


void draw() {
  image(sorted, 0, 0, width, height);
}


void mousePressed(){
  Sort(0, sorted.pixels.length-1);
    sorted.updatePixels();
}


void Sort(int start, int end) {
  int startT = start;
  int endT = end;
  float midC= hue(sorted.pixels[floor((start + end) / 2)]);
  do {
    while (hue(sorted.pixels[startT]) <midC) {      
      startT++;
    }
    while (hue(sorted.pixels[endT]) <midC) {      
      endT--;
    }
    if (endT <= startT) {
      color temp = sorted.pixels[startT];
      sorted.pixels[startT] = sorted.pixels[endT];
      sorted.pixels[endT] = temp;
    sorted.updatePixels();
    }
  } while (startT < endT);
    println(count++);
  if (start < endT) Sort(start, endT);
  if (startT < end) Sort(startT, end);
}