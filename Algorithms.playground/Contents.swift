import UIKit

//https://leetcode.com/problems/remove-duplicates-from-sorted-array/
func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard nums.count > 0 else { return 0 }
    var index = 0
    for i in 1..<nums.count {
        if nums[i] != nums[index] {
            index += 1
            nums[index] = nums[i]
        }
    }
    nums.removeSubrange((index+1)...) //Optional
    return index + 1
}
var nums = [0,0,1,1,1,2,2,3,3,4]
//var nums = [Int]()
print(removeDuplicates(&nums))

//https://leetcode.com/problems/degree-of-an-array/
func findShortestSubArray(_ nums: [Int]) -> Int {
    var degree = 0, minLength = Int.max
    var frequencies = [Int: Int]()
    var firstOccurence = [Int: Int]()
    var lastOccurence = [Int: Int]()
    for (index, num) in nums.enumerated() {
        let newFreq = frequencies[num, default: 0] + 1
        if newFreq == 1 {
            firstOccurence[num] = index
        }
        lastOccurence[num] = index
        frequencies[num] = newFreq
        if newFreq >= degree {
            let currLength = (lastOccurence[num]! - firstOccurence[num]! + 1)
            if newFreq == degree {
                if currLength < minLength {
                    minLength = currLength
                    degree = newFreq
                }
            }
            else {
                minLength = currLength
                degree = newFreq
            }
        }
    }
    return minLength
}
print(findShortestSubArray([2,2,7,8,9,2,3,1,4,1,1]))
print(findShortestSubArray([1, 2, 2, 3, 1]))

//https://leetcode.com/problems/maximum-subarray/
func maxSubArray(_ nums: [Int]) -> Int {
    var currMax = nums[0], totalMax = nums[0]
    for i in 1..<nums.count {
        currMax = max(currMax + nums[i], nums[i])
        totalMax = max(totalMax, currMax)
    }
    return totalMax
}
print(maxSubArray([-2,1,-3,4,-1,2,1,-5,4]))

//https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/
func maxProfit2(_ prices: [Int]) -> Int {
    guard prices.count > 1 else {
        return 0
    }
    var totalProfit = 0
    for i in 1..<prices.count {
        let currProf = prices[i] - prices[i-1]
        totalProfit += max(currProf, 0)
    }
    return totalProfit
}
print(maxProfit2([7,1,5,3,6,4]))

//https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
func maxProfit(_ prices: [Int]) -> Int {
    var minPrice = Int.max
    var maxProfit = 0
    for price in prices {
        if price < minPrice {
            minPrice = price
        } else if (price - minPrice) > maxProfit {
            maxProfit = price - minPrice
        }
    }
    return maxProfit
}

print(maxProfit([7,1,5,3,6,4]))
print(maxProfit([7,6,4,3,1]))

//https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/
func twoSumSorted(_ numbers: [Int], _ target: Int) -> [Int] {
    var res = [Int]()
    var p = 0, q = numbers.count - 1
    while p <= q {
        let sum = numbers[p] + numbers[q]
        if sum > target {
            q -= 1
        }
        else if sum < target {
            p += 1
        }
        else {
            res = [p+1, q+1]
            break
        }
    }
    return res
}

print(twoSumSorted([-3, 3, 4, 90], 0))
print(twoSumSorted([-1, 0], -1))
print(twoSumSorted([2, 5, 7, 15], 9))

//https://leetcode.com/problems/two-sum/
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var res = [Int]()
    var dict = [Int: Int]()
    for (index, num) in nums.enumerated() {
        let req = target - num
        if let indexFirst = dict[req] {
            res = [indexFirst, index]
            break
        }
        dict[num] = index
    }
    return res
}


print(twoSum([2, 7, 11, 15], 9))

//https://www.hackerrank.com/challenges/fair-rations/problem
func fairRations(B: [Int]) -> Int {
    var arr = B
    var count = 0
    for i in 0..<arr.count-1 {
        if arr[i] % 2 != 0 {
            arr[i] += 1
            arr[i+1] += 1
            count += 2
        }
    }
    if arr[arr.count-1] % 2 != 0 {
        return -1
    }
    return count
}

print(fairRations(B: [1, 2]))
print(fairRations(B: [4, 5, 6, 7]))

