#lang racket
(require (for-syntax syntax/parse
                     "typecheck.rkt"
                     rackunit))

; wish list
(provide
 ; (check-type Term : Type)
 ; fails if Term does not have type Type
 check-type

 ; A Msg is a String
 
 ; (typecheck-fail Term Msg)
 ; test passes if typechecking the term fails with the given msg
 typecheck-fail)

(define-syntax check-type
  (syntax-parser
    [(_ e (~datum :) expected)
     #:with actual (type-of #'e)
     #:fail-unless (type=? #'actual #'expected) (tyerr-msg #'expected #'actual)
     #'(void)]))

(define-syntax typecheck-fail
  (syntax-parser
    [(_ e #:with-msg m:string)
     (check-exn (pregexp (syntax->datum #'m))
                (λ () (type-of #'e)))
     #'(void)]))
