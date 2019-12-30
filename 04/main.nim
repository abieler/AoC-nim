proc hasSameAdjacent(x: int): bool =
    let s = $x
    let N = len(s)
    for i in 0..<(N-1):
        if s[i] == s[i+1]:
            return true
    return false

proc monotinicIncreasing(x: int): bool =
    let s = $x
    let N = len(s)
    for i in 0..<(N-1):
        if s[i+1] < s[i]:
            return false
    return true


proc findConsecutive(s: string): int =
    result += 1
    for c in s[1..<s.len]:
        if c == s[0]:
            result += 1
        else:
            break


proc hasGroupOfTwo(x: int): bool =
    var counter: seq[int]
    let s = $x
    var i = 0
    while true:
        if i >= len(s)-1:
            break
        var di = findConsecutive(s[i..^1])
        counter.add(di)
        i += di
    return 2 in counter


var counter: int
for i in 387638..919123:
    if hasSameAdjacent(i) and monotinicIncreasing(i) and hasGroupOfTwo(i):
        counter += 1

echo counter