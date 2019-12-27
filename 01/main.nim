import math
import parseutils
import strutils

proc computeFuel_part1(fuel: int): int =
    int(fuel / 3) - 2

proc computeFuel_part2(fuel: int): int =
    var df = int(fuel / 3) - 2
    while df > 0:
        result += df
        df = int(df / 3) - 2 

let lines = readFile("data.txt")
var total_1, total_2, fuel: int

for line in split(lines, "\n"):
    fuel = parseInt(line)
    total_1 += computeFuel_part1(fuel)
    total_2 += computeFuel_part2(fuel)
echo total_1, " ", total_2