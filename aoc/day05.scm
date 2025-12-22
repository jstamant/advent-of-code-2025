(define-module (aoc day05)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (part1 part2 parse-input))

(define (string-range->cons-range str)
  (let* ((idx (string-index str #\-))
         (start (string->number (string-take str idx)))
         (end (string->number (string-drop str (+ 1 idx)))))
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

(define (sort-ranges ranges)
  "Sorts a list of RANGES in the form (START . END), first by their
START, then by their END."
  (sort ranges (lambda (a b)
                 (cond ((< (car a) (car b)) #t)
                       ((> (car a) (car b)) #f)
                       (else (< (cdr a) (cdr b)))))))

(define (merge-ranges sorted-ranges)
  "Takes a sorted list of RANGES in the form (START . END), and merges
any overlaps."
  (let loop ((ranges sorted-ranges)
             (merged-ranges '()))
    (cond
     ((zero? (length ranges))
      merged-ranges)
     ((= 1 (length ranges))
      (append merged-ranges (list (car ranges))))
     (else
      (let ((a (car ranges))
            (b (cadr ranges)))
        (cond
         ;; no overlap
         ((< (cdr a) (car b))
          (loop (cdr ranges) (append merged-ranges (list a))))
         ;; complete overlap
         ((> (cdr a) (cdr b))
          (loop (append (list a) (cddr ranges)) merged-ranges))
         ;; partial overlap
         ((>= (cdr a) (car b))
          (loop (append (list (cons (car a) (cdr b))) (cddr ranges))
                merged-ranges))))))))

(define (sum-ranges ranges)
  "Takes a list of RANGES in the form (START . END), and adds the ranges,
START and END inclusive."
  (let loop ((lst ranges)
             (acc 0))
    (if (null? lst)
        acc
        (let ((a (car lst)))
          (loop (cdr lst) (+ 1 acc (- (cdr a) (car a))))))))

;; Answer for part2 example is 14
;; Answer for part2 is 347468726696961
(define (part2 data)
  (sum-ranges (merge-ranges (sort-ranges (car data)))))

;; (part1 (parse-input "input/day05-example.txt"))
;; (part1 (parse-input "input/day05.txt"))
;; (part2 (parse-input "input/day05-example.txt"))
(part2 (parse-input "input/day05.txt"))
