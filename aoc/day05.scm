(define-module (aoc day05)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (part1 part2 parse-input))

(define (string-range->cons-range str)
  (let* ((idx (string-index str #\-))
         (start (string->number (string-take str idx)))
         (end (string->number (string-take-right str idx))))
    (cons start end)))

;; Returns a list of two elements,
;; the first being the list of ranges, ex 11-22, 45-62 etc
;; the second being the list of ids, ex 2, 10, 24, etc
(define (parse-input file)
  (let ((data (call-with-input-file file
                (lambda (port)
                  (parse-delim-input port)))))
    (list (map string-range->cons-range
               (reverse (cdr (member "" (reverse data)))))
          (map string->number (cdr (member "" data))))))

;; Answer for part1 example is 3
;; Answer for part1 is 744
(define (part1 data)
  (let loop-ids ((ids (cadr data))
                 (fresh-ingredients 0))
    (if (null? ids)
        fresh-ingredients
        (loop-ids
         (cdr ids)
         (+ fresh-ingredients
            (let ((id (car ids)))
              (let loop-ranges ((ranges (car data)))
                (if (null? ranges)
                    0
                    (let ((range (car ranges)))
                      (if (and (>= id (car range))
                               (<= id (cdr range)))
                          1
                          (loop-ranges (cdr ranges))))))))))))

;; Answer for part2 example is ?
;; Answer for part2 is ?
(define (part2 data)
  data)

;; (part1 (parse-input "input/day05-example.txt"))
(part1 (parse-input "input/day05.txt"))
;; (part2 (parse-input "input/day05-example.txt"))
;; (part2 (parse-input "input/day05.txt"))
