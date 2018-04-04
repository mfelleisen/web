#lang racket

;; simply-typed core lang

;; (at end of lecture Tues 2018-02-20)

;; e = ints, bools
;;   | x
;;   | add1 sub1
;;   | λ
;;   | #%app
;;   | if0
;;   | λrec

(require (for-syntax syntax/parse
                     "typecheck.rkt")
         "typecheck-forms.rkt"
         (prefix-in un: racket))
(provide
 ;; override interposition points with typed versions
 (rename-out [typed-datum #%datum])
 ;; prims
 add1
 ;; types
 Int Bool ->
 ;; Racket basics
 #%module-begin #%top-interaction require)


(define-type Int)
(define-type Bool)
(define-type ->)


(define-syntax typed-datum
  (syntax-parser
    [(_ . n:integer)
     (assign-type #'(un:#%datum . n) #'Int)]
    [(_ . b:boolean)
     (assign-type #'(un:#%datum . b) #'Bool)]
    [(_ . (~and x (~fail "unsupported literal")))
     #'(void)]))

(define-syntax add1
  (syntax-parser
    [:id (assign-type #'un:add1 #'(-> Int Int))]
    [(_ e)
     #:with ~Int (type-of #'e)
     (assign-type #'(un:#%app un:add1 e) #'Int)]))
