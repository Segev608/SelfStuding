
int[] array;
// there would be 'scale' element in the sorting visualization
int scale = 1000;
int counter = 0;
void setup() {
  size(1000, 400);
  array = new int[scale];

  //Initialization
  for (int i=0; i<scale; i++) {
    array[i] = int(random(0, height+1));
  }
}

void drawArray(int[] arr, int size) {
  stroke(0);
  strokeWeight(1);
  for (int i=0; i<size; i++) {
    line(i, height, i, height-arr[i]);
  }
}

void sucess(String myComplex) {
  textSize(50);
  text(myComplex + "\n sucess! \n N = "+counter, width/2, height/2-50);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0); //red
}

void seeComplexity(int c) {
  textSize(10);
  text(Integer.toString(c) + "  N = "+scale, 30, 30);
  fill(255, 0, 0); //red
}

int middle(int l, int r) {
  return (l+r)/2;
}

int temp;
//Quick sort
void quickSort(int[] arr, int left, int right) {
  int pivot;
  int leftIdx = left, rightIdx = right;
  if (right - left > 0) {
    drawArray(arr, scale);
    pivot = middle(left, right);
    while (leftIdx <= pivot && rightIdx >= pivot) {
      while (arr[leftIdx] < arr[pivot] && leftIdx <= pivot) {
        leftIdx++;
      }
      while (arr[rightIdx] > arr[pivot] && right >= pivot) {
        rightIdx--;
      }
      // SWAP
      temp = arr[leftIdx];
      arr[leftIdx] = arr[rightIdx];
      arr[rightIdx] = temp;
      leftIdx++;
      rightIdx++;
      if (leftIdx - 1 == pivot)
        pivot = rightIdx++;
      else if (rightIdx + 1 == pivot)
        pivot = leftIdx++;
    }
    quickSort(arr, left, pivot - 1);
    quickSort(arr, pivot + 1, right);
  }
}

int chooseSorting = 4;
int currentIndex = (chooseSorting == 3) ? 1 : 0; // In Insertion sort it start from 1
boolean finish = false;
String complexity;
int item = 0;
int j;

int minVal;
void draw() {
  background(255);

  switch(chooseSorting) {
  case 1: // Bubble sort
    complexity = "O(N^2)";
    for (j=0; j<scale-1-currentIndex; j++) {
      counter++;
      if (array[j] > array[j+1]) {
        item = array[j];
        array[j] = array[j+1];
        array[j+1] = item;
      }
    }

    break;
  case 2: // Selection sort
    complexity = "O(N^2)";

    minVal = currentIndex;
    for (j=currentIndex+1; j<scale-1; j++) {
      counter++;
      if (array[j] < array[minVal])
        minVal = j;
    }
    item = array[minVal];
    array[minVal] = array[currentIndex];
    array[currentIndex] = item;
    break;
  case 3: // Insetion sort
    complexity = "O(N^2)";
    item = array[currentIndex];
    j = currentIndex-1;

    // put this value in the right place
    // move every element that bigger then him - above him
    while (j >= 0 && array[j] > item) {
      counter++;
      array[j+1] = array[j];
      j=j-1;
    }
    array[j+1] = item;
    break;
    case 4: // Quick sort
    quickSort(array, 0, scale);
  }
  //if (currentIndex < scale-1) currentIndex++;
  //if (currentIndex == scale-1) {
  //  sucess("O(N^2)");
  //  finish = true;
  //}
  //if (!finish) {  
  //  seeComplexity(counter); 
  //  drawArray(array, scale);
  //}
}
