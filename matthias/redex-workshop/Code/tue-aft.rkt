#lang racket

(provide
 ;; language 
 TLambda-tc
 
 ;; (extend Γ (x t) ...) add (x t) to Γ so that x is found before other x-s
 extend
 
 ;; (lookup Γ x) retrieves x's type from Γ
 lookup)

(require redex)

;; -------------------------------------------------------
(define-language TLambda
  (e ::=
     n
     +
     x
     (lambda ((x_!_ t) ...) e)
     (e e ...))
  (n ::= natural)
  (t ::=
     int
     (t ... -> t))
  (x ::= variable-not-otherwise-mentioned))

(define in-TLambda? (redex-match? TLambda e))

(define e1
  (term (lambda ((x int) (f (int -> int))) (+ (f (f x)) (f x)))))
(define e2
  (term (lambda ((x int) (f ((int -> int) -> int))) (f x))))

(define e3
  (term (lambda ((x int) (x (int -> int))) x)))

(module+ test
  (test-equal (in-TLambda? e1) #true)
  (test-equal (in-TLambda? e2) #true)
  (test-equal (in-TLambda? e3) #false))

;; -----------------------------------------------------------------------------
;; (⊢ Γ e t) -- the usual type judgment for an LC language

(define-extended-language TLambda-tc TLambda
  (Γ ::= ((x t) ...)))

(module+ test
  (test-equal (judgment-holds (⊢ () ,e1 t) t)
              (list (term (int (int -> int) -> int))))
  
  ;; a failure -- no types are returned 
  (test-equal (judgment-holds (⊢ () ,e2 t) t) '()))

(define-judgment-form TLambda-tc
  #:mode (⊢ I I O)
  #:contract (⊢ Γ e t)
  [----------------------- "number"
   (⊢ Γ n int)]
  
  [----------------------- "+"
   (⊢ Γ + (int int -> int))]
  
  [----------------------- "variable"
   (⊢ Γ x (lookup Γ x))]
  
  [(⊢ (extend Γ (x_1 t_1) ...) e t)
   ------------------------------------------------- "lambda"
   (⊢ Γ (lambda ((x_1 t_1) ...) e) (t_1 ... -> t))]
  
  [(⊢ Γ e_1 (t_2 ..._n -> t))
   (⊢ Γ e_2 t_2) ...
   ------------------------------------------------- "application"
   (⊢ Γ (e_1 e_2 ..._n) t)])

;; -----------------------------------------------------------------------------
;; (extend Γ (x t) ...) add (x t) to Γ so that x is found before other x-s

(module+ test
  (test-equal (term (extend () (x int))) (term ((x int)))))

(define-metafunction TLambda-tc
  extend : Γ (x any) ... -> any
  [(extend ((x_Γ any_Γ) ...) (x any) ...) ((x any) ...(x_Γ any_Γ) ...)])

;; -----------------------------------------------------------------------------
;; (lookup Γ x) retrieves x's type from Γ

(module+ test
  (test-equal (term (lookup ((x int) (x (int -> int)) (y int)) x)) (term int))
  (test-equal (term (lookup ((x int) (x (int -> int)) (y int)) y)) (term int)))

(define-metafunction TLambda-tc
  lookup : any x -> any
  [(lookup ((x_1 any_1) ... (x any_t) (x_2 any_2) ...) x)
   any_t
   (side-condition (not (member (term x) (term (x_1 ...)))))]
  [(lookup any_1 any_2)
   ,(error 'lookup "not found: ~e in: ~e" (term any_1) (term any_2))])

;; -----------------------------------------------------------------------------

(define ->
  (reduction-relation
   TLambda
   #:domain e
   (--> e (lambda ((x int)) x))))

;; wouldn't it be lovely if the following worked 
#;
(redex-check TLambda
             #:satisfying (⊢ () e t)
             ;; run for n steps, recheck type 
             (displayln (term e))
             #:attempts 3)

(module+ test
  (traces ->
          (term (((lambda ((x (int -> int))) x) (lambda ((x int)) x)) 1))
          ; "../subject-reduction.ps"
          #:pred (lambda (e)
                   (judgment-holds (⊢ () ,e int)))))


;; -----------------------------------------------------------------------------
(module+ test
  (test-results))
