#include <vector>
#include <iostream>
#include <algorithm>
#include <chrono>
#include <fstream>
#include "Vertex.h"
#include "Graph.h"
using namespace std::chrono;

#define SAMPLES 100



//	returns the indexes where the character val is
std::vector<int> find_sub_string(std::string str, char val)
{
	std::vector<int> indexes;
	int length = str.size();
	int i = 0;
	for (int i = 0; i < length; i++) {
		if (str.at(i) == val)
			indexes.push_back(i);
	}
	if (indexes.empty())
		indexes.push_back(-1);
	return indexes;
}


int main() {
		auto start = high_resolution_clock::now();
	
	// -------------- Creating the 'routes_only.dat' --------------
	//std::ifstream read_routes("routes.dat.dat"); //read from the internet file
	//std::ofstream write_routes_only("routes_only.dat"); //create my own file
	//std::string input; 
	//std::string from;
	//std::string to;
	//std::vector<int> index;
	//
	//int i = 0;
	//while (!read_routes.eof())
	//{
	//	read_routes >> input;
	//	if (input.size() < 5) {
	//		continue;
	//	}
	//	index = find_sub_string(input, ',');
	//	input = input.substr(0, index.at(5));
	//	from = input.substr(index.at(1) + 1, 3);
	//	to = input.substr(index.at(3) + 1, 3);
	//	write_routes_only << from << "->" << to << "\n";
	//	std::cout << i++ << std::endl;
	//read_routes.close();
	//write_routes_only.close();
	//}
	std::string input;

	std::cout << "Insert the src airport in ICAO format [4 letters]";
	std::cin >> input;

	//	Initializing variables in order to create the Graph data structre
	std::ifstream read_only_routes("routes_only.dat");
	std::string route;
	std::string source;
	std::string destination;
	Vertex* from = nullptr;
	Vertex* to = nullptr;
	int i = 0;

	//	Building the Graph based on the [source -> destination] in the 'route.dat' file
	Graph airport_routes("Segev - Aircraft Managing System");
	while (!read_only_routes.eof())
	{
		//	The amount of data we giving to the algorithm to work with
		//	The more information, the more accurate -> LOADS TIME INCREASE!
		if (i == SAMPLES) //loading data from file
			break;

		//	Because of the file is coming in some format
		//	I need to change it to something I can work with
		//	[Cutting the important data]
		read_only_routes >> route;
		source = route.substr(0, 3);
		destination = route.substr(5, 3);

		//	Using the searchVertex(Vertex* v) from the Graph
		//	class, check if we already inserted those vertex
		//	Yes -> don't push them in our graph
		//	No  -> Insert!
		from = airport_routes.searchVertex(source);
		to = airport_routes.searchVertex(destination);

		if (from == nullptr)
		{
			from = new Vertex(source);
			airport_routes.insertVertex(from);
		}
		if (to == nullptr)
		{
			to = new Vertex(destination);
			airport_routes.insertVertex(to);
		}

		//	Because of the meaning of the file
		//	I working with, is [source->destination], I've created
		//	a method in vertex that connects two vertex as src and dst
		from->connect(to);
		std::cout << i++ << std::endl;
	}

	Vertex* startPosition = airport_routes.searchVertex(input);
	
	//	 In case user gave incorecct input
	try {
		if (startPosition != nullptr)
			airport_routes.printGraph(Mode::DFS, startPosition);
		else
			throw std::runtime_error("-----------------------------------------\nERROR: Could not find airline company[2] \n	    PROGRAM_TERMINATED\n-----------------------------------------\n");
			//throw "";

	}
	catch (const std::exception& e) {
		std::cout << e.what() << std::endl;
	}

		// calaulate run time 
		auto stop = high_resolution_clock::now();
		std::cout << "Run-Time: " << (duration_cast<milliseconds>(stop - start)).count() << " milliseconds" << std::endl;
		
	
	system("pause");
  	return 0;
}