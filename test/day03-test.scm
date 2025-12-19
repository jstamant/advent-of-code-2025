(use-modules (srfi srfi-64)
             (aoc day03))

(test-begin "day03")

(test-equal "part1 example"
  357
  (part1 (parse-input "input/day03-example.txt")))
(test-equal "part1"
  16927
  (part1 (parse-input "input/day03.txt")))

(test-equal "part2 example"
  3121910778619
  (part2 (parse-input "input/day03-example.txt")))
(test-equal "part2"
  167384358365132
  (part2 (parse-input "input/day03.txt")))

(test-end)
