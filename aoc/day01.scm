(define-module (aoc day01)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 regex)
  #:export (part1 part2))

(define (part1 input-filepath)
;; (let loop ((lines (input->list "test/day01-test.txt")) ; this test should return 3
(let loop ((lines (parse-delim-input input-filepath)) ; solved! should be 1150 for part 1
           (position 50)
           (zero-stops 0))
  (if (null? lines)
      zero-stops
      (let* ((line (car lines))
             (instruction (map match:substring (list-matches "^.|[0-9]*" line)))
             (direction (car instruction))
             (ticks (string->number (cadr instruction)))
             (new-position (if (string=? direction "L")
                               (- position ticks)
                               (+ position ticks))))
        (loop (cdr lines)
              new-position
              (if (zero? (modulo new-position 100)) (+ zero-stops 1) zero-stops))))))

(define (limit-position pos)
  (modulo pos 100))

(define (part2 input-filepath)
;; (let loop ((lines (input->list "test/day01-test.txt")) ; this test should return 6 for part 2
(let loop ((lines (parse-delim-input input-filepath)) ; solution is 6738 for day 1 part 2
           (position 50)
           (zero-crossings 0))
  (if (null? lines)
      zero-crossings
      (let* ((line (car lines))
             (instruction (map match:substring (list-matches "^.|[0-9]*" line)))
             (direction (car instruction))
             (ticks (string->number (cadr instruction)))
             (ticks-to-crossing (cond
                                 ((= position 0) 100) ; prevents double-counting when landing on 0
                                 ((string=? direction "L") position)
                                 (else (- 100 position))))
             (crossings (+ (quotient ticks 100)
                           (if (>= (remainder ticks 100) ticks-to-crossing) 1 0)))
             (new-position (if (string=? direction "L")
                               (- position ticks)
                               (+ position ticks))))
        (loop (cdr lines)
              (limit-position new-position)
              (+ zero-crossings crossings))))))

(part2 "input/day01.txt")
