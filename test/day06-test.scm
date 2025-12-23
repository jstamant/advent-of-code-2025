(use-modules (srfi srfi-64)
             (aoc day06))

(test-begin "day06")

(test-equal "part1 example"
  4277556
  (part1 (parse-input "input/day06-example.txt")))
(test-equal "part1"
  6503327062445
  (part1 (parse-input "input/day06.txt")))

(test-equal "part2 example"
  3263827
  (part2 (parse-input "input/day06-example.txt")))
;; (test-equal "part2"
;;   ?
;;   (part2 (parse-input "input/day06.txt")))

(test-end)
