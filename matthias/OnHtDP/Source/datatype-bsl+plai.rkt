;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname datatype-bsl+plai) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require plai)

; structure type with data def.
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