//https://www.hackerrank.com/challenges/lisa-workbook/problem
func workbook(n: Int, k: Int, arr: [Int]) -> Int {
    var res = 0
    var startPage = 1
    var chapPages = 0
    for i in arr {
        chapPages = (i % k == 0) ? (i / k) : (i / k + 1)
        for j in 0..<chapPages {
            let pageNum = startPage + j
            let firstQ = (j*k)+1
            let lastQ = (j*k) + k < i ? (j*k) + k : i
            if pageNum >= firstQ  && pageNum <= lastQ {
                res += 1
            }
        }
        startPage += chapPages
    }
    return res
}

print(workbook(n: 5, k: 3, arr: [4, 2, 6, 1, 10]))

//Anagram - Booking
func listAnagram(anagrams: [String]) -> [String] {
    var results = [String]()
    for i in 0..<anagrams.count {
        var res = anagrams[i]
        var hasAnagram = false
        for j in i+1..<anagrams.count {
            if isAnagram(s1: anagrams[i], s2: anagrams[j]) {
                res += ", \(anagrams[j])"
                hasAnagram = true
            }
        }
        if hasAnagram {
            results.append(res)
        }
    }
    return results.sorted()
}

func isAnagram(s1: String, s2: String) -> Bool {
    let compactS1 = String(s1.filter { !" \n\t\r".contains($0) })
    let compactS2 = String(s2.filter { !" \n\t\r".contains($0) })
    
    let count1 = NSCountedSet()
    for c in compactS1 {
        count1.add(c)
    }
    let count2 = NSCountedSet()
    for c in compactS2 {
        count2.add(c)
    }
    return count1 == count2
}

let anagrams = ["dirty room", "tomato", "dormitory", "asas", "ootmat"]
print(listAnagram(anagrams: anagrams))

//https://www.hackerrank.com/challenges/anagram/problem
func anagram(s: String) -> Int {
    if s.count % 2 != 0 {
        return -1
    }
    
    let halfLenght = s.index(s.startIndex, offsetBy: (s.count/2))
    let s1 = s[..<halfLenght]
    let s2 = s[halfLenght...]
    
    var count1 = [Character: Int]()
    for ch in s1 {
        count1[ch] = count1[ch] != nil ? count1[ch]! + 1 : 1
    }
    
    var count2 = [Character: Int]()
    for ch in s2 {
        if let c1 = count1[ch] {
            count1[ch] = c1 - 1
        }
        else {
            count2[ch] = count2[ch] != nil ? count2[ch]! + 1 : 1
        }
    }
    
    var diff  = 0
    for (_, count) in count1 {
        diff += abs(count)
    }
    for (_, count) in count2 {
        diff += abs(count)
    }
    
    return diff/2
}

print(anagram(s: "abc"))
print(anagram(s: "aaabbb"))
print(anagram(s: "xaxbbbxx"))

//https://www.hackerrank.com/challenges/manasa-and-stones/problem
func stones(n: Int, a: Int, b: Int) -> [Int] {
    var res = [Int]()
    var num = (n-1) * min(a, b)
    while num <= (n-1) * (max(a,b)) {
        res.append(num)
        num += abs(a-b) == 0 ? a : abs(a-b)
    }
    return res
}
print(stones(n: 4, a: 10, b: 100))
print(stones(n: 3, a: 1, b: 2))

//https://www.hackerrank.com/challenges/halloween-sale/problem
func howManyGames(p: Int, d: Int, m: Int, s: Int) -> Int {
    // Return the number of games you can buy
    var total = 0
    var money = s
    var curRate = p
    while money - curRate >= 0 {
        money -= curRate
        if curRate - d > m {
            curRate -= d
        }
        else {
            curRate = m
        }
        total += 1
    }
    return total
}

print(howManyGames(p: 16, d: 2, m: 1, s: 9981))
print(howManyGames(p: 20, d: 3, m: 6, s: 85))


func prodOfHighestThree(ar: [Int]) -> Int {
    let resStr = ar.map{String($0)}.joined(separator: " ")
    var prod = 1
    print(resStr)
    if ar.count < 3 {
        print("-1")
    }
    else {
        let sorted = ar.sorted(by: >)
        
        for i in 0...2 {
            prod *= abs(sorted[i])
        }
    }
    
    return prod
}

