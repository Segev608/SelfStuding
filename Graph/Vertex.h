#pragma once
#include <vector>
#include <string>
#include <algorithm>
#include <iostream>


enum Color{BLACK, GRAY, WHITE};

class Vertex
{
private:
	std::vector<Vertex*> _next;
	std::string _tag;
	int _vertexCount;
	Color _color;
	Vertex* _previous;
	int _distanceFrom;
public:
	Vertex(std::string); // regular constructor
	//~Vertex(); //destructor
	void connect(Vertex* &val);
	void disconnect(Vertex* &val);
	void deleteVertex(Vertex* &val);

	std::string getTag() const;
	std::vector<Vertex*> getNeighbors() const;
	Color getColor() const;
	int getDistance() const;
	void setColor(Color c);
	void setPrevious(Vertex* &v);
	void setDistance(int v);

	void print();
	friend std::ostream& operator<<(std::ostream& out, Vertex* other);
};


Vertex::Vertex(std::string t)
{
	_tag = t;
	_vertexCount = NULL;
	_color = Color::WHITE;
	_distanceFrom = -1;
	_previous = nullptr;
}

void Vertex::connect(Vertex* &val)
{
	if (val != nullptr)
		_next.push_back(val);
	_vertexCount++;
}

std::string Vertex::getTag() const
{
	return _tag;
}

void Vertex::disconnect(Vertex* &val)
{
	int count = -1;
	std::any_of(_next.begin(), _next.end(), [&count, val](Vertex* p)
	{
		if (p->getTag() == val->getTag())
			return true;
		count++;
		return false;
	}
	);

	if (count != -1) 
		_next.erase(_next.begin() + count);
}

std::ostream& operator<<(std::ostream& out, Vertex* other)
{
	out << "[" << other->getTag() << "] ->" << "cost: " << other->getDistance() <<std::endl;
	return out;
}

void Vertex::print()
{
	std::cout << this << std::endl;
	std::cout << "Connectd to:" << std::endl;
	for (Vertex* item : _next)
	{
		std::cout << item;
	}
}

void Vertex::deleteVertex(Vertex* &val)
{
	val->_next.clear();
	val = nullptr;
}

void Vertex::setColor(Color c)
{
	_color = c;
}

void Vertex::setPrevious(Vertex* &v)
{
	_previous = v;
}

void Vertex::setDistance(int v)
{
	_distanceFrom = v;
}

std::vector<Vertex*> Vertex::getNeighbors() const
{
	return _next;
}

Color Vertex::getColor() const
{
	return _color;
}

int Vertex::getDistance() const 
{
	return _distanceFrom;
}


