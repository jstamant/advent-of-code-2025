(define-module (aoc day06)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (part1 part2 parse-input))

(define (list-strings->list-numbers lst)
  (cond ((not (string? (car lst))) lst)
        (else (list-strings->list-numbers
               (append (cdr lst) (list (string->number (car lst))))))))

(define (parse-input file)
  (let* ((data (reverse (map (lambda (list-with-nulls)
                               (let loop ((lst list-with-nulls)
                                          (new-list '()))
                                 (cond ((null? lst) new-list)
                                       ((string=? "" (car lst))
                                        (loop (cdr lst) new-list))
                                       (else (loop (cdr lst) (append new-list (list (car lst))))))))
                             (map (lambda (str) (string-split str char-set:whitespace))
                                  (call-with-input-file file
                                    (lambda (port)
                                      (parse-delim-input port)))))))
         (operators (car data))
         ;; transpose the numbers so the columns are together
         (numbers (map
                   list-strings->list-numbers
                   (apply map list (reverse (cdr data))))))
    (list
     operators
     numbers)))

;; Answer for part1 example is 4277556
;; Answer for part1 is 6503327062445
(define (part1 data)
  (let loop-operation ((operators (car data))
                       (numbers (cadr data))
                       (acc 0))
    (display (format #f "operators\n~a\n" operators))
    (display (format #f "numbers\n~a\n" numbers))
    (display "\n")
    (cond ((null? operators) acc)
          ((string=? "+" (car operators))
           (loop-operation (cdr operators)
                           (cdr numbers)
                           (+ acc (apply + (car numbers)))))
          ((string=? "*" (car operators))
           (loop-operation (cdr operators)
                           (cdr numbers)
                           (+ acc (apply * (car numbers)))))
          (else (throw 'error "uncaught path in looping over operators")))))

;; Answer for part2 example is ?
;; Answer for part2 is ?
(define (part2 data)
  data)

;; (part1 (parse-input "input/day06-example.txt"))
(part1 (parse-input "input/day06.txt"))
;; (part2 (parse-input "input/day06-example.txt"))
;; (part2 (parse-input "input/day06.txt"))