print(prodOfHighestThree(ar: [3, 8, 1, 2, 5]))

//https://www.hackerrank.com/challenges/jim-and-the-orders/problem
func jimOrders(orders: [[Int]]) -> [Int] {
    var serveTimes = [Int: Int]()
    for (index, order) in orders.enumerated() {
        let serveTime = order[0] + order[1]
        serveTimes[index + 1] = serveTime
    }
    let sortedKeys = serveTimes.values.sorted()
    var result = [Int]()
    for key in sortedKeys {
        result.append(serveTimes[key]!)
    }
    return result
}

//https://www.hackerrank.com/challenges/library-fine/problem
func libraryFine(d1: Int, m1: Int, y1: Int, d2: Int, m2: Int, y2: Int) -> Int {
    var fine = 0
    if y1 > y2 {
        fine = 10000
    } else if y1 == y2 {
        if m1 > m2 {
            fine = (m1 - m2) * 500
        } else if m1 == m2 {
            if d1 > d2 {
                fine = (d1 - d2) * 15
            }
        }
    }
    return fine
}

print(libraryFine(d1: 2, m1: 7, y1: 1014, d2: 1, m2: 1, y2: 1015))

//https://www.hackerrank.com/challenges/strange-code/problem
func strangeCounter(t: Int) -> Int {
    var t = t
    var rem = 3
    while t > rem {
        t = t - rem
        rem *= 2
    }
    return (rem - t + 1)
}

print(strangeCounter(t: 1000000000000))

//https://www.hackerrank.com/challenges/equal-stacks/problem
func equalStacks(h1: [Int], h2: [Int], h3: [Int]) -> Int {
    var s1 = Array(h1.reversed())
    var s2 = Array(h2.reversed())
    var s3 = Array(h3.reversed())
    
    var sumH1 = h1.reduce(0, +)
    var sumH2 = h2.reduce(0, +)
    var sumH3 = h3.reduce(0, +)
    
    while !(sumH1 == sumH2 && sumH1 == sumH3) {
        if sumH1 == 0 || sumH2 == 0 || sumH3 == 0 {
            sumH1 = 0
            break
        }
        if sumH1 > sumH2 && sumH1 > sumH3 {
            sumH1 -= s1.popLast() ?? 0
        }
        else if sumH2 > sumH1 && sumH2 > sumH3 {
            sumH2 -= s2.popLast() ?? 0
        }
        else if sumH3 > sumH1 && sumH3 > sumH2 {
            sumH3 -= s3.popLast() ?? 0
        }
    }
    return sumH1
}

let a = [3, 2, 1, 1, 1]
let b = [4, 3, 2]
let c = [1, 1, 4, 1]
print(equalStacks(h1: a, h2: b, h3: c))

//https://www.hackerrank.com/challenges/equality-in-a-array/problem
func equalizeArray(arr: [Int]) -> Int {
    var reps = [Int: Int]()
    for num in arr {
        if let count = reps[num] {
            reps[num] = count + 1
        }
        else {
            reps[num] = 1
        }
    }
    var max = 0
    for (_, value) in reps {
        max = value > max ? value : max
    }
    return arr.count - max
}

let arr = [3, 3, 2, 1, 3]
print(equalizeArray(arr: arr))

//https://www.hackerrank.com/challenges/sherlock-and-squares/problem
func squares(a: Int, b: Int) -> Int {
    return Int(floor(Double(b).squareRoot()) - ceil(Double(a).squareRoot()) + 1)
}

print(squares(a: 4, b: 4))

//https://www.hackerrank.com/challenges/minimum-distances/problem
func minimumDistances(a: [Int]) -> Int {
    var minD = -1
    var posDict = [Int: Int]()
    for (index, num) in a.enumerated() {
        if let pos = posDict[num] {
            let distance = abs(index - pos)
            minD = (minD != -1 && minD <= distance) ? minD : distance
        } else {
            posDict[num] = index
        }
    }
    return minD
}
let arrMD = [7, 1, 3, 4, 1, 7]
print(minimumDistances(a: arrMD))

