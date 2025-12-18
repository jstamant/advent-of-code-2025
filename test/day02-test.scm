(use-modules (srfi srfi-64)
             (aoc day02))

(test-begin "day02")

(test-equal "part1 example"
  1227775554
  (part1 (parse-input "input/day02-example.txt")))
(test-equal "part1"
  18952700150
  (part1 (parse-input "input/day02.txt")))

(test-equal "part2 example"
  4174379265
  (part2 (parse-input "input/day02-example.txt")))
(test-equal "part2"
  28858486244
  (part2 (parse-input "input/day02.txt")))

(test-end)
