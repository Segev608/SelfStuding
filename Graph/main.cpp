#include <vector>
#include <iostream>
#include <algorithm>
#include "Vertex.h"
#include "Graph.h"

int main() {
	
	Vertex* p1 = new Vertex("A");
	Vertex* p2 = new Vertex("B");
	Vertex* p3 = new Vertex("C");
	Vertex* p4 = new Vertex("D");
	Vertex* p5 = new Vertex("E");
	Vertex* p6 = new Vertex("F");
	Vertex* p7 = new Vertex("G");
	Vertex* p8 = new Vertex("H");
	Vertex* p9 = new Vertex("I");

	//----- Connection -----
	//[taken from the presentation in Data Structure II]
	//p1 - A
	p1->connect(p2);
	p1->connect(p6);

	//p2 - B
	p2->connect(p3);
	p2->connect(p7);

	//p3 - C
	p3->connect(p8);

	//p4 - D
	p4->connect(p3);
	p4->connect(p5);

	//p5 - E
	//NONE

	//p6 - F
	p6->connect(p5);
	p6->connect(p9);

	//p7
	p7->connect(p1);

	//p8
	p8->connect(p7);
	p8->connect(p9);

	//p9
	p9->connect(p7);
	
	Graph* graph = new Graph("training");
	graph->insertVertex(9, p1, p2, p3, p4, p5, p6, p7, p8, p9);

	//graph->BFS(p1);
	graph->destinationsFrom(p3);

	std::cout << "DONE";

	system("pause");
  	return 0;
}