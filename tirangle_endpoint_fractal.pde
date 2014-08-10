final int SW = 500, SH = SW;
easeTriangle testTriangle;
void setup(){
  size(SW,SH);
  style_specs_init();
  testTriangle = new easeTriangle(SW/2, SH/2, 50, 0, 20);
}

void draw(){
  background(0xFFFFFF);
  testTriangle.draw_me();
}

void style_specs_init(){
  noFill();
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
