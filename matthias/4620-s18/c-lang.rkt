#lang racket

;; -----------------------------------------------------------------------------

(provide
  define
  #%app
  #%top
  #%datum
  +
   
  (rename-out (show-me #%module-begin)))

;; -----------------------------------------------------------------------------
;; IMPLEMENTATION

(require (for-syntax syntax/parse))

;; --------------------------------------------
;; RUN-TIME ENVIRONMENT 

;; -> Void
;; EFFECT increment N
;; EFFECT print a line that says which top-level form has been printed 
(define N 0)
(define (inc)
  (set! N (+ N 1))
  (printf "evaluating top-level form ~a\n" N))

;; --------------------------------------------
;; SYNTAX 

(define-syntax (show-me stx)
  (syntax-parse stx 
    [(_ e ...) #'(#%module-begin (begin (inc) e) ...)]))

