float wiggle;
void setup() {
  size(600, 600);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  rotate(PI/2);
  stroke(255);
  strokeWeight(1);
  float move = 0;
    fill(150,100);
  beginShape();
  for (float a=-PI/2; a <= PI/2; a += PI/150) {
    float r = sin(2*a) * map(noise(move,wiggle),0,1,100,200);
    float x = r *cos(a);
    float y =sin(frameCount*0.05)*r *sin(a);    
    vertex(x, y);
    move+=0.1;
  }
  for (float a=PI/2; a <= 3* PI/2; a += PI/150) {
    float r = sin(2*a) * map(noise(move,wiggle),0,1,100,200);
    float x = r *cos(a);
    float y = 0.5+sin(frameCount*0.05)*r *sin(a);    
    vertex(x, y);
    move-=0.1;
  }
  endShape(CLOSE);
  wiggle+=0.005;
}