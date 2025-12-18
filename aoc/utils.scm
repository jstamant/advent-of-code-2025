(define-module (aoc utils)
  #:use-module (ice-9 rdelim)
  #:export (parse-delim-input))

(define* (parse-delim-input port #:optional (delim "\n"))
  (let loop ((acc '()))
    (let ((line (read-delimited delim port)))
      (if (eof-object? line)
          acc
          (loop (append acc (list line)))))))

