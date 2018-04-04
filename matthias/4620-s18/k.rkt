#lang racket

(require (for-syntax syntax/parse))

;; (block x Expression-1 Expression-2)
;; ==>
;; (let ((x Expression-1)) Expression-2)
(define-syntax (block stx)
  (syntax-parse stx
    [;; recognize a pattern 
     (_ lhs rhs body)

     ;; generate code
     #'(let ((lhs rhs)) body)]))