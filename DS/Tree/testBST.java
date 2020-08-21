package DS.Tree;

import com.sun.source.tree.Tree;
import org.junit.Test;

import static org.junit.Assert.*;

public class testBST {
    @Test
    public void testInsert(){
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        //TC01: check insert to root
        t.insert(3);
        assertEquals(3, (int)t.getRoot().getValue());
        //TC02: check insert to left son
        t.insert(1);
        assertEquals(1, (int)t.getRoot().getLeft().getValue());
        //TC03: check insert to right son
        t.insert(15);
        assertEquals(15, (int)t.getRoot().getRight().getValue());
    }

    @Test
    public void testSearch(){
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        t.insert(5);
        t.insert(3);
        t.insert(7);
        t.insert(13);
        t.insert(6);
        t.insert(2);
        t.insert(1);
        //TC01: check value that exists in the tree
        assertTrue(t.search(13));
        //TC02: check value that does not exists in the tree
        assertFalse(t.search(8));
    }
    @Test
    public void testDelete(){
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        t.insert(5);
        t.insert(3);
        t.insert(7);
        t.insert(13);
        t.insert(6);
        t.insert(2);
        t.insert(1);

        //TC01: delete existed value - leaf
        assertTrue(t.search(1));
        t.delete(1);
        assertFalse(t.search(1));

        //TC02: delete existed value - 1 child
        assertTrue(t.search(3));
        t.delete(3);
        assertFalse(t.search(3));

        //TC03: delete existed value - 2 childes
        assertTrue(t.search(5));
        t.delete(5);
        assertFalse(t.search(5));

        //TC04: delete value that does not exists in the tree
        assertFalse(t.search(99));
        t.delete(99);
        assertFalse(t.search(99));
    }

    @Test
    public void testParent(){
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        t.insert(5);
        t.insert(3);
        t.insert(7);
        t.insert(13);
        t.insert(6);
        t.insert(2);
        t.insert(1);

        assertEquals(7, (int)t.parent(13).getValue());
        assertEquals(7, (int)t.parent(6).getValue());
        assertNull(t.parent(5));
    }

    @Test
    public void testSuccessor(){
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        t.insert(5);
        t.insert(3);
        t.insert(7);
        t.insert(13);
        t.insert(6);
        t.insert(2);
        t.insert(1);

        //TC01: find for root
        assertEquals(6, (int)t.successor(5).getValue());
        //TC02: find for maximum leaf
        assertNull(t.successor(13));
        //TC02: find for ordinary leaf
        assertEquals(7, (int)t.successor(6).getValue());
    }

    @Test
    public void testPredecessor(){
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        t.insert(5);
        t.insert(3);
        t.insert(7);
        t.insert(13);
        t.insert(6);
        t.insert(2);
        t.insert(1);

        //TC01: find for root
        assertEquals(3, (int)t.predecessor(5).getValue());
        //TC02: find for minimum leaf
        assertNull(t.predecessor(1));
        //TC02: find for ordinary leaf
        assertEquals(7, (int)t.predecessor(13).getValue());
    }
}
