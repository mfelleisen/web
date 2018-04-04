#lang s-exp "network-lang.rkt"

;; sample graph 
(node d)
(node c (d 30))
(node b (d 30))
(node a (b 10) (c 20))

(solve-problem a d argmin)
(solve-problem a d argmax)
