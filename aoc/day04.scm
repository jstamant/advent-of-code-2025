(define-module (aoc day04)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (part1 part2 parse-input))

(define (parse-input file)
  (call-with-input-file file
    (lambda (port)
      (parse-delim-input port))))

;; Answer for part1 example is 13
;; Answer for part1 is ?
(define (part1 data)
  data)

;; Answer for part2 example is 0
;; Answer for part2 is 0
(define (part2 data)
  data)

(part (parse-input "input/day04-example.txt"))
