#include "opencv2/opencv.hpp"

using namespace cv;

int main(int argv, char** argc)
{
	Mat test = imread("frog.jpg", IMREAD_GRAYSCALE);
	imshow("test",test);
	waitKey(0);
	
}

// -----episode 2-----
// imread(INPUT_FILE_NAME, OPTION) - open file and read it with some manipulation
// imwrite("OUTPUT_FILE_NAME, MAT_VARIABLE) - save Mat variable as file


// -----episode 3-----
// nameWindow(INSTANCE_NAME, OPTION) - create an instance of window which is capable to hold photos
// resizeWindow(INSTANCE_NAME, NEW_X_LENGTH, NEW_Y_LENGTH) - resize the window into the requested one
// moveWindow(INSTANCES_NAME, X_POS, Y_POS) - unable to move the window into certain position
// Mat object ->
// object.col => returns the amount of colums in this mat object
// object.row => ''		''		''	   rows	''		''		''	

// -----episode 4-----
