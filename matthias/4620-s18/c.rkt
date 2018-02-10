#lang racket

;; PROBLEM (∃! x .. y) determines whether exactly one of the values x .. y is
;; a non-#false value and produces this value; otherwise it produces #false

(module+ test (require rackunit))

;; Let's try this for ∃! of two pieces, i.e., (∃! x y). 

;; -----------------------------------------------------------------------------
;; Any Any -> Any 
;; only one of the two values is truish, pick that one 
(module+ test 
  (check-false (∃! #t #t))
  (check-false (∃! #f #f))
  (check-equal? (∃! 1 #f) 1)
  (check-equal? (∃! #f 1) 1))

(define (∃! v1 v2)
  (if v1 (and (not v2) v1) v2))

;; Now let's try to generalize to an arbitrary number of arguments. 

;; -----------------------------------------------------------------------------
;; Any ... -> Any
;; only one of all these values is truish, pick that one 

(module+ test 
  (check-false  (∃!* #t #t))
  (check-false  (∃!* #f #f))
  (check-equal? (∃!* 1 #f) 1)
  (check-equal? (∃!* 1 #f #f) 1)
  (check-false (∃!* 1 #f #f 2))
  (check-equal? (∃!* #f 1) 1))

(define (∃!* . args0)
  
  ;; [Listof Any] Any -> Any
  ;; SEEN have we seen any non-#false value 
  (define (aux args seen)
    (cond
      [(empty? args) seen]
      [else (define temp {(first args)})
            (if (and seen temp) #false (aux (rest args) (or temp seen)))]))
  
  ;; -- IN --
  (aux args0 #false))


;; Does this work as well as we want?

;; -----------------------------------------------------------------------------

(require (for-syntax syntax/parse))

(module+ test 
  (check-false  (∃!/s #t #t (displayln 1)))
  (check-false  (∃!/s #f #f (begin (displayln 2) #false)))
  (check-equal? (∃!/s #f #f (begin (displayln 3) 3)) 3)
  (check-equal? (∃!/s 1 #f) 1)
  (check-equal? (∃!/s #f 1) 1))

(define-syntax (∃!/s stx)
  (syntax-parse stx
    [(_ e1:expr ...) #'(∃!* (lambda () e1) ...)]))

