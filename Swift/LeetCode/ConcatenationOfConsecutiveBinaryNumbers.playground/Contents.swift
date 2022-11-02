/**
 Given an integer n, return the decimal value of the binary string formed by concatenating the binary representations of 1 to n in order, modulo 10^9 + 7.
 
 Example 1:

 Input: n = 1
 Output: 1
 Explanation: "1" in binary corresponds to the decimal value 1.
 
 
 Example 2:

 Input: n = 3
 Output: 27
 Explanation: In binary, 1, 2, and 3 corresponds to "1", "10", and "11".
 After concatenating them, we have "11011", which corresponds to the decimal value 27.
 
 
 Example 3:

 Input: n = 12
 Output: 505379714
 Explanation: The concatenation results in "1101110010111011110001001101010111100".
 The decimal value of that is 118505380540.
 After modulo 10^9 + 7, the result is 505379714.
 
 Constraints:

 1 <= n <= 10^5
 */

import Foundation

class Solution {
    let M = (Int(pow(Double(10), Double(9)))+7)

    func concatenatedBinary(_ n: Int) -> Int {
        var res = 0
        for i in 1..<(n+1) {
            res = (res << (i.bitWidth-i.leadingZeroBitCount) | i) % M
        }
        
        return res
    }
}

// Tests

let params = [1:1, 3:27, 12:505379714]

let s = Solution()

s.concatenatedBinary(17)

assert(params.map({n,expected in
    let result = s.concatenatedBinary(n)
    
    if result != expected {
        print("With \(n) result \(result) != \(expected)")
        return false
    }
    
    return true
}).reduce(true, {
    $0 && $1
}))

print("Solved!")
