#lang racket
(require (for-syntax syntax/parse)
         (prefix-in r: racket))

(provide λ λrec #%app #%datum if0 ; core forms
         add1 sub1                ; prims
         #%module-begin           ; other
         #%top-interaction)

;; An id is an Identifier

;; An expression (e) is one of:
;; - Ints
;; - Bools
;; - prim fns: add1 sub1
;; - (λ id e)
;; - (λrec (id id) e)
;; - (#%app e e)
;; - (if0 e e e)

(define-syntax (λ stx)
  (syntax-parse stx
    [(_ x e)
     #'(r:λ (x) e)]))

(define-syntax (#%app stx)
  (syntax-parse stx
    [(_ f e)
     #'(r:#%app f e)]))

(define-syntax (#%datum stx)
  (syntax-parse stx
    [(_ . (~or x:integer x:boolean))
     #'(r:#%datum . x)]
    [(_ . x) (raise-syntax-error 'datum "unsupported literal" #'x)]))

(define-syntax (λrec stx)
  (syntax-parse stx
    [(_ (f x) e)
     #'(r:letrec ([f (r:λ (x) e)]) f)]))

(define-syntax (if0 stx)
  (syntax-parse stx
    [(_ tst e1 e2)
     #'(r:if (r:zero? tst) e1 e2)]))
