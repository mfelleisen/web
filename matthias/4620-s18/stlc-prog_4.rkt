#lang s-exp "stlc.rkt"
(require "typecheck-testing.rkt")

(check-type 5 : Int)
(check-type #t : Bool)

(check-type (add1 42) : Int)
(typecheck-fail (add1 #f) #:with-msg "type mismatch")

(check-type add1 : (-> Int Int))