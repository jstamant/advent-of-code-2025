(use-modules (srfi srfi-64)
             (aoc day01))

(test-begin "day01")

(test-equal "part1 example"
  3
  (part1 "input/day01-example.txt"))
(test-equal "part1"
  1150
  (part1 "input/day01.txt"))

(test-equal "part2 example"
  6738
  (part2 "input/day01.txt"))

(test-end)
