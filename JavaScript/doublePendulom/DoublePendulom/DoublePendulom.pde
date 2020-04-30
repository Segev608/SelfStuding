float r1 = 200; //the length of the first line
float r2 = 200; // the length of the second line
float m1 = 40; // the mass of the first object
float m2 = 40; // the mass of the first object
float a1 = PI/2; // the first angle between the vertical line and the r1
float a2 = PI/2; // the second angle between "           -         "  r2
float a1_v = 0; //VELOCITY (changes in: DISTANCE PER TIME)
float a2_v = 0;
//float a1_a = 0; //ACCELARATION (changes in: VELOCITY PER TIME)
//float a2_a = 0;
float g = 1;

float px2 = -1;
float py2 = -1;


float cx;
float cy;
PGraphics canvas;

void setup(){
  size(900,600); //Creating a window size 600 pix on 600
  cx = width/2;
  cy = 50; 
  canvas = createGraphics(width,height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
  
}
void draw(){ //THE FURMOLA
  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1 - (2 * a2));
  float num3 = -2 * sin(a1 - a2) * m2;
  float num4 = ((a2_v * a2_v) * r2 + (a1_v * a1_v) * r1 * cos(a1 - a2)); 
  float denum1 = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 -2 * a2));
  float denum2 = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 -2 * a2));
  float num5 = (2 * sin(a1 - a2))*((a1_v * a1_v) * r1 * (m1 + m2) + g * (m1 + m2) * cos(a1) + (a2_v * a2_v)* r2 * m2 *cos(a1 - a2));
  
  float a1_a = ((num1 + num2 + num3 * num4)/denum1);
  float a2_a = num5/denum2;

  
 // background(255); //setting the color to white
  image(canvas,0,0);  
  stroke(0); //the side of the window
  strokeWeight(2);
  translate(cx,cy);
  float x1 = sin(a1) * r1;
  float y1 = cos(a1) * r1;
  
  float x2 = x1 + sin(a2) * r2; //the location is set relatively to the coardination of the first ball 
  float y2 = y1 + cos(a2) * r2;
  
  line(0,0,x1,y1);
  fill(0);
  ellipse(x1,y1,m1,m2); //showing the first ball
  
  line(x1,y1,x2,y2);
  fill(0);
  ellipse(x2,y2,m1,m2); // showing the second ball
  
  a1_v += a1_a; //Changing the place of the object based on the velocity
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;
 //could set an air resistence:
 //a1_v *= 0.99
 //a2_v *= 0.99
  
  canvas.beginDraw();
  canvas.translate(cx,cy);
  canvas.strokeWeight(2);
  canvas.stroke(0);
  if(frameCount > 1){
  canvas.line(px2,py2,x2,y2);
  }
  canvas.endDraw();
  
  px2 = x2;
  py2 = y2;
  
  
}
