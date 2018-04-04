#lang racket

(require (for-syntax syntax/parse))

(module+ test (require rackunit))

;; PROBLEM Suppose we encode structs as lists that have an identifying string
;; in the first position. Let's figure out a syntactic construct that extracts
;; the remaining fields and names them for a single expression.

;; GRAMMAR (smatch e [(tag1 x1 ...) e1] ...)

(module+ test
  (check-equal?
   (smatch '("hello" 1) [("hello" x y) (+ x y)] [("hello" x) (* 100 x)])
   100))












































(define-syntax (smatch stx)
  (syntax-parse stx
    [(_ e:expr [(tag1:str x1-1:id ...) e1] ...)
     #'(let* ([val e]
              [_ (unless (and (list? val) (cons? val))
                   (error 'smatch "expected a list, given: ~e" val))]
              [tag (first val)]
              [_ (unless (string? tag)
                   (error 'smatch "expected a string, given: ~e" tag))]
              [rst (rest val)]
              [nnn (length rst)])
         (cond
           [(and (string=? tag1 tag) (= (length '(x1-1 ...)) nnn))
            (apply (lambda (x1-1 ...) e1) rst)]
           ...))]))