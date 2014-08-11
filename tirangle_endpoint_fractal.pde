final int SW = 500, SH = SW;
final int ITERS = 2;
final int Y_INIT = SH/2;
final int X_INIT = SW/2;
final int DRAW_STEPS = 30;
final float SIZE_INIT = 100;//size of the first triangle drawn
final float SHRINK_FACTOR = 0.5;//how much each new generation of edges is to shrink

ArrayList<easeTriangle> triFract;//holds all of the easeTriangle instances
int edgeBeginIndex;//marks where the edges of the fractal begin (like the leaves of a binary tree)
int currentIteration;


void setup(){
  size(SW,SH);
  style_specs_init();
  triangleFract_init();
}

void draw(){
  background(0xFFFFFF);
  //draw all edges until triFact.get(edgeBeginIndex).finished==true,
  //then generate new set of edges and repeat until desired iterations are drawn.
  if(currentIteration < ITERS){
    if(triFract.get(edgeBeginIndex).finished==true){
      edge_generate();
    }
  }
  //call draw_me on every triangle every draw() cycle
  for(int i = 0; i < triFract.size() ; ++i){
    triFract.get(i).draw_me();
  }
}

void style_specs_init(){
  noFill();
}

void edge_generate(){
  //generate the new edges duh
}

void triangleFract_init(){
  currentIteration = 0;
  triFract = new ArrayList<easeTriangle>();
  triFract.add(new easeTriangle(X_INIT, Y_INIT, SIZE_INIT, 0, DRAW_STEPS));
  edgeBeginIndex = 0;//the first triangle is the first edge
}

//The easeTriangle class
//Purpose: Draws a triangle so that it appears to 'pop' into
//         existence as if it were eased
//Dependencies: The Point class, the drawTriangle method
class easeTriangle {
   boolean finished;
   float x,y;//coordinates of the middle of the triangle
   float angle;//angle of the triangle (0 being normal orientation)
   float size;//distance between the center and any point
   int maxSteps, currentStep;
   
   
   easeTriangle(float _x, float _y, float _size, float _angle, int numSteps){
     x = _x;
     y = _y;
     size = abs(_size);
     angle = _angle; 
     maxSteps = abs(numSteps);
     init();
   }
   //used to initialize non-parameterize values
   void init(){
     finished = (maxSteps>0)? false : true;
     currentStep = 0;
   }
   
   void draw_me(){
     if(currentStep < maxSteps){
       //animate the triangle for the current step
       float percent = float(currentStep)/maxSteps;
       float currentLength = expo(percent)*size;
       //draw the triangle
       drawTriangle(new Point(x,y), currentLength, angle);
       ++currentStep;
     }else{
       //draw the triangle normally
       drawTriangle(new Point(x,y), size, angle);
     }  
   }
   
   final float e = 2.7182818284590;//constant delimiting the natural number, e
   //This function maps a percentage (between 0.0 and 1.0) to another function
   //precondition: float between 0 and 1
   //              e is the natural number
   //credit: James Anderson (AKA DissidentIV)
   float expo(float x){
     final int SQUISH = 6;//this is a factor that transforms the function
     x = abs(x);
     //this is the original return value. Since it broke, trying a refactored version
     //return (res==0)? 0 : 1 + pow(-e, -SQUISH * res);
     return (x==0)? 0 : 1 + (-1*(1/pow(e, SQUISH * x)));
   }
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
