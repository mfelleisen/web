#lang racket

(define *global-list '(1 2 3))

(for/list ((i *global-list)) i)

(for/sum ((i *global-list)) i)







(require (for-syntax syntax/parse))
