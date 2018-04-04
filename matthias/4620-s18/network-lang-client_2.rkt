#lang s-exp "network-lang.rkt"

;; sample graph 
(node a (b 10) (c 20))
(node b (d 30))
(node c (d 30))
(node d)

(solve-problem a d argmin)
(solve-problem a d argmax)