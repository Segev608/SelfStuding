#include <iostream>
#include <vector>
#include <functional>
using namespace std;

//segev608@gmail.com

// Mission1: How is a bubble sort algorithm implemented?
// The sort function's comlexity is O(n^2)
template<class T>
void listStatus(T* arr, int size) {
	cout << "[";
	for (int i = 0; i < size; i++) {
		cout << *(arr + i) << ", ";
	}
	cout << "]" << endl;;
}

template<class value>
void bubble_sort(value* container, function<bool(int, int)> condition, int size) {
	value temp;
	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size - i - 1; j++) {
			if (condition(*(container + j), *(container + j + 1))) {
				temp = *(container + j);
				*(container + j) = *(container + j + 1);
				*(container + j + 1) = temp;
			}
		}
		listStatus(container, size);
	}
}

bool func(int a, int b) {
	if (a > b) return true;
	return false;
}

int main(){
	//Implementation
	int l[] = { 1,5,13,22,8,4,66,52,48 };
	bubble_sort(l, func, 9);
	return 0;
}