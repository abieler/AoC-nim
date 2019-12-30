import strutils
import sets
import tables

type
    Point = tuple
      x: int
      y: int


const move_up = (x: 0, y: 1)
const move_down = (x: 0, y: -1)
const move_right = (x: 1, y: 0)
const move_left = (x: -1, y: 0)


proc `+`(p1: Point, p2: Point): Point =
    result.x = p1.x + p2.x
    result.y = p1.y + p2.y 

proc `*`(a: int, p: Point): Point =
    result.x = p.x * a
    result.y = p.y * a


proc addPoints(p: Point, dp: int, move: Point, c0:int): (seq[Point], Table[Point, int]) =
    var points: seq[Point]
    var nSteps = initTable[Point, int]()
    var counter: int = c0 + 1
    var next_point: Point
    for i in countup(1, dp):
        next_point = p + i * move
        points.add(next_point)
        nSteps[next_point] = counter
        counter += 1
    return (points, nSteps)


proc parseMoves(moves: seq[string]): (seq[Point], Table[Point, int]) =
    var dp, counter: int
    var direction: char
    var points, pts: seq[Point]
    var nSteps, stps = initTable[Point, int]()
    points.add((0,0))
    for move in moves:
        direction = move[0]
        dp = parseInt(move[1..^1])
        var p = points[^1]

        if direction == 'R':
            (pts, stps) = addPoints(p, dp, move_right, counter)
        elif direction == 'L':
            (pts, stps) = addPoints(p, dp, move_left, counter)
        elif direction == 'D':
            (pts, stps) = addPoints(p, dp, move_down, counter)
        elif direction == 'U':
            (pts, stps) = addPoints(p, dp, move_up, counter)
        points.add(pts)
        counter += len(pts)
        for k, v in stps:
            if not nSteps.haskey(k):
                nSteps[k] = v
    return (points, nSteps)

var points: seq[seq[Point]]
var nSteps: seq[Table[Point, int]]
var pts: seq[Point]
var stps: Table[Point, int]
for line in split(readFile("data.txt"), "\n"):
    var moves = split(line, ",")
    (pts, stps) = parseMoves(moves)
    points.add(pts)
    nSteps.add(stps)

let htps1 = toHashSet(points[0])
let htps2 = toHashSet(points[1])
let intersections = htps1 * htps2

var min_dist: int
var p_min: tuple[x: int, y: int]
var min_steps: int
for itr in intersections:
    if itr.x == 0  and itr.y == 0:
        continue
    var dst = abs(itr.x) + abs(itr.y)
    var cum_steps = nSteps[0][itr] + nSteps[1][itr]
    if dst < min_dist or min_dist == 0:
        min_dist = dst
        p_min = itr

    if cum_steps < min_steps or min_steps == 0:
        min_steps = cum_steps
    
echo "min_dist: ", min_dist
echo "min_steps: ", min_steps

# echo "min_steps: ", min_steps


# var min_steps = 0
# var i, j, dst, stps: int
# var intersections: seq[tuple[x:int, y:int]]
# for p1 in points[0]:
#     i = 0
#     for p2 in points[1]:
#         if p1 == p2:
#             intersections.add(p1)
#             dst = distance(p1)
#         stps = i + j
#         if p1 == p2 and i > 0: 
#             if dst < min_dist or min_dist == 0:
#                 min_dist = dst
#             if stps < min_steps or min_steps == 0:
#                 min_steps = stps
#             break
#         i += 1
#     j += 1
# echo "Answer problem 1: ", min_dist
# echo min_steps
# 