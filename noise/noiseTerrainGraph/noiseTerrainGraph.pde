int col;
int row;
int scale = 5;
float move = 0.1;
float py, px=0, x=0;
PGraphics graph;
void setup() {
  size(2000, 600);
  graph = createGraphics(width, height);

  background(0);
}



void draw() {
  background(0);
  image(graph, 0, 0);
  if (x>=width) {
    x= 0;
    px = 0;
    graph = createGraphics(width, height);
  }
  noStroke();
  x += 1;     
  move += 0.005;
  float y = map(noise(move), 0, 1, 0, height);
  if (frameCount < 2) {
    py = y;
  }
  fill(255);
  ellipse(x, y, 10, 10);
  graph.beginDraw();
  graph.colorMode(HSB);
  graph.stroke(map(y, 0, height, 0, 255), 255, 255);
  
  //graph.strokeWeight(1);
  //graph.line(px, 0, x, height);
  graph.strokeWeight(3);
  
  graph.line(px, py, x, y);
  graph.endDraw();
  py=y;
  px=x;
}