#lang s-exp "pseudo-lazy.rkt"

(define (f x y)
  (/ (- (* (+ x 10) 3) 2) 2))

(f 10 (/ 1 0))