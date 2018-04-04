#lang racket

;; what other attributes do syntax objects come with? 

(define-syntax (i stx)
  (define l (syntax-line stx))
  (define c (syntax-column stx))
  #`(list "line and column info" #,l #,c))
