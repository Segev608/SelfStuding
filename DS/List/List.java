package DS.List;

public class List<T> {
    private Node<T> first; // class List attribute

    public List() {
        this.first = null;
    } // class List constructor

    public Node<T> getFirst() {
        return this.first;
    } // getFirst

    public void insert(T value){
        if(first == null)
            first = new Node<T>(value);
        else{
            Node<T> temp = this.first;
            while(temp.getNext() != null)
                temp = temp.getNext();
            temp.setNext(new Node<T>(value));
        }
    }

    public int length(){
        if(first == null)
            return -1;

        int count = 0;
        Node<T> temp = this.first;
        while(temp != null){
            count++;
            temp = temp.getNext();
        }
        return count;
    }

    // delete first element
    public void deleteFirst(){
        first = first.getNext();
    }

    // delete last element
    public void deleteLast(){
        Node<T> temp = first;
        while(temp.getNext().getNext() != null)
            temp = temp.getNext();
        temp.setNext(null);
    }

    // delete specific element
    public int delete(T value){
        Node<T> temp = first;
        while(temp.getNext().getData() != value && temp != null)
              temp = temp.getNext();
        if(temp == null) // if the element was not found
            return -1;
        temp.setNext(temp.getNext().getNext());
        return 1;
    }

    public boolean search(T value){
        Node<T> temp = first;
        while(temp != null) {
            if (temp.getData() == value)
                return true;
            temp = temp.getNext();
        }
        return false;
    }

    public boolean isEmpty() {
        return first == null;
    }

    @Override
    public String toString() {
        String data = "";
        Node<T> temp = first;
        while(temp != null){
            data = data.concat(temp.getData() + " -> ");
            temp = temp.getNext();
        }
        return data;
    }


}