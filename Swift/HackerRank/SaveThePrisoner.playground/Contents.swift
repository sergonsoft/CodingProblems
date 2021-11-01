
func saveThePrisoner(n: Int, m: Int, s: Int) -> Int {
    // Write your code here
    let res = (s - 1 + m) % n
    return res == 0 ? n : res
}

print("Begin")

[(5, 2, 1, 2),
 (5, 2, 2, 3),
 (7, 19, 2, 6),
 (3, 7, 3, 3),
 (4, 8, 1, 4)
].map { (n, m, s, r) in
    let res = saveThePrisoner(n: n, m: m, s: s)
    assert(res == r , "(\(n), \(m), \(s)) != \(r), actual = \(res)")
}

print("End")
