#lang racket

;; non-constant compile-time functions 

(define-syntax (h stx)
  (define n (length (syntax->list stx)))
  #`#,n)