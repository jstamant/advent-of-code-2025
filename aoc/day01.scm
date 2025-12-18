(define-module (aoc day01)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 regex)
  #:export (part1 part2 parse-input))

(define (parse-input file)
  (call-with-input-file file
    (lambda (port)
      (parse-delim-input port))))

(define (part1 data)
  (let loop ((lines data)
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

(define (part2 data)
  (let loop ((lines data)
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

(@ (ice-9 pretty-print)
   pretty-print) (list (part1 (parse-input "input/day01-example.txt"))
                       (part1 (parse-input "input/day01.txt"))
                       (part2 (parse-input "input/day01-example.txt"))
                       (part2 (parse-input "input/day01.txt")))
