#lang racket

;; how to generate new code: 

(require (for-syntax racket/list))

(define-syntax (world stx)
  (define expr (syntax-e stx))
  (define iden (second expr))
  (define code (list 'define iden "hello world, how are you?"))
  (datum->syntax stx code))
