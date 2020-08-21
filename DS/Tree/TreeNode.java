package DS.Tree;

public class TreeNode<T extends Comparable<T>> {
    private T value;
    private TreeNode<T> left;
    private TreeNode<T> right;

    //region Constructors
    //Default constructor
    public TreeNode() {
        left = null;
        right = null;
    }

    //Value Constructor
    public TreeNode(T value) {
        this.value = value;
        left = null;
        right = null;
    }

    public TreeNode(T value, TreeNode<T> l, TreeNode<T> r) {
        this(value);
        left = l;
        right = r;
    }
    //endregion

    //region Getters
    public T getValue() {
        return value;
    }

    public TreeNode<T> getLeft() {
        return left;
    }

    public TreeNode<T> getRight() {
        return right;
    }
    //endregion

    //region Setters
    public void setValue(T value) {
        this.value = value;
    }

    public void setLeft(TreeNode<T> l) {
        left = l;
    }

    public void setRight(TreeNode<T> r) {
        right = r;
    }
    //endregion

    //region Conditions
    public boolean hasLeft() {
        return right == null;
    }

    public boolean hasRight() {
        return left == null;
    }
    //endregion


}
