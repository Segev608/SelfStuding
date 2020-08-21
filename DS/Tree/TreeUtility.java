package DS.Tree;
import java.lang.Math;

public class TreeUtility {

    /**
     * @param t Tree root
     * @return checks that all the values in the tree are even
     */
    public static boolean evenNode(TreeNode<Integer> t){
        if(t.getLeft() == null && t.getRight() == null)
            return (t.getValue() > 0 && t.getValue() % 2 == 0);
        else if(t.getRight() != null && t.getLeft() != null)
            return (t.getValue() > 0 && t.getValue() % 2 == 0) && evenNode(t.getLeft()) && evenNode(t.getRight());
        else if(t.getRight() == null)
            return (t.getValue() > 0 && t.getValue() % 2 == 0) && evenNode(t.getLeft());
        else
            return (t.getValue() > 0 && t.getValue() % 2 == 0) && evenNode(t.getRight());
    }

    /**
     * @param t Tree root
     * @return number of nodes in the tree
     */
    public static int countNodes(TreeNode<Integer> t){
        if(t == null)
            return 0;
        return 1+countNodes(t.getRight())+countNodes(t.getLeft());
    }

    /**
     * @param t Tree root
     * @return longest route from root to leaf
     */
    public static int treeHeight(TreeNode<Integer> t){
        if(t == null)
            return -1;
        return Math.max(treeHeight(t.getLeft()) + 1, treeHeight(t.getRight()) + 1);
    }

    public static boolean rootLeafRoute(TreeNode<Integer> t, int sum){
        if(t == null) return false;
        if(sum - t.getValue() == 0 && t.getLeft() == null && t.getRight() == null)
            return true;
        return rootLeafRoute(t.getRight(), sum - t.getValue()) || rootLeafRoute(t.getLeft(), sum - t.getValue());
    }

    //side function for printRootLeafRoutes method
    public static int log2(int N){
        //it's known that: [we're using log10 because it's in the language]
        //log_a(b) = log_10(b) / log_10(a);
        return (int)Math.ceil(Math.log10(N) / Math.log10(2));
    }

    /**
     * @param t Tree root
     * @return number of routes - 1
     */
    public static int countRoutes(TreeNode<Integer> t){
        if(t == null) return 0;
        if(t.getLeft() != null && t.getRight() != null) // has 2 childes
            return 1 + countRoutes(t.getRight()) + countRoutes(t.getLeft());
        else if(t.getLeft() == null && t.getRight() != null)
            return countRoutes(t.getRight());
        else
            return countRoutes(t.getLeft());
    }




}
