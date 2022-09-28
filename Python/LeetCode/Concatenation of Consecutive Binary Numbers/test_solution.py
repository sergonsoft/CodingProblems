from solution import Solution

def test_1():
  s = Solution()
  assert s.concatenatedBinary(1) == 1

def test_3():
  s = Solution()
  assert s.concatenatedBinary(3) == 27

def test_12():
  s = Solution()
  assert s.concatenatedBinary(12) == 505379714