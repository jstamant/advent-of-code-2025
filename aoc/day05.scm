(define-module (aoc day05)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (part1 part2 parse-input))

(define (parse-input file)
  (call-with-input-file file
    (lambda (port)
      (parse-delim-input port))))

;; Answer for part1 example is 3
;; Answer for part1 is ?
(define (part1 data)
  data)

;; Answer for part2 example is ?
;; Answer for part2 is ?
(define (part2 data)
  data)

(part1 (parse-input "input/day05-example.txt"))
