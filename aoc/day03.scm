(define-module (aoc day03)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (part1 part2 parse-input))

(define (parse-input file)
  (call-with-input-file file
    (lambda (port)
      (parse-delim-input port))))

(define (find-max-joltage bank)
  "Notes: a BANK is a string (ex \"81119\"), and should return a number (ex 89)."
  ;; left digit: find the left-most largest digit that isn't the last digit
  (let* ((left-battery
          (let loop ((batteries (string-take bank (- (string-length bank) 1)))
                     (max-battery '(0 0))
                     (position 0))
            (cond ((string=? "" batteries)
                   (if (= 0 (car max-battery))
                       (throw 'error "error with finding a max digit")
                       max-battery))
                  ((> (string->number (string-take batteries 1)) (car max-battery))
                   (loop (string-drop batteries 1) (list (string->number (string-take batteries 1)) position) (+ 1 position)))
                  (else (loop (string-drop batteries 1) max-battery (+ 1 position))))))
         (left-digit (car left-battery))
         ;; right digit: find the largest digit to the right of the left digit
         (right-digit
          (let loop ((batteries (string-drop bank (+ 1 (cadr left-battery))))
                     (max-digit 0))
            (cond ((string=? "" batteries) max-digit)
                  ((= 9 max-digit) max-digit)
                  ((> (string->number (string-take batteries 1)) max-digit)
                   (loop (string-drop batteries 1) (string->number (string-take batteries 1))))
                  (else (loop (string-drop batteries 1) max-digit))))))
    (+ (* left-digit 10)
       right-digit)))

;; Answer for part1 example is 357
;; Answer for part1 is 16927
(define (part1 data)
  (apply + (map find-max-joltage data)))

(define (find-max-joltage-12 bank)
  "Like `find-max-joltage', but is 12 digits long, and must still be in
ascending order"
  ;; each digit: find the left-most largest digit from the previous
  ;; digit, and that still makes room for the remaining digits.
  (let loop-batteries ((joltage "")
                       (remaining-batteries 12)
                       (remaining-bank bank))
    (if (<= remaining-batteries 0)
        (string->number joltage)
        (let loop-batt ((batteries (string-drop-right remaining-bank (- remaining-batteries 1)))
                        (max-battery '(0 0))
                        (position 0))
          (cond ((string=? "" batteries)
                 (loop-batteries (string-append joltage (number->string (car max-battery)))
                                 (- remaining-batteries 1)
                                 (string-drop remaining-bank (+ 1 (cadr max-battery)))))
                ((> (string->number (string-take batteries 1)) (car max-battery))
                 (loop-batt (string-drop batteries 1)
                            (list (string->number (string-take batteries 1)) position)
                            (+ 1 position)))
                (else (loop-batt (string-drop batteries 1)
                                 max-battery
                                 (+ 1 position))))))))

;; Answer for part2 example is 3121910778619
;; Answer for part2 is 167384358365132
(define (part2 data)
  (apply + (map find-max-joltage-12 data)))

(part2 (parse-input "input/day03.txt"))
