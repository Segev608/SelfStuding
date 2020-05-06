#include <iostream>
#include <exception>

class Buffer_overflow_exception : public std::exception {
private:
	std::string _msg;
public:
	//	constructor
	Buffer_overflow_exception(const std::string& msg) : _msg(msg) {} 
	virtual const char* what() const noexcept override {
		return _msg.c_str(); //	return _msg in char* format
	}
};

void printArr(char** arr, int size) {
	for (int i = 0; i < size; i++) {
		std::cout << arr[i] << std::endl;
	}
}

template<class T>
void expend_matrix(T** &arr, int current_rows, int current_columns, int new_rows, int new_columns) {
	//	Initializing the temporary array to the size of our array
	T** temp;
	temp = new T*[current_rows];
	int i = 0;
	bool err = false;
	
	//	There might be problem in case user decrease the size of the metrix's columns|rows
	//	and then tries to copy the data into the new generated array
	if (current_rows > new_rows)
		throw Buffer_overflow_exception("ERROR: _DISCREPANCIES!_ check that the new_rows value is greater or equal to current_rows \n");

	for (; i < current_rows; i++) {
		temp[i] = new T[current_columns];
	}

	//	copying the values from our array to temporary one
	for (i = 0; i < current_rows; i++) {
		strncpy(temp[i], arr[i], current_columns);
	}

	//	deleting our arr in order to expend it
	for (i = 0; i < current_rows; i++) {
		delete[] arr[i];
	}
	delete[] arr;

	arr = new T*[new_rows];
	for (i = 0; i < new_rows; i++) {
		arr[i] = new T[new_columns];
	}
	
	//	return the values
	//	in case the matrix size has decreased - check for buffer overflows
	for (i = 0; i < current_rows; i++) {
		if (strlen(temp[i]) > new_columns)
			throw Buffer_overflow_exception("ERROR: BUFFER_OVERFLOW_EXCEPTION_AT_BUILDING_THE_MATRIX \n");
		strncpy(arr[i], temp[i], current_columns);
	}
	
	
	for (i = 0; i < current_rows; i++) {
		delete[] temp[i];
	}
	delete[] temp;
	
}


int main() {
	
	int amount = 3;
	int length = 6;

	char** names;
	names = new char*[amount];
	for (int i = 0; i < amount; i++)
	{
		names[i] = new char[length];
	}
	strncpy(names[0], "first_input", length);
	strncpy(names[1], "second_input", length);
	strncpy(names[2], "third_input", length);
	
	try {
		expend_matrix(names, amount, length, amount - 1, length);
	}
	catch (std::exception& e) {
		std::cout << e.what();
		system("pause");
		return -1;
	}
	strncpy(names[3], "fourth_input", 6);
	printArr(names, 4);

 	system("pause");
	return 0;
}