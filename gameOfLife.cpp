#include <iostream>
#include <ctime>
#include <Windows.h>
using namespace std;

const int probablility[] = { 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 }; // 10% to generate life on board

// returns the game grid
char** createGrid(int height, int width) {
	char** temp = new char*[height];
	for (int i = 0; i < height; i++)
		temp[i] = new char[width];
	return temp;
}

// define default grid 
void initializeGrid(char** arr, int height, int width) {
	for (int i = 0; i < height; ++i)
		for (int j = 0; j < width; ++j)
			arr[i][j] = ' ';
}

// generate random value grid - first time only
void generateGrid(char** arr, int height, int width) {
	
	// Gosper glider gun (from 48-97)
	arr[5][1] = char(223);
	arr[6][1] = char(223);
	arr[5][2] = char(223);
	arr[6][2] = char(223);
	
	arr[5][11] = char(223);
	arr[6][11] = char(223);
	arr[7][11] = char(223);

	arr[4][12] = char(223);
	arr[8][12] = char(223);

	arr[3][13] = char(223);
	arr[9][13] = char(223);

	arr[3][14] = char(223);
	arr[9][14] = char(223);

	arr[6][15] = char(223);

	arr[4][16] = char(223);
	arr[8][16] = char(223);

	arr[5][17] = char(223);
	arr[6][17] = char(223);
	arr[7][17] = char(223);
	
	arr[6][18] = char(223);

	arr[3][21] = char(223);
	arr[4][21] = char(223);
	arr[5][21] = char(223);

	arr[3][22] = char(223);
	arr[4][22] = char(223);
	arr[5][22] = char(223);

	arr[2][23] = char(223);
	arr[6][23] = char(223);

	arr[1][25] = char(223);
	arr[2][25] = char(223);
	arr[6][25] = char(223);
	arr[7][25] = char(223);

	arr[3][35] = char(223);
	arr[4][35] = char(223);
	arr[3][36] = char(223);
	arr[4][36] = char(223);

	/*
	// generate random seed value
	srand(time(NULL)); 
	for (int i = 0; i < height; ++i)
		for (int j = 0; j < width; ++j) 
				arr[i][j] = (probablility[rand() % 10]) ? char(223) : ' ';
	
	*/
}

void copyGrid(char** &into, char** &from, int height, int width) {
	for (int i = 0; i < height; ++i) 
		for (int j = 0; j < width; ++j) 
			into[i][j] = from[i][j];
}

char** checkGrid(char**& arr, int height, int width) {
	char** temp = createGrid(height, width);
	copyGrid(temp, arr, height, width);
	int i = 0, j = 0;
	int neighbors;
	bool alive = false; // different behavior if the cell is dead or alive
	for (; i < height; ++i) {
		for (; j < width; ++j) {
			// it only checks cells with 8 neighbors
			if ((i < (height - 2) && j < (width - 2)) && (i > 0 && j > 0)) {

				//check if he dead or alive
				alive = (int(arr[i][j]) == -33) ? true : false;
				neighbors = 0;

				// iterate over his neighbors and count them
				for (int moveY = -1; moveY < 2; ++moveY) {
					for (int moveX = -1; moveX < 2; ++moveX) {
						if (moveY != 0 || moveX != 0) {
							// if this cell has neighbor here, count him
							// 223 is -33 in signed char
							neighbors += (int(arr[i + moveY][j + moveX]) == -33) ? 1 : 0;
						}
					}
				}
				// over-population\under-population - cause this cell to die
				if (alive && (neighbors <= 1 || neighbors >= 4)) 
					temp[i][j] = ' ';
				
				// reproduction - cause dead cell to born
				if (!alive && neighbors == 3) 
					temp[i][j] = char(223);
			}
		}
		j = 0;
	}
	copyGrid(arr, temp, height, width);
	return arr;
}

void printGrid(char** arr, int height, int width) {
	for (int i = 0; i < height; ++i) {
		for (int j = 0; j < width; ++j) {
			cout << arr[i][j];
		}
		cout << endl;
	}
}


#define _WIDTH_ 38
#define _HEIGHT_ 16
#define _LOOP_ 500
#define _RENDER_SPEED_(FPS)	(1000/FPS)

int main(int argc, char** argv) {	
	//create GOL grid
	char** grid = createGrid(_HEIGHT_, _WIDTH_);
	initializeGrid(grid, _HEIGHT_, _WIDTH_);
	generateGrid(grid, _HEIGHT_, _WIDTH_);

	// game loop
	for (int i = 0; i < _LOOP_; ++i) {
		printGrid(grid, _HEIGHT_, _WIDTH_);
		Sleep(_RENDER_SPEED_(20));
		system("cls");
		Sleep(_RENDER_SPEED_(20));
		grid = checkGrid(grid, _HEIGHT_, _WIDTH_);
	}
	
	
	system("pause");
	return 0;
}