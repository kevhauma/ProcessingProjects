
import processing.video.*;

Capture video;
PImage img;

void setup() {
  size(1280, 480);
  video = new Capture(this, 640, 480, 30);
  video.start();  
    img = createImage(video.width,video.height,RGB);
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
  for (int y = 0; y < video.height-1; y++) {
    for (int x = 1; x < video.width-1; x++) {
      color pix = video.pixels[index(x, y)];
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      int factor = floor(map(mouseX,0,width,1,10));
      int newR = round(factor * oldR / 255) * (255/factor);
      int newG = round(factor * oldG / 255) * (255/factor);
      int newB = round(factor * oldB / 255) * (255/factor);
      img.pixels[index(x, y)] = color(newR, newG, newB);

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;


      int index = index(x+1, y  );
      color c = video.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + errR * 7/16.0;
      g = g + errG * 7/16.0;
      b = b + errB * 7/16.0;
      img.pixels[index] = color(r, g, b);

      index = index(x-1, y+1  );
      c = video.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 3/16.0;
      g = g + errG * 3/16.0;
      b = b + errB * 3/16.0;
      img.pixels[index] = color(r, g, b);

      index = index(x, y+1);
      c = video.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 5/16.0;
      g = g + errG * 5/16.0;
      b = b + errB * 5/16.0;
      img.pixels[index] = color(r, g, b);


      index = index(x+1, y+1);
      c = video.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 1/16.0;
      g = g + errG * 1/16.0;
      b = b + errB * 1/16.0;
      img.pixels[index] = color(r, g, b);
    }
  }
  img.updatePixels();
  image(video, 0, 0);
  image(img,640,0);
}