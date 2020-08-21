package DS.List;

public class Node <T> {
    private T data;
    private Node<T> nextNode;

    //Constructors1
    public Node(T data) {
        this.data = data;
    }

    //constructor2
    public Node(T data, Node<T> nextNode) {
        this.data = data;
        this.nextNode = nextNode;
    }

    //setters & getters
    public void setData(T data) {
        this.data = data;
    }

    public T getData() {
        return this.data;
    }

    public void setNext(Node<T> nextNode) {
        this.nextNode = nextNode;
    }

    public Node<T> getNext() {
        return this.nextNode;
    }

    public String toString() {
        return " " + this.data;
    }


}

