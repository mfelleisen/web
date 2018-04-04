#lang racket
(require (for-syntax (for-syntax racket/base
                                 syntax/parse)
                     syntax/parse
                     racket/syntax
                     "typecheck.rkt"))

(provide
 ; toplevel forms --------------------

 ; (define-type name)
 ; defines a base type (at phase n) with the given `name`, and
 ; - a phase n+1 predicate that recognizes the type
 ; - a phase n+1 pattern expander that recognizes the type
 define-type
)

(define-syntax define-type
  (syntax-parser
    [(_ name:id)
     #:with typename? (mk-? #'name)
     #:with patmacro (mk-~ #'name)
     #'(begin
         (define (name)
           (error 'name "can't use types at runtime"))
         (begin-for-syntax
           (define (typename? t) (type=? t #'name))
           (define-syntax patmacro
             (pattern-expander
              (syntax-parser
                [(~var _ id)
                 #'(~and ty
                         (~fail #:unless (typename? #'ty)
                                (tyerr-msg #'name #'ty)))]
                [(_ . rst)
                 #'((~and ty
                          (~fail #:unless (typename? #'ty)
                                 (tyerr-msg #'name #'ty)))
                    . rst)])))))]))

;; stx helper fns
(begin-for-syntax
  (define (mk-? id) (format-id id "~a?" id))
  (define (mk-~ id) (format-id id "~~~a" id)))
