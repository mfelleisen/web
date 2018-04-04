;#lang s-exp "network-syn-lang.rkt"
#lang reader "network-syn-lang.rkt"
;#lang reader "network-lang-regexp-parser.rkt"
;#lang network/regexp-parsed
;#lang network/lexed
;#lang network/gen-parser
;#lang network/reader-extended

;; sample graph

problem: maximize from a to d 

node a -- 10 --> b
node a -- 20 --> c
node b -- 30 --> d
node c -- 30 --> d
