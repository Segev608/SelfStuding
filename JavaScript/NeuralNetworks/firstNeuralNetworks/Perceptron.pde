 // The activition function
 int sign(float n){ //known as the sign function
  if(n >= 0){
      return 1;
  } else {
      return -1; 
  }
 }
 
 
 //Writing the class like that gives us the
 //oppertunity, later, to change values and make it Generic
 class Perceptron{
  //creating an object to save weight
  float[] weights = new float[3]; //the weight value which the neuron gets (from the different inputs x1,x2...)
  float learningRate = 0.001; //the amount of change that the Percepton change every time he train
  Perceptron(int n){ //constructor
  //puts random values into array 
    weights = new float[n];
    for(int i=0; i<weights.length -1; i++){ //starts with random value
     weights[i] = random(-1,1);   //and puts it into the weight array
    }
  }
  int guess(float[] inputs){ // the guess-function helps the preceptron to generate a value (1 or -1) 
                             // based on the result it gets [in our case it calculating the sum of all weight*input]
     float sum = 0;
     for(int i=0; i<weights.length; i++){
     sum += inputs[i] * weights[i]; // summing the weight * input value
     }
     int output = sign(sum);
     //create return value based on the sign function
     return output;
  
     }
     void train(float[] inputs, int target){ //gets the inputs = weight and tune them properly
       int guess = guess(inputs); // the train  function uses the function guess
       int error = target - guess; // checks the Calculation deviation and if it should increased/decreased
                                   // if error = 0, it means that it trained well (the tune has been successful)
       for(int i=0; i<weights.length; i++){
         weights[i] += error * inputs[i] * learningRate; //basiclly, the Percepton tune himself based on the failure
       }                                            //he just had (change a little bit = and try again)
     }                                                  // (*) if error = 0 it addes nothing and the current weight is good
                                                        // (*) if error = 2 it means that he guessed to low and he need to send 
                                                         // the next weight smaller then now
                                                         // (*) if error = -2 it means that he guessed to high and he needs 
                                                         // to send the next weight higher then now
       float guessY(float x){
         float w0 = weights[0];
         float w1 = weights[1];
         float w2 = weights[2];
         return (-(w2/w1) - (w0/w1) * x);
       }
     
   }
