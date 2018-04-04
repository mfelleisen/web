#lang s-exp "stlc.rkt"
(require turnstile/rackunit-typechecking)

(typecheck-fail (->) #:with-msg "->:.*expected > 0 arguments")
(typecheck-fail (-> 1) #:with-msg "not a well-formed type.*1")
(typecheck-fail (-> Int 1) #:with-msg "not a well-formed type.*1")
(typecheck-fail (-> Int 1 Int) #:with-msg "not a well-formed type.*1")

(check-type 1 : Int -> 1)
(check-type -1 : Int -> -1)

(check-type #f : Bool -> #f)

(typecheck-fail (add1 #f) #:with-msg "expected Int, given Bool")
(check-type (add1 42) : Int -> 43)
(typecheck-fail (sub1 #f) #:with-msg "expected Int, given Bool")
(check-type (sub1 42) : Int -> 41)

(check-type (λ [x : Int] x) : (-> Int Int))

(check-type ((λ [x : Int] x) 1) : Int -> 1)

(check-type (λ [x : (-> Int Int)] x) : (-> (-> Int Int) (-> Int Int)))

(check-type ((λ [x : (-> Int Int)] x) (λ [x : Int] x)) : (-> Int Int))

(check-type ((λ [x : (-> Int Int)] x) add1) : (-> Int Int))

;; apply non-fn
(typecheck-fail (1 2) #:with-msg "Expected -> type, got: Int")

;; non-type annotation
(typecheck-fail (λ [x : 1] x) #:with-msg "not a well-formed type.*1")

;; these will fail if type-of does not return expanded expr
(check-type (λ [f : (-> Int Int)] (f 1)) : (-> (-> Int Int) Int))
(check-type
 (((λ [f : (-> Int Int)]
     (λ [x : Int]
       (f x)))
   add1) 20)
 : Int
 -> 21)


(check-type (if0 0 1 2) : Int -> 1)
(typecheck-fail (if0 #t 1 2)
 #:with-msg "if0: type mismatch: expected Int, given Bool")
(typecheck-fail (if0 1 #t 2)
 #:with-msg " type mismatch: expected Bool, given Int")

(check-type (λrec (f [x : Int] -> Int) x) : (-> Int Int))
(check-type (λrec (f [x : Int] -> Int) (f x)) : (-> Int Int))
(typecheck-fail (λrec (f [x : Int] -> Bool) x)
 #:with-msg "λrec: type mismatch: expected Bool, given Int")
(typecheck-fail (λrec (f [x : Int] -> Bool) (if0 x x x))
 #:with-msg "λrec: type mismatch: expected Bool, given Int")

(check-type ((λrec (f [x : Int] -> Int) (f x)) 1) : Int) ; non-term

(check-type
 ((λrec (f [x : Int] -> Bool) (if0 x #t (f (add1 x)))) -100)
 : Bool
 -> #t)

(check-type
 ((λ [f : (-> Int Int)] f)
  (λ x x))
 : (-> Int Int))