//https://www.hackerrank.com/challenges/chocolate-feast/problem
func chocolateFeast(n: Int, c: Int, m: Int) -> Int {
    var chocs: Int = n/c
    var wrappers: Int = n/c
    while wrappers >= m {
        chocs += wrappers/m
        wrappers = wrappers/m + wrappers%m
    }
    return chocs
}

print(chocolateFeast(n: 10, c: 2, m: 5))


//https://www.hackerrank.com/challenges/kaprekar-numbers/problem
func kaprekarNumbers(p: Int, q: Int) -> Void {
    var resArray = [String]()
    for i in p...q {
        let sq = i * i
        let sqStr = String(sq)
        if sqStr.count == 1 && Int(sqStr) == i {
            resArray.append(String(i))
        }
        else {
            let mid: Int = sqStr.count/2
            let midIdx = sqStr.index(sqStr.startIndex, offsetBy: mid)
            let l = String(sqStr[..<midIdx])
            let r = String(sqStr[midIdx...])
            if let a = Int(l),
                let b = Int(r),
                i == (a+b) {
                resArray.append(String(i))
            }
        }
    }
    let res = resArray.count == 0 ? "INVALID RANGE" : resArray.joined(separator: " ")
    print(res)
}

print(kaprekarNumbers(p: 1, q: 100))

//https://www.hackerrank.com/challenges/taum-and-bday/problem
func taumBday(b: Int, w: Int, bc: Int, wc: Int, z: Int) -> Int {
    let bct = bc > wc + z ? wc + z : bc
    let wct = wc > bc + z ? bc + z : wc
    
    let res = (b * bct) + (w * wct)
    return res
}

print(taumBday(b: 10, w: 10, bc: 1, wc: 1, z: 1))

//https://www.hackerrank.com/challenges/cut-the-sticks/problem
func cutTheSticks(arr: [Int]) -> [Int] {
    var res = [arr.count]
    var sorted = arr.sorted()
    while sorted.count > 0 {
        let smallest = sorted.remove(at: 0)
        sorted = sorted.map{ $0-smallest }.filter{ $0 != 0}
        if sorted.count > 0 {
            res.append(sorted.count)
        }
    }
    return res
}

let sticks = [1, 2, 3, 4, 3, 3, 2, 1]
print(cutTheSticks(arr: sticks))

//https://www.hackerrank.com/challenges/find-digits/problem
func findDigits(n: Int) -> Int {
    var num = n
    var digits = [Int]()
    while num != 0 {
        let digit = num % 10
        digits.append(digit)
        num = num / 10
    }
    
    var res = 0
    for digit in digits {
        if digit != 0 && n % digit == 0 {
            res += 1
        }
    }
    return res
}

print(findDigits(n: 123456789))

//https://www.hackerrank.com/challenges/permutation-equation/problem
func permutationEquation(p: [Int]) -> [Int] {
    var res = [Int]()
    for i in 1...p.count {
        if let idx = find(value: i, in: p),
            let idx2 = find(value: (idx + 1), in: p) {
            res.append(idx2+1)
        }
    }
   return res
}

func find<T:Equatable>(value searchValue: T, in array: [T]) -> Int?
{
    for (index, value) in array.enumerated()
    {
        if value == searchValue {
            return index
        }
    }
    
    return nil
}

let numbers = [4, 3, 5, 1, 2]//[2, 3, 1]
print(permutationEquation(p: numbers))

//Minimum Cost to climb stairs
//https://www.geeksforgeeks.org/minimum-cost-to-reach-the-top-of-the-floor-by-climbing-stairs/

func minCostClimbingStairs(_ cost: [Int]) -> Int {
    
    let costLast = minCost(cost, index: cost.count-1)
    let costLastToLast = minCost(cost, index: cost.count-2)
    
    return min(costLast, costLastToLast)
}

func minCost(_ cost: [Int], index: Int) -> Int {
    if index == 0 { return cost[0] }
    if index == 1 { return cost[1] }
    
    return cost[index] + min(minCost(cost, index: index-2),
               minCost(cost, index: index-1))
}

let aMC: [Int] = [16, 19, 10, 12, 18]
print(minCostClimbingStairs(aMC))

let bMC: [Int] = [2, 5, 3, 1, 7, 3, 4]
print(minCostClimbingStairs(bMC))

