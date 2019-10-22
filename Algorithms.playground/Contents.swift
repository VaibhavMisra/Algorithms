import UIKit


//https://leetcode.com/problems/container-with-most-water/
func maxArea(_ height: [Int]) -> Int {
    var maxArea = 0
    
    for i in 0..<height.count {
        let next = i + 1
        for j in next..<height.count {
            let area = (j - i) * min(height[i], height[j])
            maxArea = max(maxArea, area)
            print("h[\(i)]: \(height[i]), h[\(j)]: \(height[j]), max: \(maxArea)")
        }
    }
    
    return maxArea
}

print(maxArea([1,1]))
print(maxArea([1,8,6,2,5,4,8,3,7]))

//https://leetcode.com/problems/pascals-triangle/
func generatePascal(_ numRows: Int) -> [[Int]] {
    var result = [[Int]]()
    for i in 0..<numRows {
        var row = [Int]()
        for j in 0...i {
            if i > 0 && j > 0 && j != i {
                row.append(result[i-1][j-1] + result[i-1][j])
            } else {
                row.append(1)
            }
        }
        result.append(row)
    }
    return result
}

print(generatePascal(5))


//https://leetcode.com/problems/merge-sorted-array/
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var i = 0, j = 0
    while j < n {
        if i >= m+j || nums2[j] < nums1[i] {
            nums1.insert(nums2[j], at: i)
            nums1.removeLast()
            j += 1
        }
        i += 1
    }
}

var nums1 = [1,2,3,0,0,0]
let m = 3
let nums2 = [2,5,6]
let n = 3

merge(&nums1, m, nums2, n)
print(nums1)

//Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

//https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/
func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    if nums.count == 0 {
        return nil
    }
    func toTree(_ l: Int, _ r: Int) -> TreeNode? {
        if l > r { return nil}
        if l == r { return TreeNode(nums[l])}
        let mid = (l+r)>>1

        let root = TreeNode(nums[mid])
        root.left = toTree(l, mid-1)
        root.right = toTree(mid+1, r)
        return root
    }
    return toTree(0, nums.count-1)
}

print(sortedArrayToBST([-10,-3,5,9])?.val ?? 0)
print(sortedArrayToBST([-10,-3,0,5,9])?.val ?? 0)

//https://leetcode.com/problems/maximum-depth-of-binary-tree/
func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else {
        return 0
    }

    let left = maxDepth(root.left)
    let right = maxDepth(root.right)

    return max(left, right) + 1
}



let treeNode1 = TreeNode(9)
let treeNode2 = TreeNode(20)
let treeNode3 = TreeNode(15)
let treeNode4 = TreeNode(7)
treeNode2.left = treeNode3
treeNode3.right = treeNode4

let root = TreeNode(3)
root.left = treeNode1
root.right = treeNode2

print(maxDepth(root))


//https://leetcode.com/problems/string-compression/
//func compress(_ chars: inout [Character]) -> Int {
//
//}



//https://leetcode.com/problems/evaluate-reverse-polish-notation/
func evalRPN(_ tokens: [String]) -> Int {
    var stack = [Int]()
    for token in tokens {
        if token == "+" || token == "-" || token == "*" || token == "/" {
            var result = 0
            let operand2 = stack.removeLast()
            let operand1 = stack.removeLast()
            switch token {
            case "+": result = operand1 + operand2
            case "-": result = operand1 - operand2
            case "*": result = operand1 * operand2
            case "/": result = operand1 / operand2
            default:
                result = 0
            }
            stack.append(result)
        } else {
            stack.append(Int(token) ?? 0)
        }
    }
    return stack.last ?? 0
}

