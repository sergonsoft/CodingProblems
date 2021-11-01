import XCTest

class Solution {
    func decodeString(_ s: String) -> String {
        var result = ""
        var i = s.startIndex
        
        while i != s.endIndex {
            let c = s[i]
            var offset = 1

            if c.isNumber {
                let decodedPattern:String
                (decodedPattern, offset) = decodePattern(String(s[i..<s.endIndex]))
                result.append(decodedPattern)
            } else {
                result.append(c)
            }
            
            i = s.index(i, offsetBy: offset)
        }
        
        return result
    }
    
    private func decodePattern(_ s: String) -> (String, Int) {
        
        var times = 0
        var i = s.startIndex
        var patternLenght = 0

        repeat {
            if s[i].isWholeNumber {
                times = times * 10 + s[i].wholeNumberValue!
            }
            
            patternLenght += 1
            i = s.index(after: i)
        } while s[i] != "["
        
        var pattern = ""

        // skip the "[" character
        patternLenght += 1
        i = s.index(after: i)

        
        while i != s.endIndex {
            let c = s[i]
            var offset = 1
            patternLenght += 1

            if c.isWholeNumber {
                let (decodedPattern, subpatternLenght) = decodePattern(String(s[i..<s.endIndex]))
                pattern.append(decodedPattern)
                patternLenght += subpatternLenght - 1
                offset = subpatternLenght
            } else if c == "]" {
                break
            } else {
                pattern.append(c)
            }
            
            i = s.index(i, offsetBy: offset)
        }
        
        let resultDecodedPattern = String(repeating: pattern, count: times)
        return (resultDecodedPattern, patternLenght)
    }
}

class TestSolution: XCTestCase {
    
    let s = Solution()

    func testExample0() {
        let input = "abc"
        let actual = s.decodeString(input)
        let expected = "abc"
        
        XCTAssert(actual == expected, "Input: \(input) Actual: \"\(actual)\" vs Expected: \"\(expected)\"")
    }

    
    func testExample1() {
        let input = "3[a]2[bc]"
        let actual = s.decodeString(input)
        let expected = "aaabcbc"
        
        XCTAssert(actual == expected, "Input: \(input) Actual: \"\(actual)\" vs Expected: \"\(expected)\"")
    }

    func testExample2() {
        let input = "3[a2[c]]"
        let actual = s.decodeString(input)
        let expected = "accaccacc"
        
        XCTAssert(actual == expected, "Input: \(input) Actual: \"\(actual)\" vs Expected: \"\(expected)\"")
    }
    
    func testExample3() {
        let input = "2[abc]3[cd]ef"
        let actual = s.decodeString(input)
        let expected = "abcabccdcdcdef"
        
        XCTAssert(actual == expected, "Input: \(input) Actual: \"\(actual)\" vs Expected: \"\(expected)\"")
    }
    
    func testExample4() {
        let input = "abc3[cd]xyz"
        let actual = s.decodeString(input)
        let expected = "abccdcdcdxyz"
        
        XCTAssert(actual == expected, "Input: \(input) Actual: \"\(actual)\" vs Expected: \"\(expected)\"")
    }
    
    func testExample5() {
        let input = "3[2[c]]"
        let actual = s.decodeString(input)
        let expected = "cccccc"
        
        XCTAssert(actual == expected, "Input: \(input) Actual: \"\(actual)\" vs Expected: \"\(expected)\"")
    }

    func testExample6() {
        let input = "3[z]2[2[y]pq4[2[jk]e1[f]]]ef"
        let actual = s.decodeString(input)
        let expected = "zzzyypqjkjkefjkjkefjkjkefjkjkefyypqjkjkefjkjkefjkjkefjkjkefef"
        
        XCTAssert(actual == expected, "Input: \(input) Actual: \"\(actual)\" vs Expected: \"\(expected)\"")
    }

    
    
    
    
}

TestSolution.defaultTestSuite.run()

// 3[z]2[2[y]pq4[2[jk]e1[f]]]ef

//print(Solution().decodeString("2[2[y]pq4[2[jk]e1[f]]]"))
//print(Solution().decodeString("2[y]pq4[2[jk]e1[f]]"))
//print(Solution().decodeString("4[2[jk]e]"))
