(define-module (aoc day06)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (part1 part2 parse-input))

(define (parse-input file)
  (call-with-input-file file
    (lambda (port)
      (parse-delim-input port))))

;; Answer for part1 example is 4277556
;; Answer for part1 is ?
(define (part1 data)
  data)

;; Answer for part2 example is ?
;; Answer for part2 is ?
(define (part2 data)
  data)

(part1 (parse-input "input/day06-example.txt"))
;; (part1 (parse-input "input/day06.txt"))
;; (part2 (parse-input "input/day06-example.txt"))
;; (part2 (parse-input "input/day06.txt"))
