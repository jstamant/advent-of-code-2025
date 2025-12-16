(use-modules (ice-9 rdelim))

(define (input->list filename)
  (let ((port (open-file filename "r")))
    (let loop ((acc '()))
      (let ((line (read-line port)))
        (if (eof-object? line)
            acc
            (loop (append acc (list line))))))))

;; (let loop ((lines (input->list "test/day01-test.txt")) ; this test should return 3
(let loop ((lines (input->list "input/day01.txt")) ; solved! should be 1150 for part 1
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
        (display line)
        (display " ")
        (display new-position)
        (display "\n")
        (loop (cdr lines)
              new-position
              (if (zero? (modulo new-position 100)) (+ zero-stops 1) zero-stops)))))

(define (limit-position pos)
  (modulo pos 100))

;; (let loop ((lines (input->list "test/day01-test.txt")) ; this test should return 6 for part 2
(let loop ((lines (input->list "input/day01.txt")) ; solution is 6738 for day 1 part 2
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
        (display (format #f "P ~d\t~s ~d\n" position line ticks-to-crossing))
        (loop (cdr lines)
              (limit-position new-position)
              (+ zero-crossings crossings)))))

