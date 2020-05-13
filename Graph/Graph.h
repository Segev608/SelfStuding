#pragma once
#include <vector>
#include <queue>
#include <algorithm>
#include <string>
#include <stdarg.h>
#include "Vertex.h"

#define UNREACHABLE 999

class Graph {
private:
	std::vector<Vertex*> _nodes;
	std::string graph_name;
public:
	Graph(std::string);
	void BFS(Vertex* s);
	void insertVertex(Vertex* &v);
	void insertVertex(int amount, ...);
	void connectVertex(Vertex* &from, Vertex* &to);
	void destinationsFrom(Vertex*);

	~Graph();
};

Graph::Graph(std::string name) {
	graph_name = name;
}

Graph::~Graph()
{
	for (Vertex* item : _nodes)
	{
		item->deleteVertex(item);
	}
}

void Graph::BFS(Vertex* s) 
{
	for (Vertex* item : _nodes)
	{
		item->setColor(Color::WHITE);
		item->setDistance(UNREACHABLE);
	}

	s->setColor(Color::GRAY);
	s->setDistance(NULL);
	std::queue<Vertex*> queue;
	Vertex* temp;
	queue.push(s);
	while (!queue.empty())
	{
		temp = queue.front();
		queue.pop();
		for (Vertex* item : temp->getNeighbors())
		{
			if (item->getColor() == Color::WHITE) {
				item->setColor(Color::GRAY);
				item->setDistance(temp->getDistance() + 1);
				item->setPrevious(temp);
				queue.push(item);
			}
		}
		temp->setColor(Color::BLACK);
	}
}

void Graph::insertVertex(Vertex* &v)
{
	_nodes.push_back(v);
}

void Graph::connectVertex(Vertex* &from, Vertex* &to)
{
	from->connect(to); //insert to into from's neighbors's vector
}

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

void Graph::destinationsFrom(Vertex* source)
{
	this->BFS(source);

	std::sort(_nodes.begin(), _nodes.end(), [](Vertex* first, Vertex* second) 
	{
		return (first->getDistance() < second->getDistance());
	}
	);
	
	Vertex* temp;
	std::cout << "ACCESS FROM [" << source->getTag() << "] :" << std::endl;
	int i = 0;
	int length = _nodes.size();
	while (_nodes.at(i)->getDistance() != 999 && i <= length)
	{
		std::cout << _nodes.at(i++) << std::endl;
	}
}
