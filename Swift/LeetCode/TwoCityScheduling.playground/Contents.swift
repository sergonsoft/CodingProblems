class Solution {
    func twoCitySchedCost(_ costs: [[Int]]) -> Int {
        let a = costs
            .sorted(by: { $0[0] - $0[1] < $1[0] - $1[1] })

        let n = costs.count/2
        
        var sum = 0
        for i in 0..<n {
            sum += (a[i][0] + a[n+i][1])
        }
        return sum
    }
}

func test(_ expected:Int, _ actual:Int) {
    assert(expected == actual, "expected: \(expected), but actual: \(actual)")
}

let s = Solution()
var costs = [[259,770],[448,54],[926,667],[184,139],[840,118],[577,469]]
test(1859, s.twoCitySchedCost(costs))

costs = [[10,20],[30,200],[400,50],[30,20]]
test(110, s.twoCitySchedCost(costs))

costs = [[515,563],[451,713],[537,709],[343,819],[855,779],[457,60],[650,359],[631,42]]
test(3086, s.twoCitySchedCost(costs))


