Perceptron brain; //Creating the Perceptron object
Point[] point = new Point[100];

int trainingIndex = 0; //const value to control the train

void setup(){
  size(600,600); //creating a screen in the size of 600 X 600 pixels
  brain = new Perceptron(3);
  for(int i = 0 ; i<point.length ; i++){
   point[i] = new Point(); //creating points array
  }
  float[] inputs = {-1, 0.5, 1}; //the defualt value
  int guess = brain.guess(inputs); //calculating the guess with the sign function
  println(guess);
}

void draw(){
  background(255); //color
  stroke(0); //reset
  Point p1 = new Point(-1,f(-1)); // in order to draw line we need two points' value - OUR LINE   
  Point p2 = new Point(1,f(1));
  line(p1.pixelX(),p1.pixelY(),p2.pixelX(), p2.pixelY()); //drawing it
                               // line(0,height,width,0); //creating a line from (0,height) to the lower side of the screen
  Point p3 = new Point(-1,brain.guessY(-1));
  Point p4 = new Point(1,brain.guessY(1));
  line(p3.pixelX(),p3.pixelY(),p4.pixelX(),p4.pixelY()); 
 
  for (Point pt : point){ //...for every p (object) in the point array;
    pt.show();
  }
  
   for(Point pt : point){
    float[] inputs = {pt.x , pt.y, pt.bias};
    int target = pt.label;
    // brain.train(inputs, target);
    int guess = brain.guess(inputs);
    if(guess == target){
     fill(0,255,0);
    }else{
     fill(255,0,0); 
    }
     noStroke();
     ellipse(pt.pixelX(), pt.pixelY(), 16, 16);
    } 
  
  Point training = point[trainingIndex]; 
  float[] inputs = {training.x , training.y, training.bias}; //the x and y values of the current inputs
  int target =training.label;
  brain.train(inputs,target); //every frame, the Perceptron train himself based on the previous values
  trainingIndex++; // train every point 'til perfection
  if(trainingIndex == point.length){ //stop condition
    trainingIndex = 0; //reset the value for next time
  }
  
  
  }
 
