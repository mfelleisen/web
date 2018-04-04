#lang turnstile/quicklang

;; simply-typed core lang
;; - implemented using Turnstile

;; e = ints | bools
;;   | x
;;   | add1 | sub1
;;   | λ
;;   | #%app
;;   | if0
;;   | λrec

;; common unicode chars:
;; \vdash = ⊢
;; \gg = ≫
;; \rightarrow = →
;; \Rightarrow = ⇒
;; \Leftarrow = ⇐
;; \succ = ≻

(require (prefix-in un: racket)
         (prefix-in lc: "lc.rkt"))

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
 Int Bool ->)

(define-base-type Int)
(define-base-type Bool) ; no way to use them, but helpful for tests
(define-type-constructor -> #:arity > 0)

(define-primop add1 un:add1 : (-> Int Int))
(define-primop sub1 un:sub1 : (-> Int Int))

#;(define-syntax typed-datum
  (syntax-parser
    [(_ . n:integer)
     (assign-type #'(un:#%datum . n) #'Int)]
    [(_ . b:boolean)
     (assign-type #'(un:#%datum . b) #'Bool)]
    [(_ . (~and x (~fail "unsupported literal")))
     #'(void)]))

(define-syntax/typecheck typed-datum
  [(_ . n:integer) ≫
   --------------------------
   [⊢ (lc:#%datum . n) ⇒ Int]]
  [(_ . b:boolean) ≫
   --------------------------
   [⊢ (lc:#%datum . b) ⇒ Bool]]
  [(_ . x) ≫
   ---------
   [#:error (type-error #:src #'x #:msg "Unsupported literal: ~v" #'x)]])

#;(define-syntax typed-app
  (syntax-parser
    [(_ f e)
     #:with (f+ (~-> tin tout)) (infer+erase #'f)
     #:with (e+ t) (infer+erase #'e)
     #:fail-unless (type=? #'t #'tin) (typecheck-fail-msg/1 #'tin #'t #'e)
     (assign-type #'(un:#%app f+ e+) #'tout)]))

(define-syntax/typecheck typed-app
  [(_ f e) ≫
   [⊢ f ≫ f+ ⇒ (~-> tin tout)]
   [⊢ e ≫ e+ ⇐ tin]
   ----------------
   [⊢ (lc:#%app f+ e+) ⇒ tout]])
  
     
#;(define-syntax typed-λ
  (syntax-parser
    [(_ [x : τ:type] e)
     #:with (xs+ e+ τout) (infer/ctx+erase #'([x τ]) #'e)
     (assign-type #'(un:λ xs+ e+) #'(-> τ τout))]))

(define-syntax/typecheck typed-λ
  [(_ x:id e) ⇐ (~-> t1 t2) ≫ ; check type clause
   [[x ≫ x+ : t1] ⊢ e ≫ e+ ⇐ t2]
   -------------------------
   [⊢ (lc:λ x+ e+)]]
  [(_ [x:id : τ:type] e) ≫     ; compute type clause
   [[x ≫ x+ : τ] ⊢ e ≫ e+ ⇒ τout]
   ------------------------------
   [⊢ (lc:λ x+ e+) ⇒ (-> τ τout)]])

#;(define-syntax λrec
  (syntax-parser
    [(_ (f [x (~datum :) τin:type] (~datum ->) τout:type) e)
     #:with ((f+ x+) e+ τ) (infer/ctx+erase
                            #'([f : (-> τin τout)] [x : τin]) #'e)
     #:fail-unless (type=? #'τ #'τout.norm) (typecheck-fail-msg/1
                                             #'τout #'τ #'e)
     (assign-type #'(un:letrec ([f+ (un:λ (x+) e+)]) f+)
                  #'(-> τin τout))]))

(define-syntax/typecheck (λrec (f [x (~datum :) τin:type] (~datum ->) τout) e) ≫
  [[x ≫ x+ : τin] [f ≫ f+ : (-> τin τout)] ⊢ e ≫ e+ ⇐ τout]
  ------------------------------
  [⊢ (lc:λrec (f+ x+) e+) ⇒ (-> τin τout)])

#;(define-syntax if0
  (syntax-parser
    [(_ tst e1 e2)
     #:with (tst+ t) (infer+erase #'tst)
     #:fail-unless (Int? #'t) (typecheck-fail-msg/1 #'Int #'t #'tst)
     #:with (e1+ τ1) (infer+erase #'e1)
     #:with (e2+ τ2) (infer+erase #'e2)
     #:fail-unless (type=? #'τ1 #'τ2) (typecheck-fail-msg/1 #'τ1 #'τ2 #'e2)
     (assign-type #'(un:if (un:zero? tst+) e1+ e2+) #'τ1)]))

(define-syntax/typecheck (if0 tst e1 e2) ≫
  [⊢ tst ≫ tst+ ⇐ Int]
  [⊢ e1 ≫ e1+ ⇒ τ]
  [⊢ e2 ≫ e2+ ⇐ τ]
  ----------------
  [⊢ (lc:if0 tst+ e1+ e2+) ⇒ τ])
