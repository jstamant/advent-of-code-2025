(define-module (aoc day02)
  #:use-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 regex)
  #:export (part1 part2 parse-input))

;; Takes the ranges, ex "11-22", and returns them as cons cells of numbers, ex (11 22)
(define (parse-input file)
  (map
   (lambda (range-string)
     (map string->number (map match:substring (list-matches "[0-9]*" range-string))))
   (call-with-input-file file
     (lambda (port)
       (parse-delim-input port ",")))))

(define (invalid-id? id)
  (let* ((string-id (number->string id))
         (length (string-length string-id)))
    (cond ((not (= 0 (modulo length 2))) #f)
          ((string=? (string-take string-id (/ length 2))
                     (string-drop string-id (/ length 2))) #t)
          (else #f))))

(define* (sum-invalid-ids range #:optional (proc invalid-id?))
  (let loop-ids ((ids range)
                 (acc 0))
    (if (> (car ids) (cadr ids))
        acc
        (loop-ids (list (+ 1 (car ids)) (cadr ids))
                  (+ acc (if (proc (car ids)) (car ids) 0))))))

;; answer for part1 example is 1227775554
;; answer for part1 is 18952700150
(define (part1 data)
  (let loop-ranges ((ranges data)
                    (acc 0))
    (if (null? ranges)
        acc
        (loop-ranges (cdr ranges)
                     (+ acc (sum-invalid-ids (car ranges)))))))

(define (all-repeating-digits? id)
  #t)

;; answer for part1 example is 4174379265
(define (part2 data)
  (let loop-ranges ((ranges data)
                    (acc 0))
    (if (null? ranges)
        acc
        (loop-ranges (cdr ranges)
                     (+ acc (sum-invalid-ids (car ranges) all-repeating-digits?))))))

(part2 (parse-input "input/day02-example.txt"))

