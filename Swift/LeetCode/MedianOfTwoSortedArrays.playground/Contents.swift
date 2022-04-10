import XCTest

struct TwoSortedArraysTestData {
    var num1: [Int]
    var num2: [Int]
    var result: Double
}

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

class MedianOfTwoSortedArraysTest: XCTestCase {
    let testData: [TwoSortedArraysTestData] = [
        //Explanation: merged array = [1,2,3] and median is 2.
        TwoSortedArraysTestData(num1: [1,3], num2: [2], result: 2.00000),
        //Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
        TwoSortedArraysTestData(num1: [1,2], num2: [3,4], result: 2.50000)
    ]

    let s = Solution()

    func testFor() {
        measure {
            for td in testData {
                XCTAssertEqual(s.findMedianSortedArrays(td.num1, td.num2), td.result)
            }
        }
    }
    
    func testForEach() {
        measure {
            testData.forEach { td in
                XCTAssertEqual(s.findMedianSortedArrays(td.num1, td.num2), td.result)
            }
        }
    }

    func testMap() {
        measure {
            testData.map { td in
                XCTAssertEqual(s.findMedianSortedArrays(td.num1, td.num2), td.result)
            }
        }
    }
}


MedianOfTwoSortedArraysTest.defaultTestSuite.run()
