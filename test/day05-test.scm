(use-modules (srfi srfi-64)
             (aoc day05))

(test-begin "day05")

(test-equal "part1 example"
  3
  (part1 (parse-input "input/day05-example.txt")))
(test-equal "part1"
  744
  (part1 (parse-input "input/day05.txt")))

(test-equal "part2 example"
  14
  (part2 (parse-input "input/day05-example.txt")))
(test-equal "part2"
  347468726696961
  (part2 (parse-input "input/day05.txt")))

(test-end)
