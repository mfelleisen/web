#lang plai

(require test-engine/racket-tests)

;; structure type with data def.
(define-type Shape 
  (Circle (radius positive?))
  (Square (side positive?)))





;; data examples 
(define c (Circle 1))
(define s (Square 1))

;; @tech{Shape} -> @italic{Number} 

(check-within (area c) pi 0)
(check-expect (area s) 1)

(define (area s)
  (type-case Shape s
   [Circle (r) (* pi r r)]
   [Square (s) (* s s)]))

(test)

(area "hello")