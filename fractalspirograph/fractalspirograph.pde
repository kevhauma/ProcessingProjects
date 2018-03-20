ArrayList<Orbit> orbits;
ArrayList<PVector> path;
int AMOUNT =50;
int speedup = 100;
int cY;
int cX;
int k = -5;
Orbit sun;
Orbit end;
void setup() {
  size(3840, 2160);
  orbits = new ArrayList();
  path = new ArrayList();
  cX = width /2;
  cY = height / 2;

  sun = new Orbit(cX, cY, 0, height*0.5/2);
  Orbit child = sun;
  for (int i = 0; i < AMOUNT; i++) {
    child = child.add();
  }

  end = child;



  noFill();
}

void draw() {
  background(0);
  stroke(255);
  for (int i = 0; i < speedup; i++) {
    Orbit next = sun;
    while (next != null) {
      //next.draw();
      next.update();
      next = next.child;
    }
    path.add(new PVector(end.x, end.y));
  }


  stroke(255, 255, 0);
  strokeWeight(1);
  beginShape();
  for (PVector v : path) {
    vertex(v.x, v.y);
  }
  endShape();
  //noLoop();
}


class Orbit {
  int level;
  float x;
  float y;
  float r;
  int n;
  float rot =-PI/2;
  float speed;

  Orbit parent;
  Orbit child;

  Orbit(float _x, float _y, int _n, float _r) {
    this(_x, _y, _n, _r, null);
  }

  Orbit(float _x, float _y, int _n, float _r, Orbit _parent) {
    this.x = _x;
    this.y = _y;
    this.r = _r;
    this.n= _n;
    this.speed = radians(pow(k, n-1))/speedup;
    parent = _parent;
  }
  Orbit add() {    
    float newR = this.r * 0.3;    
    float newX = this.x + this.r + newR;
    this.child = new Orbit(newX, this.y, this.n+1, newR, this);
    return this.child;
  }
  void update() {
    this.rot += this.speed;
    if (this.parent != null) {
      float sumR = this.r + parent.r;
      this.x = parent.x + cos(rot) * sumR;
      this.y = parent.y + sin(rot) * sumR;
    }
  }
  void draw() {
    this.rot += this.speed;


    ellipseMode(CENTER);
    ellipse(this.x, this.y, this.r*2, this.r*2);
  }
}