#lang racket
(require (for-syntax syntax/parse)
         racket/syntax
         syntax/stx)

;; wish-list

;; A Term is a Stx
;; A Type is a Stx

(provide
 ; toplevel form that defines a type with the given name
 ; (define-type name)
 define-type
 ; assign-type : Term Type -> Term
 assign-type

 ; type-of : Term -> Type
 ; Returns the type of a given term.
 type-of

 ; type=? : Type Type -> Bool
 ; Returns true if two types are equal.
 type=?

 ; type->string : Type -> String
 ; Converts a Type to a string.
 type->string)

(define-syntax define-type
  (syntax-parser
    [(_ name:id)
     #'(define (name)
         (error 'name "can't use types at runtime"))]))

(define TYPE-TAG 'type)

(define (assign-type e t)
  (syntax-property e TYPE-TAG t))

(define (type-of e)
  (syntax-property
   (local-expand e 'expression null)
   TYPE-TAG))

; type=? : Type Type -> Boolean
(define (type=? t1 t2)
  (or (and (identifier? t1) (identifier? t2)
           (free-identifier=? t1 t2))
      (and (stx-pair? t1) (stx-pair? t2)
           (andmap type=? (syntax->list t1) (syntax->list t2)))))

; type->string : Type -> sexpr
(define (type->string t)
  (syntax->datum t))