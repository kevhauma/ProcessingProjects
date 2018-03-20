
float n = 0.5;
void setup() {
  size(500, 500);
  background(0); 
  
  
  
}

void draw() {
  background(0); 
  int a= 100;
  int b = 100;
  n = map(mouseX,0,width,0.01,10);
  stroke(255);
  translate(width/2,height/2);
  noFill();
  beginShape();
  for (float angle = 0; angle< TWO_PI;angle+=0.01){
      float na = 2/n;
      float x = pow(abs(cos(angle)),na) * a *sgn(cos(angle)); ;
      float y = pow(abs(sin(angle)),na) * b *sgn(sin(angle)); ;
      vertex(x,y);
     
  }
 endShape(CLOSE);
}


int sgn(float f){
  if (f > 0)return 1;
  else if (f < 0)return -1;
  else return 0;
}