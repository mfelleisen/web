#lang s-exp "silly-lang.rkt"

(define (count l)
  (cond
    [(empty? l) 0]
    [else (+ (count (rest l)) 1)]))

(define result (count '(a b c)))

(displayln `(the result is ,result))

