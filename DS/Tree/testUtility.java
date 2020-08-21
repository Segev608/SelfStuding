package DS.Tree;

import com.sun.source.tree.Tree;
import org.junit.Test;

import static org.junit.Assert.*;

public class testUtility {

    @Test
    public void testEven() {
        BinarySearchTree<Integer> t;

        //TC01: everything ok
        t = new BinarySearchTree<>();
        t.insert(4);
        t.insert(2);
        t.insert(8);
        t.insert(28);
        t.insert(14);

        assertTrue("PROBLEM", TreeUtility.evenNode(t.getRoot()));

        //TC02: problem with root
        t = new BinarySearchTree<>();
        t.insert(3);
        t.insert(2);
        t.insert(8);
        t.insert(28);
        t.insert(14);

        assertFalse("PROBLEM", TreeUtility.evenNode(t.getRoot()));

        //TC03: problem with parent with right son
        t = new BinarySearchTree<>();
        t.insert(4);
        t.insert(2);
        t.insert(8);
        t.insert(27);
        t.insert(14);

        assertFalse("PROBLEM", TreeUtility.evenNode(t.getRoot()));

        //TC04: problem with leaf && left son
        t = new BinarySearchTree<>();
        t.insert(4);
        t.insert(2);
        t.insert(8);
        t.insert(28);
        t.insert(13);

        assertFalse("PROBLEM", TreeUtility.evenNode(t.getRoot()));
    }

    @Test
    public void testCount() {
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        t.insert(4);
        t.insert(2);
        t.insert(8);
        t.insert(32);
        t.insert(1);
        t.insert(7);
        t.insert(28);
        t.insert(13);
        int length = TreeUtility.countNodes(t.getRoot());
        assertEquals("PROBLEM", 8, length);
    }

    @Test
    public void testHeight() {
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        int height;

        //TC01: height = 3
        t.insert(4);
        t.insert(2);
        t.insert(8);
        t.insert(28);
        t.insert(14);
        height = TreeUtility.treeHeight(t.getRoot());
        assertEquals("PROBLEM", 3, height);

        //TC01: height = 5
        t = new BinarySearchTree<>();
        t.insert(4);
        t.insert(2);
        t.insert(8);
        t.insert(28);
        t.insert(14);
        t.insert(15);
        t.insert(16);
        height = TreeUtility.treeHeight(t.getRoot());
        assertEquals("PROBLEM", 5, height);
    }

    @Test
    public void testRLroute() {
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        boolean value;

        //TC01: route with sum 20
        t.insert(5);
        t.insert(4);
        t.insert(8);
        t.insert(11);
        t.insert(7);
        t.insert(2);
        t.insert(13);

        value = TreeUtility.rootLeafRoute(t.getRoot(), 20);
        assertTrue("PROBLEM", value);

        //TC01: route with sum 37

        value = TreeUtility.rootLeafRoute(t.getRoot(), 37);
        assertTrue("PROBLEM", value);

        //TC01: sum does not exists

        value = TreeUtility.rootLeafRoute(t.getRoot(), 35);
        assertFalse("PROBLEM", value);
    }

    @Test
    public void testLog(){
        assertEquals("PROBLEM", 4, TreeUtility.log2(9));
    }

    @Test
    public void testRouteNum(){
        BinarySearchTree<Integer> t = new BinarySearchTree<>();
        t.insert(4);
        t.insert(2);
        t.insert(6);
        t.insert(1);
        t.insert(3);
        t.insert(5);
        t.insert(7);


        assertEquals("PROBLEM", 4, TreeUtility.countRoutes(t.getRoot()) + 1);
    }

}
