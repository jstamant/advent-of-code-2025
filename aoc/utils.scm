(define-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (parse-delim-input))

(define* (parse-delim-input filename #:optional (delim "\n"))
  (let ((port (open-file filename "r")))
    (let loop ((acc '()))
      (let ((line (read-delimited delim port)))
        (if (eof-object? line)
            acc
            (loop (append acc (list line))))))))
