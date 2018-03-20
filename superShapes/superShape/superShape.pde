
float  n1 = 1;
float  n2 = 1;
float  n3 = 1;
float  m = 5;
float  a = 1;
float  b = 1;

float osc =0;
int scale = 100;
int total = 500;
float incr = TWO_PI / total;

void setup() {
  size(500, 500);
  background(0);
}

void draw() {
  background(0); 
  stroke(255);
  translate(width/2, height/2);  
  rotate(-PI/2);
  m = map(sin(osc), -1, 1, 1, 20);
  b = map(sin(osc), -1, 1, 0.1, 1);
  a = map(sin(osc), -1, 1, 0.1, 1);
  n1 = map(sin(osc), -1, 1, 1, 20);
  n2 = map(sin(osc), -1, 1, 1, 20);
  n3= map(sin(osc), -1, 1, 1, 20);
  osc+=0.02;
  noFill();
  beginShape();
  for (float angle = 0; angle< TWO_PI; angle+=incr) {
    float r = superShape(angle);
    float x = scale * r * cos(angle);
    float y = scale * r * sin(angle); 
    vertex(x, y);
  }
  endShape(CLOSE);
}

float superShape(float theta) {
  float p1 = abs((1/a) * cos(theta *m/4));
  p1 = pow(p1, n2);
  float p2 = abs((1/b) * sin(theta *m/4));
  p2 = pow(p2, n3);
  float p3 = pow((p1 + p2), 1/n1);

  float r = 1/p3;

  return r;
}