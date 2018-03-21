
int detail = 100;
float radius = 200;
float ran = 0;
void setup() {
  size(600, 600);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  stroke(255);
  strokeWeight(4);
  beginShape();
float move = 0;
  for (float a=0; a < TWO_PI; a += 0.1) {
    //float offset = map(sin(a*10+frameCount*0.1),-1,1,-10,10);
    float offset = map(noise(ran+move), 0, 1, -25, 25);    
    float r = radius + offset;
    float x = r *cos(a);
    float y = r *sin(a);    
    vertex(x, y);
    fill(150);
    
    move+=0.1;
  }
  ran+=0.01;
  fill(255);
  endShape(CLOSE);
}