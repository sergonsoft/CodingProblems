func getInitialAdvertisingAmount() -> Int {
    return 5
}

func likedTheAdd(_ persons:Int) -> Int {
    return persons / 2
}

func getViralityCoefficient() -> Int {
    return 3
}

func viralAdvertising(n: Int) -> Int {
    let initialSeen = getInitialAdvertisingAmount()
    var totalLiked = 0
    
    var todaySeen = initialSeen
    for _ in 1...n {
        let todayLiked = likedTheAdd(todaySeen)
        totalLiked += todayLiked
        let tomorrowSeen =  todayLiked * getViralityCoefficient()
        todaySeen = tomorrowSeen
    }
    
    return totalLiked
}


[(5,24), (3,9)].map { (n,r) in
    let res = viralAdvertising(n: n)
    assert(res == r, "for \(n) the res: \(res) doesn't equal expected \(r)")
}
