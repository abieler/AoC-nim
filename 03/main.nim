import strutils

type
    Point = object
        x: int
        y: int


proc parseMoves(moves: seq[string]): int =
    var points: seq[Point] = @[Point()]
    for move in moves:
        if move[0] == 'R' or move[0] == 'L':
            echo "moving right or left", " ", move
            



var moves: seq[seq[string]] = @[]
for line in split(readFile("data.txt"), "\n"):
    var a = parseMoves(split(line, ","))
    # moves.add(split(line, ","))

echo len(moves)
echo moves[0]

