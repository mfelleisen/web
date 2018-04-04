#lang racket

;; simply-typed core lang

;; e = ints | bools
;;   | x
;;   | add1 | sub1
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
 (rename-out [typed-datum #%datum]
             [typed-app #%app]
             [typed-λ λ])
 ;; other typed forms
 λrec if0
 ;; typed prims
 add1 sub1
 ;; types
 Int Bool ->
 ;; Racket basics
 #%module-begin #%top-interaction require)

(define-type Int)
(define-type Bool) ; no way to use them, but helpful for tests
(define-type-constructor -> #:arity > 0)

(define-syntax typed-datum
  (syntax-parser
    [(_ . n:integer)
     (assign-type #'(un:#%datum . n) #'Int)]
    [(_ . b:boolean)
     (assign-type #'(un:#%datum . b) #'Bool)]
    [(_ . (~and x (~fail "unsupported literal")))
     #'(void)]))

(define-typed-prim add1 un:add1 : (-> Int Int))
(define-typed-prim sub1 un:sub1 : (-> Int Int))

(define-syntax typed-app
  (syntax-parser
    [(_ f e)
     #:with (f+ (~-> tin tout)) (type-of #'f)
     #:with (e+ t) (type-of #'e)
     #:fail-unless (type=? #'t #'tin) (tyerr-msg #'tin #'t)
     (assign-type #'(un:#%app f+ e+) #'tout)]))
     
(define-syntax typed-λ
  (syntax-parser
    [(_ [x : τ:type] e)
     #:with (xs+ e+ τout) (type-of/ctx #'e #'([x τ]))
     (assign-type #'(un:λ xs+ e+) #'(-> τ τout))]))

(define-syntax λrec
  (syntax-parser
    [(_ (f [x (~datum :) τin:type] (~datum ->) τout) e)
     #:with ((f+ x+) e+ τ) (type-of/ctx #'e #'([f (-> τin τout)] [x τin]))
     #:fail-unless (type=? #'τ #'τout) (tyerr-msg #'τout #'τ)
     (assign-type #'(un:letrec ([f+ (un:λ (x+) e+)]) f+)
                  #'(-> τin τout))]))

(define-syntax if0
  (syntax-parser
    [(_ tst e1 e2)
     #:with (tst+ ~Int) (type-of #'tst)
     #:with (e1+ τ1) (type-of #'e1)
     #:with (e2+ τ2) (type-of #'e2)
     #:fail-unless (type=? #'τ1 #'τ2) (tyerr-msg #'τ1 #'τ2)
     (assign-type #'(un:if (un:zero? tst+) e1+ e2+) #'τ1)]))
