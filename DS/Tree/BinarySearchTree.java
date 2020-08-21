package DS.Tree;

public class BinarySearchTree<T extends Comparable<T>> {
    private TreeNode<T> root;

    //NOTE: for every complexity that I wrote here,
    //      In case the tree is degenerated, automatically,
    //      the complexity becomes O(N) because of equivalence to linked list complexity
    //      @author: Segev Burstein Segev608@gmail.com

    //region Constructors
    //Default constructor
    public BinarySearchTree() {
        root = null;
    }

    //Value constructor - Initialize root
    public BinarySearchTree(T value) {
        root = new TreeNode<>(value);
    }
    //endregion

    //region public methods
    // our mission is use the tree correctly and apply (insert/delete/search) on
    // the tree, by using the private methods
    // we are able to use recursion in order to find the
    // correct place/node in the tree.
    // mainly, API for user

    /**
     * for N elements in the tree
     * Complexity: O(log(N))
     *
     * @param value to insert
     */
    public void insert(T value) {
        root = insert(root, value);
    }

    /**
     * for N elements in the tree
     * Complexity: O(log(N))
     *
     * @param value to search
     * @return whether the value found or not
     */
    public boolean search(T value) {
        return search(root, value);
    }

    /**
     * find the node and retrieve a reference
     * same complexity as normal search
     *
     * @param value search after
     * @return searched node
     */
    public TreeNode<T> find(T value) {
        if (search(value)) return find(root, value);
        else return null; //does not exists in the tree
    }

    /**
     * There are 3 cases:
     * - node(Value) has no childes -> just delete it
     * - node(Value) has 1 child -> node(Value) <= child
     * - node(Value) has 2 children ->
     * {
     * 1.1) find successor(node)
     * 1.2) replace with successor(node)
     * 1.3) delete successor(node)
     * }
     *
     * @param value
     */
    public void delete(T value) {
        //Initializations
        int counter = 0;
        TreeNode<T> current = find(value); // receives the node from tree
        if(current == null) return; // in case the value was not found - exit
        T currentV = current.getValue();
        T childV;
        TreeNode<T> r = current.getRight();
        TreeNode<T> l = current.getLeft();

        if (r != null) counter++;
        if (l != null) counter++;

        switch (counter) {
            case 0: // no children
                // climb to it parent and set it's node to null
                current = parent(current.getValue());
                if (r != null && r.getValue() == currentV)
                    current.setRight(null);
                else
                    current.setLeft(null);
                break;
            case 1: // one children
                if (r != null) {
                    childV = r.getValue();
                    current.setRight(null); // take child's value and delete it
                } else {
                    childV = l.getValue();
                    current.setLeft(null);
                }
                current.setValue(childV);
                break;
            case 2: // two children
                TreeNode<T> successor = successor(currentV);
                childV = successor.getValue();
                delete(childV);
                current.setValue(childV);
                break;
        }
    }

    public void inOrder() {
        inOrder(root);
    }

    public void preOrder() {
        preOrder(root);
    }

    public void postOrder() {
        postOrder(root);
    }

    public TreeNode<T> getRoot() {
        return root;
    }
    //endregion

    //region private functions
    private TreeNode<T> insert(TreeNode<T> node, T value) {
        if (node == null) return new TreeNode<>(value);

        // in case the value is equal to an existing node
        // do not insert it - already exists.
        if (value.compareTo(node.getValue()) == 0)
            return node;

        // in case the value is greater - go right
        if (value.compareTo(node.getValue()) > 0)
            node.setRight(insert(node.getRight(), value));
        else // go left
            node.setLeft(insert(node.getLeft(), value));

        return node;
    }

    private boolean search(TreeNode<T> node, T value) {
        // in case we reached null - we passed full route and did not
        // find it - false
        if (node == null) return false;

        // in case we find a match - the value is inside the tree!
        if (node.getValue() == value) return true;

        // because of we only need to find the value once
        // apply 'OR' between the function calls
        return search(node.getRight(), value) || search(node.getLeft(), value);
    }

