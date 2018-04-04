#lang racket

;; -----------------------------------------------------------------------------
(module server racket

  (provide
   require
   submod
   define
   #%app
   #%top
   #%datum
   +
   
   (rename-out (show-me #%module-begin)))

  (require (for-syntax syntax/parse))

  (define-syntax (show-me stx)
    (syntax-parse stx 
      [(_ e ...)
       (with-syntax ([(i ...) (numbered #'(e ...))])
         #'(#%module-begin (begin (printf "evaluating top-level form ~a\n" i) e) ...))]))

  (define-for-syntax (numbered e-s:stx)
    (define e-s:lst (syntax->list e-s:stx))
    (for/list ((e e-s:lst) (i (in-naturals)))
      i)))


;; -----------------------------------------------------------------------------
(module client (submod ".." server)

  (define (f x)
   (+ x 42))

  (f 21)

  (f (+ 1 1)))

(require (submod "." client))