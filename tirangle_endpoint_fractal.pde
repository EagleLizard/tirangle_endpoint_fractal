final int SW = 500, SH = SW;

void setup(){
  size(SW,SH);
  style_specs_init();
  
}

void draw(){
  background(0xFFFFFF);
  drawTriangle(new Point(SW/2,SH/2), 50, 0);
}

void style_specs_init(){
  noFill();
}

//drawTriangle draws an equilateral triangle at the point given.
//size is a measure of the distance between the center and any point.
//angle is the angle to draw at, given in radians (0 is a normal triangle)
void drawTriangle(Point pt, float size, float angle){
  //draw the first point straight up,
  //then rotate 120
  float _angle = -PI/2+angle;
  Point p1,p2,p3;
  p1 = new Point(pt.x+size*cos(_angle),pt.y+size*sin(_angle));
  p2 = new Point(pt.x+size*cos(_angle+(2*PI/3)),pt.y+size*sin(_angle+(2*PI/3)));
  p3 = new Point(pt.x+size*cos(_angle-(2*PI/3)),pt.y+size*sin(_angle-(2*PI/3)));
  triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y);
  print("Center to p1: " + size + "\n1/2 height = " + ((p1.y-p2.y)/2) + "\n");
}



class Point{
  float x, y;
  Point(float _x, float _y){
    x = _x;
    y = _y;
  }
  Point(){
    x = 0;
    y = 0;
  }
}
