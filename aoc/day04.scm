(define-module (aoc day04)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (part1 part2 parse-input))

(define (parse-input file)
  (call-with-input-file file
    (lambda (port)
      (parse-delim-input port))))

(define (get-char-at x y data)
  (string-ref (list-ref data y) x))

(define (is-accessible? pos data)
  (let ((rows (length data))
        (cols (string-length (car data))))
    (let loop ((x (- (car pos) 1))
               (y (- (cdr pos) 1))
               (rolls 0))
      (cond ((> rolls 4) #f)
            ((or (>= y rows)
                 (> y (+ 1 (cdr pos)))) rolls)
            ((or (>= x cols)
                 (> x (+ 1 (car pos))))
             (loop (- (car pos) 1) (+ 1 y) rolls))
            ((or (< x 0) (< y 0))
             (loop (+ 1 x) y rolls))
            ((char=? #\@ (get-char-at x y data))
             (loop (+ 1 x) y (+ 1 rolls)))
            (else (loop (+ 1 x) y rolls))))))

;; Answer for part1 example is 13
;; Answer for part1 is 1478
(define (part1 data)
  (let ((rows (length data))
        (cols (string-length (car data))))
    (let loop ((x 0) (y 0) (acc 0))
      (cond ((>= y rows)
             acc)
            ((>= x cols)
             (loop 0 (+ 1 y) acc))
            ((char=? #\@ (get-char-at x y data))
             (loop (+ 1 x) y (+ acc (if (is-accessible? (cons x y) data) 1 0))))
            (else (loop (+ 1 x) y acc))))))

;; Answer for part2 example is 43
;; Answer for part2 is 9120
(define (part2 data)
  (let iterate ((grid data)
                (acc-rolls 0))
    (let* ((rows (length grid))
           (cols (string-length (car grid)))
           (iteration
            (let next-row ((y 0) (rolls 0) (grid-in-prog '()))
              (cond ((>= y rows)
                     (list rolls grid-in-prog))
                    (else
                     (let ((row-data
                            (let next-col ((x 0) (rolls-in-row 0) (new-row ""))
                              (cond ((>= x cols)
                                     (list rolls-in-row new-row))
                                    ((char=? #\. (get-char-at x y grid))
                                     (next-col
                                      (+ 1 x)
                                      rolls-in-row
                                      (string-append new-row ".")))
                                    ((char=? #\@ (get-char-at x y grid))
                                     (let ((roll-accessible? (is-accessible? (cons x y) grid)))
                                       (next-col
                                        (+ 1 x)
                                        (+ rolls-in-row (if roll-accessible? 1 0))
                                        (string-append new-row (if roll-accessible? "." "@")))))
                                    (else (throw 'error "don't think this should have happened"))))))
                       (next-row
                        (+ 1 y)
                        (+ rolls (car row-data))
                        (append grid-in-prog (list (cadr row-data)))))))))
           (new-grid (cadr iteration))
           (rolls-found (car iteration)))
      (if (zero? rolls-found)
          acc-rolls
          (iterate new-grid (+ acc-rolls rolls-found))))))

;; (part1 (parse-input "input/day04-example.txt"))
;; (part1 (parse-input "input/day04.txt"))
;; (part2 (parse-input "input/day04-example.txt"))
(part2 (parse-input "input/day04.txt"))
