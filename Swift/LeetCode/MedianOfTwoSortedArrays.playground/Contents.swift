class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let nums1Count = nums1.count
        let nums2Count = nums2.count
        let totalelementsCount = nums1Count + nums2Count
        let evenMedian = 0 == (totalelementsCount) % 2
        let medianIndex = totalelementsCount / 2


        var medianValue = 0
        var previousMedianValue = 0

        var num1i = 0, num2i = 0, mediani = 0
        while mediani <= medianIndex {
            let num1Item = num1i < nums1Count ? nums1[num1i] : Int.max
            let num2Item = num2i < nums2Count ? nums2[num2i] : Int.max

            previousMedianValue = medianValue

            if  num1Item < num2Item {
                medianValue = num1Item
                num1i += 1
            }
            else {
                medianValue = num2Item
                num2i += 1
            }
            
            mediani += 1
        }
        
        return evenMedian ? (Double(previousMedianValue + medianValue) / 2.0) : Double(medianValue)
    }
}

func test<T:Equatable>(name:String, _ actual:T, _ expected:T) {
    assert(expected == actual, "\(name): Expected: \(expected), Actual: \(actual)")
}

let s = Solution()

// Example 1:

//Input:
var nums1:[Int] = [1,3]
var nums2:[Int] = [2]
// Output:
var expectedResult:Double = 2.00000
//Explanation: merged array = [1,2,3] and median is 2.

test(name: "Example 1", s.findMedianSortedArrays(nums1, nums2), expectedResult)

// Example 2:

//Input:
nums1 = [1,2]
nums2 = [3,4]
//Output:
expectedResult = 2.50000
//Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.

test(name: "Example 2", s.findMedianSortedArrays(nums1, nums2), expectedResult)

print("OK")
