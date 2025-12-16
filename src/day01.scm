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
