#lang s-exp "network-syn-lang.rkt"

;; sample graph

problem: maximize from a to d 

node a -- 10 --> b
node a -- 20 --> c
node b -- 30 --> d
node c -- 30 --> d