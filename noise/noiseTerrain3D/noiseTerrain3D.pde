int col;
int row;

int w = 5000;
int h = 1600;
int scale = 40;
float move = 0.1;
float[][] zvalue;


void setup() {
  fullScreen(P3D);
  //size(600, 600, P3D);
  col = w/scale;
  row = h/scale;
  zvalue = new float[col][row];

}


void draw() {
  translate(width/2, height/2);
  rotateX(PI/2.8);
  translate(-w/2, -h/4);
  background(0);
  stroke(255,150);
  
  float s = map(mouseY,0,height,0.5,5);
  float f = map(mouseX,0,width,0.01,0.4);
    move -= 0.1;
  for (int y = 0; y<row; y++) {  
    for (int x = 0; x<col; x++) {      
  zvalue[x][y] = map(noise(x*f,y*f+move),0,1,-scale*s,scale*s);     
    }
  }
  
  
  for (int y = 0; y<row-1; y++) {
    
    fill(float(y)/h * 255);
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x<col; x++) {
      vertex(x*scale, y*scale, zvalue[x][y]);
      vertex(x*scale, (y+1)*scale, zvalue[x][y+1]);
    }
    endShape();
  }
}