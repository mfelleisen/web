;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bsl-dt) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; structure type definitions 
(define-struct circle (radius))
(define-struct square (side))

;; data definition
;; A @deftech{Shape} is one of: 
;; -- @racket[(make-circle #, @italic{Positive})]
;; -- @racket[(make-square #, @italic{Positive})]

;; data examples 
(define c (make-circle 1))
(define s (make-square 1))

;; @tech{Shape} -> @italic{Number} 

(check-within (area c) pi 0)
(check-expect (area s) 1)

(define (area s)
  (cond
    [(circle? s) 
     (* pi (circle-radius s)
           (circle-radius s))]
    [(square? s) 
     (* (square-side s)
        (square-side s))]))
