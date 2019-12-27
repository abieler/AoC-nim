import sequtils
import strutils

proc parseData(line: var seq[int], di: int): int =
    var switch = line[di]
    var ix = line[di+1]
    var iy = line[di+2]
    var x = line[ix]
    var y = line[iy]
    var j = line[di+3]

    if switch == 1:
        line[j] = x + y
    elif switch == 2:
        line[j] = x * y
    elif switch == 99:
        result += 1
    else:
        echo "this should not happen"

for noun in 0..99:
    for verb in 0..99:
        var di = 0
        var finished: int
        var line = map(split(strip(readFile("data.txt")), ","), parseInt)
        line[1] = noun
        line[2] = verb
        while finished == 0:
            finished = parseData(line, di)
            di += 4
        if line[0] == 19690720:
            echo noun, " ", verb
            echo 100 * noun + verb