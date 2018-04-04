#lang racket

;; what does the argument represent

(define-syntax (g stx)
  (displayln stx)
  #'5)
