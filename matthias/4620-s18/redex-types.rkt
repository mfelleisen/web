#lang racket
(require redex)

(define-language Λ
  (e x
     (λ ({x t} {x t}) e)
     (e e)
     n
     (add1 e)
     (sub1 e)
     (if0 e e e))

  (t int
     (t -> t))

  (x (variable-except λ + if0))
  (n natural)

  #:binding-forms
  (λ (f x) e #:refers-to f x))

(define example1
  (term ((λ ({f (int -> int)} {n int}) (if0 n 1 (f n))) (add1 3))))

(define example2
  (term ((λ ({f (int -> int)} {n int}) (if0 n 1 (f n))) (λ ({g (int -> int)} {x int}) g))))

;; -----------------------------------------------------------------------------

(define-extended-language λt Λ
  (G ((x t) ...)))

(define-judgment-form λt
  #:mode (⊢ I I O)
  #:contract (⊢ G e t)

  [(where ((x_!_ t_1) ... (x t) (x_!_ t_2) ...) G)
   -----------------------------------------------
   (⊢ G x t)         ]

  [(⊢ ((x t_dom) (f (t_dom -> t_rng)) (x_1 t_1) ...) e t_rng)
   ---------------------------------------------------------------------------
   (⊢ ((x_1 t_1) ...) (λ ({f (t_dom -> t_rng)} {x t_dom}) e) (t_dom -> t_rng))]

  [(⊢ G e_fun (t_dom -> t_rng))
   (⊢ G e_arg t_dom)
   ---------------------------------------------------------------------------
   (⊢ G (e_fun e_arg) t_rng)]

  [
   -----------------------------------------------
   (⊢ G n int)         ]
  
  [(⊢ G e_con int)
   (⊢ G e_thn t)
   (⊢ G e_els t)
   ---------------------------------------------------------------------------
   (⊢ G (if0 e_con e_thn e_els) t)]

  [(⊢ G e int)
   ---------------------------------------------------------------------------
   (⊢ G (add1 e) int)])

(judgment-holds (⊢ ((x int)) x int))
(judgment-holds (⊢ () (λ ({f (int -> int)} {x int}) x) (int -> int)))
(judgment-holds (⊢ () (λ ({f (int -> int)} {x int}) (f x)) (int -> int)))
(judgment-holds (⊢ () (λ ({f (int -> int)} {x int}) (if0 x (f x) x)) (int -> int)))
(judgment-holds (⊢ () (λ ({f (int -> int)} {x int}) (if0 x (add1 x) x)) (int -> int)))

(judgment-holds (⊢ () ,example1 int))
(not (judgment-holds (⊢ () ,example2 (int -> int))))

;; -----------------------------------------------------------------------------
(define-extended-language λv Λ
  (v (λ ({x t} {x t}) e)
     n)
  (E hole
     (v ... E e ...)
     (if0 E e e)))

(define red
  (reduction-relation
   λv
   (==> (add1 n)                    ,(+ (term n) 1) "add1")
   (==> (if0 0 e_1 e_2)             e_1 "if0t")
   (==> (if0 n e_1 e_2)             e_2 "if0f" (side-condition (> (term n) 0)))
   (==> ((λ ({f t_f} {x t_x}) e) v) (substitute (substitute e x v) f (λ ({f t_f} {x t_x}) e)) "βv")

   with
   [(--> (in-hole E a) (in-hole E b)) (==> a b)]))

;; -----------------------------------------------------------------------------
(traces red example1)