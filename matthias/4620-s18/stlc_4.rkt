#lang racket
(require (for-syntax syntax/parse
                     "typecheck.rkt")
         "typecheck.rkt"
         (prefix-in un: racket))
(provide (rename-out [typed-datum #%datum])
         add1
         Int Bool ->
         #%module-begin #%top-interaction require)
;; e = ints
;;   | x
;;   | add1 sub1
;;   | λ
;;   | #%app
;;   | if0
;;   | λrec

(define-type Int)
(define-type Bool)
(define-type ->)

(define-syntax typed-datum
  (syntax-parser
    [(_ . n:integer)
     (assign-type #'(un:#%datum . n) #'Int)]
    [(_ . b:boolean)
     (assign-type #'(un:#%datum . b) #'Bool)]
    [(_ . x)
     (raise-syntax-error #f "unsupported literal" #'x)
     #'(void)]))

(define-syntax add1
  (syntax-parser
    [f:id
     (assign-type #'un:add1 #'(-> Int Int))]
    [(_ e)
     #:with t (type-of #'e)
     #:fail-unless (type=? #'t #'Int)
     (format "type mismatch, expected Int, got ~a"
             (type->string #'t))
     (assign-type #'(un:#%app un:add1 e) #'Int)]))