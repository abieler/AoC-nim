import strutils

type
    Point = object
        x: int
        y: int


proc parseMoves(moves: seq[string]): seq[Point] =
    var di: int
    var direction: char
    var start: int
    var p: int
    result.add(Point())
    for move in moves:
        direction = move[0]
        di = parseInt(move[1..^1])
        if direction == 'R':
            start = result[^1].x
            p = result[^1].y
            for x in start..start+di:
                result.add(Point(x:x, y:p))
        elif direction == 'L':
            start = result[^1].x
            p = result[^1].y
            for x in start..start-di:
                result.add(Point(x:x, y:p))
        elif direction == 'D':
            start = result[^1].y
            p = result[^1].x
            for y in start..start-di:
                result.add(Point(x:p, y:y))
        elif direction == 'U':
            start = result[^1].y
            p = result[^1].x
            for y in start..start+di:
                result.add(Point(x:p, y:y))
    


for line in split(readFile("data.txt"), "\n"):
    var a = parseMoves(split(line, ","))
    echo len(a)



