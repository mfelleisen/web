#lang racket

(module+ test
  (require rackunit))

;; -----------------------------------------------------------------------------
;; Term 
;; e = x | (λ {f t} {x t}.e) | (e e)
;;   | '0 | '1 ... | (add1 e) | (sub1 e)
;;   | (if0  e e e) )


;; Type
;;  t = Int | (t -> t)

;; Type Context G = [Listof [List x t]]

;; -----------------------------------------------------------------------------
;; Term -> Boolean
;; dpes the given term type check?

(module+ test
  (check-false (TC 'x))
  (check-false (TC '(λ ({f Int} {x Int}) f)))
  (check-false (TC '(add1 sub1)))

  (check-true (TC '(sub1 0)))

  (check-true (TC '(λ ({f (Int -> Int)} {x Int}) x)))
  (check-true (TC '((λ ({f (Int -> Int)} {x Int}) x) 0)))
  (check-true (TC '((λ ({f (Int -> Int)} {x Int}) (add1 x)) 0)))
  (check-true (TC '((λ ({f (Int -> Int)} {x Int}) (sub1 x)) 0)))
  (check-true (TC '((λ ({f (Int -> Int)} {x Int}) (if0 (sub1 x) x x)) 0)))
  (check-true (TC '(λ ({f (Int -> Int)} {x Int}) (f x)))))

(define (TC term0)

  (define G0 (type-declare '(add1 (Int -> Int))
                           (type-declare '(sub1 (Int -> Int))
                                         (type-G0))))
    
  ;; TypeContext Term -> Type or #false
  ;; ACCUMULATOR G contains all λ type declarations on path from term0 to term 
  (define (TC G term)
    (match term
      [(? symbol?)
       (type-lookup term G)]
      [`(λ ({,f ,tf} {,par ,tpar}) ,body)
       (define Gnew  (type-declare `(,f ,tf) (type-declare `(,par ,tpar) G)))
       (define tbody (TC Gnew body))
       (and tbody (type-equal? `(,tpar -> ,tbody) tf) tf)]
      [`(,fun ,arg)
       (define tfun (TC G fun))
       (define targ (TC G arg))
       (match tfun
         [`(,tdom -> ,trng) (and targ (type-equal? targ tdom) trng)]
         [_ #false])]
      [(? natural-number/c)
       'Int]
      [`(if0 ,con ,thn ,els)
       (define tcon (TC G con))
       (define tthn (TC G thn))
       (define tels (TC G els))
       (and tcon (type-equal? 'Int tcon) (type-equal? tthn tels) tthn)]
      [else (error 'TC "(can't happen) no match: ~e" term)]))

  (define type-of-term0 (TC G0 term0))
  
  (not (boolean? type-of-term0)))

;; -----------------------------------------------------------------------------
;; TYPE CONTEXTS and TYPES 

(define (type-G0) '())

;; [List Symbol Type] TypeContext -> TypeContext 
(define (type-declare xt G)
  (cons xt G))

;; Symbol TypeContext -> Type or #false 
(define (type-lookup x G)
  (define result (assq x G))
  (and result (second result)))

;; Type Type -> Boolean
(define type-equal? equal?)