    private TreeNode<T> find(TreeNode<T> node, T value) {
        //has the same value - node found
        if (node.getValue() == value) return node;

        //bigger value -> go right
        if (value.compareTo(node.getValue()) > 0)
            return find(node.getRight(), value);
        else // go left
            return find(node.getLeft(), value);
    }


    //endregion

    //region Queries

    /**
     * finds the parent of a node in the tree (i.e. previous node)
     * Complexity: O(log(N))
     *
     * @param value the 'son' value
     * @return reference to the parent node
     */
    public TreeNode<T> parent(T value) {
        return parent(root, value);
    }

    private TreeNode<T> parent(TreeNode<T> root, T value) {
        if (root == null) return null; // could not find parent

        //prevention from accessing null node functions
        if (root.getRight() == null && root.getLeft() != null) {
            if (root.getLeft().getValue() == value) return root;

        } else if (root.getLeft() == null && root.getRight() != null) {
            if (root.getRight().getValue() == value) return root;

            //last case - the value is left/right son
        } else if (root.getLeft().getValue() == value || root.getRight().getValue() == value)
            return root;

        // the 'son' node is greater then current node -> search his parent right
        if (value.compareTo(root.getValue()) > 0)
            return parent(root.getRight(), value);
        else // search parent left
            return parent(root.getLeft(), value);
    }

    public TreeNode<T> maximum() {
        return maximum(root);
    }

    private TreeNode<T> maximum(TreeNode<T> node) {
        if (node.getRight() == null) return node;
        // the maximum value available in the most right node
        return maximum(node.getRight());
    }

    public TreeNode<T> minimum() {
        return minimum(root);
    }

    private TreeNode<T> minimum(TreeNode<T> node) {
        if (node.getLeft() == null) return node;
        // the minimum value available in the most left node
        return minimum(node.getLeft());
    }

    public TreeNode<T> successor(T value) {
        return successor(find(value));
    }

    /**
     * the function returns the next value in Inorder traversal
     *
     * @param node comes before his successor
     * @return successor node
     */
    private TreeNode<T> successor(TreeNode<T> node) {
        if(maximum() == node) return null; // this node has no successor
        if (node.getRight() != null)
            // returns the minimum node in the right sub-tree
            return minimum(node.getRight());
        // in case no right sub-tree exists, there need to climb up the
        // tree and find the node that becomes left node to someone
        TreeNode<T> p = parent(node.getValue());
        // condition to stay inside loop: 1) current node never become null
        //                                2) current node still right to his parent
        while (p != null && node == p.getRight()) {
            // climb up
            node = p;
            p = parent(node.getValue());
        }
        return p;
    }

    public TreeNode<T> predecessor(T value) {
        return predecessor(find(value));
    }

    /**
     * the function returns the previous value in Inorder traversal
     *
     * @param node comes after his predecessor
     * @return predecessor node
     */
    private TreeNode<T> predecessor(TreeNode<T> node) {
        if(minimum() == node) return null; // this node has no predecessor
        if (node.getLeft() != null)
            //returns the maximum node in the left sub-tree
            return maximum(node.getLeft());

        // in case no left sub-tree exists, there need to climb up the
        // tree and find the node that becomes right node to someone
        TreeNode<T> p = parent(node.getValue());
        while (p != null && node == p.getLeft()) {
            node = p;
            p = parent(node.getValue());
        }
        return p;
    }

    //endregion

    //region display
    private void inOrder(TreeNode<T> node) {
        if (node == null) return;
        inOrder(node.getLeft());
        System.out.print(node.getValue() + " ");
        inOrder(node.getRight());
    }

    private void preOrder(TreeNode<T> node) {
        if (node == null) return;
        System.out.print(node.getValue() + " ");
        preOrder(node.getLeft());
        preOrder(node.getRight());
    }

    private void postOrder(TreeNode<T> node) {
        if (node == null) return;
        postOrder(node.getLeft());
        postOrder(node.getRight());
        System.out.print(node.getValue() + " ");
    }
    //endregion
}
