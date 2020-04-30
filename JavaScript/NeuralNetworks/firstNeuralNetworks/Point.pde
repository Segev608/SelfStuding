
float f(float x){
     //y=m*x +n;
  return -0.3 * x + 0.2;
}

class Point{ //Creating a point object to be able later draw it let the Percepton work on it
  float x;
  float y;
  int bias = 1;
  int label; //every point gets value 1 for being above or -1 for being under.
  
  Point(float x_, float y_){ //constructor
   x = x_;
   y = y_;
 }
  
  Point(){
   x = random(-1,1);
   y = random(-1,1);
   float lineY = f(x);
   if(y > lineY){//if there is a point that higher then our line - it gets 1 else -1
    label = 1;  
   }else{
    label = -1; 
   }
  }
  
  float pixelX(){ //functions that return the coardinations of point based on her place in the Cartesian axis system
    return map(x,-1,1,0,width); 
  }
  float pixelY(){
    return map(y,-1,1,height,0);
  }
  
  
  void show(){
   stroke(0); //the color of the surround shape
   if(label == 1){
    fill(255);//black 
   }else{
    fill(0); 
   }
   float px = pixelX(); //drawing a line that start from the center of the field
   float py = pixelY();

   
   ellipse(px,py,32,32); //drawing the circle based on the x and y value (radios 4)
  }
  
}
