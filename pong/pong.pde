
int speed = 5;
Ball ball;
Bar playerbar, AIbar;

PGraphics back;

int playerscore = 0;
int AIscore = 0;


void setup() {
  //size(600, 500);  
  fullScreen();
  back = createGraphics(width,height);
  ball = new Ball();
  playerbar = new Bar(true);
  AIbar = new Bar(false);
}

void draw() {
  background(0);
  image(back,0,0);
  int col = frameCount % 255;
  textSize(45);
  text(playerscore, 350, 60);
  text(AIscore, 250, 60);
  colorMode(HSB);
  back.colorMode(HSB);
  fill(col, 255, 255);
  noStroke();
  back.noStroke();
  back.fill(col, 255, 255);

  //hits left bar
  if (ball.pos.x - ball.w/2 < AIbar.x+AIbar.w/2 &&
    ball.pos.y - ball.w/2 < AIbar.y+AIbar.h/2 &&      
    ball.pos.y + ball.w/2 > AIbar.y-AIbar.h/2) {
    println("hit");
    ball.bounce(false);
  }
  //hits right bar
  if (ball.pos.x + ball.w/2 > playerbar.x-playerbar.w/2 &&
    ball.pos.y - ball.w/2 < playerbar.y+playerbar.h/2 &&      
    ball.pos.y + ball.w/2 > playerbar.y-playerbar.h/2) {

    println("hit");
    ball.bounce(false);
  }



  AIbar.update();
  AIbar.show();
  playerbar.update();
  playerbar.show();
  ball.update();
  ball.show();
}




class Bar {
  float h = height*0.2;
  float w = 10;
  float y =width/2;
  float x;
  boolean player;
  Bar(boolean _player) {
    if (_player) x= width * 0.95;
    else x = width *0.05;
    player = _player;
  }

  void update() {
    if (player) y = mouseY;
    else y = ball.pos.y;
  }
  void show() {
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}


class Ball {
  Vector pos;
  Vector vel;
  int w = 16;
  Ball() {
    pos = new Vector(width/2, height/2);
    int left=-speed, up=-speed;
    if (random(1)>0.5) left = speed;
    if (random(1)>0.5) up = speed;
    vel = new Vector(left, up);
  }
  void update() {
    edges();
    pos.add(vel);
  }
  void show() {
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, w, w);
    
    back.beginDraw();
    back.ellipseMode(CENTER);    
    back.ellipse(pos.x, pos.y, w, w);
    back.endDraw();
  };

  void edges() {
    if (pos.y+w > height || pos.y-w <0) bounce(true);
    if (pos.x+w > width) {
      AIscore++;
      reset();
    }
    if (pos.x-w < 0) {
      playerscore++;
      reset();
    }
  }
  void bounce(boolean top) {
    if (top) vel.y *= -1;
    else vel.x *= -1;
  }
  void reset() {
    pos.x = width/2;
    pos.y =height/2;
  }
}


class Vector {
  float x=0;
  float y=0;
  Vector(float _x, float _y) {
    x=_x;
    y=_y;
  }
  void add(Vector v) {
    this.x += v.x;
    this.y += v.y;
  }
}