print(evalRPN(["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]))
print(evalRPN(["4", "13", "5", "/", "+"]))
print(evalRPN(["2", "1", "+", "3", "*"]))

//Given a string 'aabccc', ouput -> a2b1c3
func charCompress(s: String) -> String {
    var result = ""
    var lastChar: Character?
    var count = 0
    for char in s {
        guard let last = lastChar else {
            lastChar = char
            count += 1
            continue
        }
        
        if char == last {
            count += 1
        } else {
            result += "\(last)\(count)"
            lastChar = char
            count = 1
        }
        print("Char:\(char), Result:\(result)")
    }
    
    if let last = lastChar {
        result += "\(last)\(count)"
    }
    
    return result
}

print(charCompress(s: ""))
print(charCompress(s: "abc"))
print(charCompress(s: "abbcccc"))
print(charCompress(s: "aabcc"))

//https://leetcode.com/problems/valid-parentheses/
func isValid(_ s: String) -> Bool {
    let map: [Character: Character] = [
        "(" : ")",
        "{" : "}",
        "[" : "]"
    ]
    
    var stack = [Character]()
    for char in s {
        if let last = stack.last, map[last] == char {
            stack.removeLast()
            continue
        }
        stack.append(char)
    }
    return stack.isEmpty
}

print(isValid("){"))
print(isValid("(]"))
print(isValid("([)]"))
print(isValid("{[]}"))

//https://leetcode.com/problems/reverse-integer/
func reverse(_ x: Int) -> Int {
    var result = 0
    var number = x
    while number != 0 {
        result = (result * 10) + (number % 10)
        number /= 10
    }

    guard result > Int(Int32.min), result < Int(Int32.max) else {
        return  0
    }
    return result
}

print(reverse(123))
print(reverse(-123))
print(reverse(1534236469))


//https://leetcode.com/problems/climbing-stairs/
func climbStairs(_ n: Int) -> Int {
    if (n < 3) {
        return n
    }
    var mem = [1, 2]
    for i in 2...n {
        mem.append(mem[i-2] + mem[i-1])
    }
    return mem[n-1]
}

print(climbStairs(1))
print(climbStairs(2))
print(climbStairs(3))
print(climbStairs(4))

//https://leetcode.com/problems/plus-one/
func plusOne(_ digits: [Int]) -> [Int] {
    var result = digits
    var carry = 1
    for i in (0..<digits.count).reversed() {
        let sum = digits[i] + carry
        let newDigit = sum >= 10 ? sum - 10 : sum
        carry = sum / 10
        result[i] = newDigit
    }
    if carry > 0 {
        result.insert(carry, at: 0)
    }
    return result
}

print(plusOne([1,2,9]))
print(plusOne([9,9,9]))

//https://leetcode.com/problems/longest-substring-without-repeating-characters/
func lengthOfLongestSubstring(_ s: String) -> Int {
    var max = 0, startIndex = 0
    var lastIndices = [Character: Int]()
    for (index, char) in s.enumerated() {
        if let lastIndex = lastIndices[char], lastIndex >= startIndex {
            startIndex = lastIndex + 1
        }
        lastIndices[char] = index
        let curr = index - startIndex +  1
        max = max < curr ? curr : max
    }
    return max
}

print(lengthOfLongestSubstring("tmmzuxt")) //5
print(lengthOfLongestSubstring("dvdf")) // 3
print(lengthOfLongestSubstring("pwwkew")) // 3
print(lengthOfLongestSubstring("bbbb")) //1
print(lengthOfLongestSubstring("abcabcbb")) //3

//https://leetcode.com/problems/add-two-numbers/
//Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard var list1 = l1, var list2 = l2 else { return nil }
    var isList1Complete = false, isList2Complete = false
    var carry = 0
    var resultHead, resultTail: ListNode?
    while true {
        let digit1 = isList1Complete == false ? list1.val : 0
        let digit2 = isList2Complete == false ? list2.val : 0
        let sum = digit1 + digit2 + carry
        let digit3 = sum % 10
        carry = sum / 10
        
        let tempListNode = ListNode(digit3)
        if resultHead == nil {
            resultHead = tempListNode
            resultTail = tempListNode
        } else {
            resultTail?.next = tempListNode
            resultTail = tempListNode
        }
        
        if let next = list1.next {
            isList1Complete = false
            list1 = next
        } else {
            isList1Complete = true
        }
        
        if let next = list2.next {
            isList2Complete = false
            list2 = next
        } else {
            isList2Complete = true
        }
        
        if isList1Complete && isList2Complete && carry == 0 {
            break
        }
    }
    return resultHead
}

var l11 = ListNode(2)
var l12 = ListNode(4)
var l13 = ListNode(3)
l11.next = l12
l12.next = l13

var l21 = ListNode(5)
var l22 = ListNode(6)
var l23 = ListNode(4)
l21.next = l22
l22.next = l23

print(addTwoNumbers(l11, l21)?.val ?? "No sum found")

//https://leetcode.com/problems/remove-duplicates-from-sorted-array-ii/
func removeDuplicates2(_ nums: inout [Int]) -> Int {
    guard nums.count > 2 else { return nums.count }
    var frequencies = [nums[0]: 1]
    var index = 0
    for i in 1..<nums.count {
        if nums[i] != nums[index] || frequencies[nums[i], default: 0] < 2 {
                index += 1
                nums[index] = nums[i]
                frequencies[nums[i]] = frequencies[nums[i], default: 0] + 1
        }
    }
    nums.removeSubrange((index+1)...) //Optional
    return index + 1
}
var dup = [0,0,1,1,1,1,2,3,3]
print(removeDuplicates2(&dup))
var dup1 = [1,1,1,2,2,3]
print(removeDuplicates2(&dup1))

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
