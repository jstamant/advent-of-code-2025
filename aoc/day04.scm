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

;; Answer for part2 example is 0
;; Answer for part2 is 0
(define (part2 data)
  data)

(part1 (parse-input "input/day04.txt"))
