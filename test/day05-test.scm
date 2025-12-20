(use-modules (srfi srfi-64)
             (aoc day05))

(test-begin "day05")

(test-equal "part1 example"
  3
  (part1 (parse-input "input/day05-example.txt")))
;; (test-equal "part1"
;;   0
;;   (part1 (parse-input "input/day05.txt")))

;; (test-equal "part2 example"
;;   0
;;   (part2 (parse-input "input/day05-example.txt")))
;; (test-equal "part2"
;;   0
;;   (part2 (parse-input "input/day05.txt")))

(test-end)
