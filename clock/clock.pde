float maxHours = 24.0;
float maxMinutes = 60.0;
float maxSeconds = 60.0;
int hue = 0;

int cY;
int cX;
void setup() {
  size(1500, 1500);

  cX = width /2;
  cY = height / 2;
}

void draw() {  
  hue = floor(map(mouseY,0,height,0,255));
  
  colorMode(HSB);
  background(hue,200,255);
  colorMode(RGB);
  noFill();
  int h = hour()%12;
  int m = minute();
  int s = second();

  
  float hD = toRadians(h/maxHours);
  float mD = toRadians(m/maxMinutes);
  float sD = toRadians(s/maxSeconds); 
  //draw circles

  strokeWeight(15);
  stroke(255, 0, 0);
  float cW1 = 0.6*width;
  float cH1 = 0.6*height;  
  arc(cX, cY, cW1, cH1, -PI/2, sD);


  stroke(0, 255, 0);
  float cW2 = 0.55*width;
  float cH2 = 0.55*height;
  arc(cX, cY, cW2, cH2, -PI/2, mD);


  stroke(255, 255, 0);
  float cW3 = 0.5*width;
  float cH3 = 0.5*height;
  arc(cX, cY, cW3, cH3, -PI/2, hD);
  
  
  
  float len = map(mouseX,0,width,5,2);
  strokeWeight(15);
  stroke(255, 0, 0);
  line(cX, cY, cos(sD)*(cW1/len) + cX, sin(sD)*(cH1/len)+ cY);
  stroke(0, 255, 0);
  line(cX, cY, cos(mD)*(cW2/len) + cX, sin(mD)*(cH2/len)+ cY);
  stroke(255, 255, 0);
  line(cX, cY, cos(hD)*(cW3/len) + cX, sin(hD)*(cH3/len)+ cY);
}

float toRadians(float percent) {
  float degrees = (percent*360)-90;
  return radians(degrees);
}