
/**
 * Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right,
 * level by level).
 *
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Solution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard root != nil else {
            return []
        }
        
        var level = 0
        var allNodes:[[TreeNode?]] = []
        allNodes.append([root])
        
        while allNodes.count == level + 1 {
            let nextLevel = level + 1
            for node in allNodes[level] {
                if node?.left != nil {
                    addNode(&allNodes, nextLevel, node?.left)
                }
                
                if node?.right != nil {
                    addNode(&allNodes, nextLevel, node?.right)
                }
            }
            
            level = nextLevel
        }
        
        return treeNodes2Int(allNodes)
    }
    
    fileprivate func addNode( _ nodes:inout [[TreeNode?]], _ level:Int, _ node:TreeNode?) {
        if nodes.count != level + 1 {
            nodes.append([node])
        }
        else {
            nodes[level].append(node)
        }
    }
    
    fileprivate func treeNodes2Int(_ allNodes:[[TreeNode?]]) -> [[Int]] {
        allNodes.map({nodes in
            return nodes.map({node in
                return node!.val
            })
        })
    }
}

/*
 Tests
 */

let s = Solution()
/*
 Test case 1
 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[9,20],[15,7]]
 */

var root:TreeNode? = TreeNode(3)
root?.left = TreeNode(9)
root?.right = TreeNode(20)
root?.right?.left = TreeNode(15)
root?.right?.right = TreeNode(7)
var output = [[3],[9,20],[15,7]]

assert(s.levelOrder(root) == output)

/*
 Test case 2
 Input: root = [1]
 Output: [[1]]
 */

root = TreeNode(1)
output = [[1]]

assert(s.levelOrder(root) == output)

/*
 Test case 3
 Input: root = []
 Output: []
 */

root = nil
output = []

assert(s.levelOrder(root) == output)

print("Solved!!!")