//Search in rotated array
//https://www.geeksforgeeks.org/search-an-element-in-a-sorted-and-pivoted-array/

func searchInRotatedArray(arr: [Int], n: Int) {
    let startIndex = 0
    let endIndex = arr.count - 1
    let midIndex = (endIndex - startIndex)/2
}

func binarySearch(arr: [Int], n: Int) {
    
}

let rotArr: [Int] = [5, 6, 7, 8, 9, 10, 1, 2, 3]


//Maximum toys in given budget
//https://www.hackerrank.com/challenges/mark-and-toys/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=sorting

let prices:[Int] = [1, 12, 5, 111, 200, 1000, 10]

func maximumToys(prices: [Int], k: Int) -> Int {
    let sortedPrices = prices.sorted()
    var moneyLeft = k
    var count = 0
    for price in sortedPrices {
        if price <= moneyLeft {
            count += 1
            moneyLeft -= price
        }
    }
    return count
}

print(maximumToys(prices: prices, k: 50))

//Two Strings
//https://www.hackerrank.com/challenges/two-strings/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps

func twoStrings(s1: String, s2: String) -> String {

    let startChar = Unicode.Scalar("A").value
    let endChar = Unicode.Scalar("Z").value
    for alphabet in startChar...endChar {
        
        if let char = Unicode.Scalar(alphabet) {
            if (s1.range(of: "\(char)") != nil) && s2.range(of: "\(char)") != nil {
                return "YES"
            }
        }
    }
    
    let startCharLow = Unicode.Scalar("a").value
    let endCharLow = Unicode.Scalar("z").value
    for alphabet in startCharLow...endCharLow {
        
        if let char = Unicode.Scalar(alphabet) {
            if (s1.range(of: "\(char)") != nil) && s2.range(of: "\(char)") != nil {
                return "YES"
            }
        }
    }
    
    return "NO"
}

print(twoStrings(s1: "Hello", s2: "World"))

//Hash Tables: Ice Cream Parlor
//https://www.hackerrank.com/challenges/ctci-ice-cream-parlor/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=search

//func whatFlavors(cost: [Int], money: Int) -> Void {
//    guard cost != nil, cost.count > 0, money > 0 else {return}
//    let sortedCost = cost.sorted()
//    var n = 0
//    var n1 = 1
//    var flag = true
//    while n1 < sortedCost.count {
//        let sum = sortedCost[n] + sortedCost[n1]
//        if sum == money {
//            let first = cost.index(of: sortedCost[n])! + 1
//            var second: Int
//            if sortedCost[n] == sortedCost [n1] {
//                let  remArr = cost[first...]
//                second = remArr.index(of: sortedCost[n1])! + 1
//            }
//            else {
//                second = cost.index(of: sortedCost[n1])! + 1
//            }
//            let str = first < second ? "\(first) \(second)" : "\(second) \(first)"
//            print(str)
//            return
//        }
//        else if sum < money {
//            if flag == false {
//                n += 1
//            }
//            else {
//                n1 += 1
//            }
//            flag = !flag
//        }
//    }
//}

func binarySearch(cost:[Int], element: Int) -> Bool {
    
    var s = 0, e = cost.count - 1
    while s < e {
        let middle = (s+e)/2
        if cost[middle] == element {
            return true
        }
        else if middle < element {
            s = middle + 1
        }
        else {
            e = middle - 1
        }
    }
    return false
}

func whatFlavors(cost: [Int], money: Int) -> Void {
    let trimmedCost = cost.flatMap { $0 }
    let sortedCost = trimmedCost.sorted()
    var i = 0
    while i < sortedCost.count {
        let complement = money - sortedCost[i]
        if binarySearch(cost: sortedCost, element: complement) {
            let i1 = cost.firstIndex(of: sortedCost[i])! + 1
            let i2 = (complement != cost[i]) ? cost.firstIndex(of: complement)! + 1 : cost[i1...].firstIndex(of: complement)! + 1
            let result = i1 < i2 ? "\(i1) \(i2)" : "\(i2) \(i1)"
            print(result)
            break
        }
        i += 1
    }
}

let cost1: [Int] = [1, 4, 5, 3, 2]
let cost2: [Int] = [2, 2, 4, 3]
let cost3 = [1, 2, 3, 5, 6]
let cost4 = [4, 3, 2, 5, 7]

