#lang racket

;; how to generate new code: 

(require (for-syntax racket/list))

;; (block x Expression-1 Expression-2)
;; ==>
;; (let ((x Expression-1)) Expression-2)
(define-syntax (block stx)
  (define expr (syntax-e stx))
  (define lhs  (second expr))
  (define rhs  (third expr))
  (define body (fourth expr))
  ;; --- in --- 
  (define code (list 'let (list (list lhs rhs)) body))
  (datum->syntax stx code))