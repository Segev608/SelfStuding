#pragma once
#include <vector>
#include <queue>
#include <stack>
#include <algorithm>
#include <string>
#include <stdarg.h>
#include <fstream>
#include "Vertex.h"

#define UNREACHABLE 9999

//	Update no.2 14/05/2020
//	In no.3 will be Dijkstra 
enum Mode {DFS, BFS};

//	Handle graph problems
class Graph {
private:
	//	All the vertecies in the graph
	std::vector<Vertex*> _nodes;
	std::string graph_name;
public:
	Graph(std::string); //	Contructor
	void BFS(Vertex* s);
	void insertVertex(Vertex* &v);
	void insertVertex(int amount, ...);
	void connectVertex(Vertex* &from, Vertex* &to);
	void printGraph(Mode printMode, Vertex* source);
	void DFS_visit(int &time, Vertex* &v);
	void DFS();
	Vertex* searchVertex(std::string);

};
//	---------- Implementations ----------


Graph::Graph(std::string name) {
	graph_name = name;
}


//The Breadth-first search. Iterative algorithm O(|V|+|E|)
void Graph::BFS(Vertex* s) 
{
	//Initialization
	for (Vertex* item : _nodes)
	{
		item->setColor(Color::WHITE);
		item->setDistance(UNREACHABLE);
	}

	s->setColor(Color::GRAY);
	s->setDistance(NULL);
	std::queue<Vertex*> queue;
	Vertex* temp;

	//	Initialize the queue in order to get sonar effect
	//	from the requested vertex s
	queue.push(s);
	while (!queue.empty())
	{
		temp = queue.front();
		queue.pop();

		//	Increasing the search spread by checking every path
		//	from every vertex
		for (Vertex* item : temp->getNeighbors())
		{
			if (item->getColor() == Color::WHITE) {
				item->setColor(Color::GRAY);
				item->setDistance(temp->getDistance() + 1);
				item->setPrevious(temp);
				queue.push(item);
			}
		}

		//	Set color to black in order to avoid him in the next iteration
		temp->setColor(Color::BLACK);
	}
}

//	Insert single vertex into the graph [check if he already inside - O(N)]
void Graph::insertVertex(Vertex* &v)
{
	if (this->searchVertex(v->getTag()) == nullptr) {
		_nodes.push_back(v);
		v->setStatus(true);
	}
}

//	Connect two vertex by inserting each to the another neighbors vector<Vertex*> O(1)
void Graph::connectVertex(Vertex* &from, Vertex* &to)
{
	from->connect(to); //insert to into from's neighbors's vector
}

//	Insert multiple Vertex by using the va_start function [O(N * K) | K - number of vertices] 
void Graph::insertVertex(int amount, ...)
{
	Vertex* temp;
	va_list vl;
	va_start(vl, amount);
	for (int i = 0; i < amount; i++)
	{
		temp = va_arg(vl, Vertex*);
		insertVertex(temp);
	}
	va_end(vl);
}

//	.dat file. By chosing what mode to work with it creat the file
//	1) BFS - prints all the posibilities and the cost from src to dst [ITERATIVE]
//	2) DFS - print all the posibilities from src to dst [RECURSIVE]
void Graph::printGraph(Mode printMode, Vertex* sourcePosition = nullptr)
{
	//	Initializations
	int i;
	int length;
	int init;
	int fin;
	
	//	The file name is based on the src vertex (user-input)
	std::ofstream destinations("ConnectionsFrom_"+ sourcePosition->getTag() +".dat");
	
	//	user has multiple choises
	switch (printMode)
	{
	case Mode::BFS:
		//	Execute BFS on the graph
		this->BFS(sourcePosition);

		//	Sort vertex by their costs from the source [see definition for '9999' value in line 11] 
		std::sort(_nodes.begin(), _nodes.end(), [](Vertex* first, Vertex* second)
		{
			return (first->getDistance() < second->getDistance());
		}
		);

		std::cout << "ACCESS FROM [" << sourcePosition->getTag() << "] :" << std::endl;
		i = 0;
		length = _nodes.size();
		
		//	Writing to the file
		while (i < length && _nodes.at(i)->getDistance() != 999)
		{
			destinations << _nodes.at(i++);
			//std::cout <<  << std::endl;
		}
		break;

	case Mode::DFS:
		this->DFS();
		init = sourcePosition->getInit();
		fin = sourcePosition->getFin();
		std::sort(_nodes.begin(), _nodes.end(), [](Vertex* first, Vertex* second)
		{
			return (first->getInit() < second->getInit());
		}
		);
		i = 0;
		length = _nodes.size();
		Vertex* current;
		destinations << "----- Places you can go -----\n";
		while (i < length)
		{
			current = _nodes.at(i);
			if (fin < current->getInit())
				break;
			//std::cout <<"[NODE: "<< current->getTag() << "] [Initial: " << current->getInit() << "| Final: " << current->getFin() << "]\n";
			
			if (init < current->getInit() && fin > current->getFin())
				destinations << current->getTag() << "\n";

			i++;

		}
		break;


	default:
		break;
	}
}

void Graph::DFS_visit(int &time, Vertex* &v) 
{
	v->setColor(Color::GRAY);
	v->setInit(++time);
	for (Vertex* ver : v->getNeighbors())
	{
		if (ver->getColor() == Color::WHITE)
		{
			ver->setPrevious(v);
			DFS_visit(time, ver);
		}
	}
	v->setColor(Color::BLACK);
	v->setFin(++time);
}

void Graph::DFS()
{
	//Initialize values
	int time = 0;
	for (Vertex* ver : _nodes) 
		ver->setColor(Color::WHITE);

	//Activate DFS_visit() on the graph
	for (Vertex* item : _nodes)
		if (item->getColor() == Color::WHITE)
			DFS_visit(time, item);
}

//	Helpful method in order to avoid multiple instances of the same
//	verteices in our vector<Vertex*> 
Vertex* Graph::searchVertex(std::string name)
{
	for (Vertex* item : _nodes)
	{
		if (name == item->getTag())
			return item;
	}
	return nullptr;
}


