; #lang reader network-lang.rkt ; provide read-syntax from network-lang
; #lang reader network ; additionally `raco pkg install` from network/
;#lang reader "network-lang2.rkt" ; add network/lang/reader.rkt that provides read-syntax

#lang network/gen-parser

;; uses network-lang.rkt (or network-lang2),
;; but has syntax of network-syn-lang.rkt

;; sample graph

problem: argmax from a to d 

node a -- 10 --> b
node a -- 20 --> c
node b -- 30 --> d
node c -- 30 --> d
