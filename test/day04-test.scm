(use-modules (srfi srfi-64)
             (aoc day04))

(test-begin "day04")

(test-equal "part1 example"
  13
  (part1 (parse-input "input/day04-example.txt")))
(test-equal "part1"
  1478
  (part1 (parse-input "input/day04.txt")))

(test-equal "part2 example"
  43
  (part2 (parse-input "input/day04-example.txt")))
(test-equal "part2"
  9120
  (part2 (parse-input "input/day04.txt")))

(test-end)
