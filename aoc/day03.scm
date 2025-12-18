(define-module (aoc day03)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (part1 part2 parse-input))

(define (parse-input file)
  (call-with-input-file file
    (lambda (port)
      (parse-delim-input port))))

;; Answer for part1 example is 357
(define (part1 data)
  data)

(define (part2 data)
  data)

(part1 (parse-input "input/day03-example.txt"))
