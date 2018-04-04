#lang racket (require redex)

(define-language Λ
  (e x
     (λ (x x) e)
     (e e)
     n
     (add1 e)
     (sub1 e)
     (if0 e e e))
  (x (variable-except add1 sub1 λ if0))
  (n natural)

  #:binding-forms
  (λ (f x) e #:refers-to f x))

(define example1
  (term ((λ (f n) (if0 n 1 (f (sub1 n)))) (add1 3))))

(define example1-div
  (term ((λ (f n) (if0 n 1 (f n))) (add1 3))))

(define example2
  (term ((λ (f n) (if0 n 1 (f (sub1 n)))) (λ (g x) g))))

;; -----------------------------------------------------------------------------
(define-extended-language λv Λ
  (v (λ (x x) e)
     n)
  (E hole
     (v ... E e ...)
     (if0 E e e)))

(define red
  (reduction-relation
   λv
   
   (==> ((λ (f x) e) v) (substitute (substitute e x v) f (λ (f x) e)) "βv")
   (==> (add1 n)        ,(+ (term n) 1)                              "add1")
   (==> (sub1 n)        ,(- (term n) 1)                              "sub1")
   (==> (if0 0 e_1 e_2) e_1                                          "if0t")
   (==> (if0 n e_1 e_2) e_2                                          "if0f"
        (side-condition (> (term n) 0)))

   with
   [(--> (in-hole E a) (in-hole E b)) (==> a b)]))

;; -----------------------------------------------------------------------------
(traces red example1-div)



(traces red example2)