whatFlavors(cost: cost1, money: 4)
whatFlavors(cost: cost2, money: 4)
whatFlavors(cost: cost3, money: 5)
whatFlavors(cost: cost4, money: 8)


//https://www.hackerrank.com/challenges/ctci-bubble-sort/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=sorting
//Sorting: Bubble Sort

func countSwaps(a: [Int]) -> Void {
    guard a.count > 0 else {return}
    let count = a.count
    var i = 0, j = 0
    var swapCount = 0
    var arr = a
    while i < count {
        j = 0
        while j < count-1 {
            if arr[j] > arr[j+1] {
                let temp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = temp
                swapCount += 1
            }
            j += 1
        }
        i += 1
    }
    print("Array is sorted in \(swapCount) swaps.")
    print("First Element: \(arr.first!)")
    print("Last Element: \(arr.last!)")
    
}

let ar = [10, 4, 3, 5, 6]
countSwaps(a: ar)

//https://leetcode.com/problems/single-number-iii/
func singleNumber(_ nums: [Int]) -> [Int] {
    var dic = [Int : Int]()
    for num in nums {
        if let count = dic[num], count == 1 {
            dic.removeValue(forKey: num)
        }
        else {
            dic[num] = 1
        }
    }
    return Array(dic.keys)
}

let inputArray = [1, 2, 1, 3, 2, 5]
singleNumber(inputArray)


//https://www.hackerrank.com/challenges/kangaroo/problem
extension Double {
    var isInt: Bool {
        let intValue = Int(self)
        return  Double(intValue) == self
    }
}
// Complete the kangaroo function below.
func kangaroo(x1: Int, v1: Int, x2: Int, v2: Int) -> String {
    let jumps: Double = (Double(x2) - Double(x1)) / (Double(v1) - Double(v2))
//    let jumps = 5.0 / -1.0
    print(jumps)
    return (jumps > 0 && jumps.isInt) ? "YES" : "NO"
}

print(kangaroo(x1: 0, v1: 2, x2: 5, v2: 3))


//https://www.hackerrank.com/challenges/the-birthday-bar/problem

func birthday(s: [Int], d: Int, m: Int) -> Int {
    var i = 0, count = 0
    while (i + m) <= s.count {
        var j = 0, sum = 0
        while j < m {
            sum += s[i+j]
            if j == m-1 && sum == d {
                print("Sum: \(sum) \ni: \(i)\nj: \(j)")
                count += 1
            }
            j += 1
        }
        i += 1
    }
    return count
}

let s = [1, 2, 1, 3, 2]
birthday(s: s, d: 3, m: 2)

//let i = 20
//let reverse = Int(String("\(i)".reversed()))
//print(reverse!)
//print((abs(i - reverse!)))

//func beautifulDays(i: Int, j: Int, k: Int) -> Int {
//    var count = 0
//    for index in i...j {
//        if let reverse = Int(String("\(index)".reversed())) {
////            print("Number:\(index) Reverse: \(reverse)")
//            let diff = (abs(index - reverse))
////            print("Difference: \(diff)")
//            if  diff == 0 || diff % k == 0 {
//                count += 1
//            }
////            print("Count: \(count)")
//        }
//
//    }
//    return count
//}
//
//print(beautifulDays(i: 1, j: 2000000, k: 23047885))


//https://www.hackerrank.com/challenges/save-the-prisoner/problem
func saveThePrisoner(n: Int, m: Int, s: Int) -> Int {
    let result = (m + s - 1) % n == 0 ? n : (m + s - 1) % n
    print(result)
    return result
}

print(saveThePrisoner(n: 352926151, m: 380324688, s: 94730870))

//https://www.hackerrank.com/challenges/circular-array-rotation/problem
func circularArrayRotation(a: [Int], k: Int, queries: [Int]) -> [Int] {
    var result = [Int]()
    let rot = k % a.count
    for i in 0..<queries.count {
        let idx = queries[i]
        if idx - rot >= 0 {
            result.append(a[(idx-rot)])
        }
        else {
            result.append(a[idx - rot + a.count])
        }
    }
    return result
}

print(circularArrayRotation(a: [1,2,3], k: 2, queries: [0,1,2]))
