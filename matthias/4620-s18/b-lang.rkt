#lang racket

;; -----------------------------------------------------------------------------

(provide
  require
  submod
  define
  #%app
  #%top
  #%datum
  +

  #%top-interaction

  (rename-out (show-me #%module-begin)))

;; -----------------------------------------------------------------------------
;; IMPLEMENTATION

(require (for-syntax syntax/parse))

;; --------------------------------------------
;; SYNTAX 

(define-syntax (show-me stx)
  (syntax-parse stx 
    [(_ e ...)
     (with-syntax ([(i ...) (numbered #'(e ...))])
       #'(#%module-begin (begin (printf "evaluating top-level form ~a\n" i) e) ...))]))

(define-for-syntax (numbered e-s:stx)
  (define e-s:lst (syntax->list e-s:stx))
  (for/list ((e e-s:lst) (i (in-naturals)))
    i))
