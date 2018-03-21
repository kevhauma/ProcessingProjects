int col;
int row;
int scale = 5;
float move = 0.1;
float[][] zvalue;


void setup() {
  size(600, 600);
  col = width/scale;
  row = height/scale;
  zvalue = new float[col][row];
}



void draw() {
  background(0);
  colorMode(HSB);  
  noStroke();
  move += 0.05;
  float f = 0.05;
  for (int y = 0; y<row; y++) {  
    for (int x = 0; x<col; x++) {      
      zvalue[x][y] = map(noise(x*f, y*f+move), 0, 1, 0, 255);
    }
  } 
  for (int y = 0; y<row-1; y++) {
    for (int x = 0; x<col; x++) {
      fill(zvalue[x][y],255,255);
      rect(x*scale, y*scale, x+scale, y+scale);
    }
  }
}