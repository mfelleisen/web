#lang typed/racket

(require "network-lib.rkt")

(define node Node)
(define edge Edge)

;; sample graph 
(define a-edges (list (edge 'b 10) (edge 'c 20)))
(define a-node  (node a-edges))
(define x-edges (list (edge 'd 30)))
(define b-node  (node x-edges))
(define c-node  (node x-edges))
(define d-node  (node '()))

(define a-b-c-graph (make-network (cons 'a a-node) (cons 'b b-node) (cons 'c c-node)))

(cons 'shortest: (optimized-path 'a 'd (inst argmin (List Path Total)) a-b-c-graph))
(cons 'longest:  (optimized-path 'a 'd (inst argmax (List Path Total)) a-b-c-graph))