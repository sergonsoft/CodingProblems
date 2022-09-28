class Solution:
    def concatenatedBinary(self, n: int) -> int:
      collector = ""
      for i in range(1, n+1):
        collector += bin(i).replace("0b", "")
      
      return int(collector, 2) % (10**9+7)
        
if __name__ == "__main__":
  print(Solution().concatenatedBinary(1))
  print(Solution().concatenatedBinary(3))
  print(Solution().concatenatedBinary(12))