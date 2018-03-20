int col;
int row;
int scale = 20;
float move = 0.1;
Point[][] flowfield;
Particle[] parts;

void setup() {
  size(800, 800);
  col = width/scale;
  row = height/scale;
  flowfield = new Point[col][row];
  parts = new Particle[50];
  for (int i = 0; i < parts.length; i++) {
    parts[i] =  new Particle(random(width), random(height));
  }
  background(0);
}



void draw() {
  //colorMode(HSB);  
  stroke(255,100);
  move += 0.000;
  float f = 0.08; 
  for (int y = 0; y<row-1; y++) {
    for (int x = 0; x<col; x++) {
      float angle = map(noise(x*f+move, y*f+move), 0, 1, 0, TWO_PI*2);
      float x2 = scale * sin(angle);
      float y2 = scale * cos(angle);
      flowfield[x][y] = new Point(x2, y2);
      strokeWeight(1);
      //line(x*scale, y*scale, x*scale+x2, y*scale+ y2);
    }
  }
  for (int i = 0; i < parts.length; i++) {
    parts[i].follow(flowfield);
    parts[i].update();
    parts[i].show();
  }
}

class Point {
  float x;
  float y;

  Point(float _x, float _y) {  
    this.x= _x;
    this.y = _y;
  }
  void add(Point p) {
    this.x += p.x;
    this.y += p.y;
  }

  void mult(float m) {
    this.x*=m;
    this.y*=m;
  }
  float getAngle() {
    return atan2(this.x, this.y);
  }
}

class Particle {
  Point pos = new Point(0, 0);
  Point vel= new Point(0, 0);
  Point acc= new Point(0, 0);
  Point pPos = new Point(this.pos.x,this.pos.y);

  Particle(float _x, float _y) {

    this.pos.x= _x;
    this.pos.y = _y;
  }
  void follow(Point[][] field) {
    int x = floor(this.pos.x / scale);
    int y = floor(this.pos.y / scale);
    if(x < 0) x = 0;
    if(y < 0) y = 0;
    if (x >= col) x = col-1;
    if (y >= row) y = row-1;
    if (field[x][y] == null) {x= 0;y=0;} 
      this.applyForce(field[x][y]);
  }

  void update() {
    this.edges();
    this.pos.add(this.vel);
    this.vel.add(this.acc);
    this.vel.mult(0.1);
    this.acc.mult(0);
  }
  void applyForce(Point f) {
    this.acc.add(f);
  }
  void edges() {
    if (this.pos.x >= width){ this.pos.x = 0;this.pPos.x = 0;}  
    if (this.pos.y >= height){ this.pos.y = 0;this.pPos.y = 0;}
    if (this.pos.x <= 0){ this.pos.x = width;this.pPos.x = width;}
    if (this.pos.y <= 0) {this.pos.y = height;this.pPos.y = height;}
    if (this.pPos.x ==0){this.pPos.x =this.pos.x;}
    if (this.pPos.y ==0){this.pPos.y =this.pos.y;}
  }
  void show() {
    stroke(255,50);
    strokeWeight(1);
    line(this.pos.x, this.pos.y,this.pPos.x,this.pPos.y);
    this.pPos = new Point(this.pos.x,this.pos.y);
  }
}