#lang racket
(require racket/syntax
         syntax/stx)

;; An Id is a Stx that is an identifier
;; A Term is a Stx
;; A Type is a Stx
;; A Datum is an S-expr

(provide ; i.e., my wish list

 ; assign-type : Term Type -> Term
 assign-type

 ; type-of : Term -> Type
 ; Returns the type of a given term.
 type-of

 ; type=? : Type Type -> Bool
 ; Returns true if two types are equal.
 type=?

 ; type->datum : Type -> Datum
 ; Converts a Type to a datum.
 type->datum

 ; tyerr-msg : Type Type -> String
 ; prints type err msg with given "expected" and "actual" types
 tyerr-msg

 ;; stx utils --------------------
 ;; equivalent to `stx-andmap`
 all ;; (all (-> Stx Bool) Stx) -> Bool
 )

(define TYPE-TAG 'type)

(define (assign-type e t)
  (syntax-property e TYPE-TAG t))

(define (get-type e)
  (syntax-property e TYPE-TAG))

(define (type-of e)
  (define e+ (local-expand e 'expression null))
  (get-type e+))

; type=? : Type Type -> Boolean
(define (type=? t1 t2)
      ;; type may be id
  (or (and (identifier? t1) (identifier? t2)
           (free-identifier=? t1 t2))
      ;; or compound type (ie, type constructor)
      (and (stx-pair? t1) (stx-pair? t2)
           (all type=? t1 t2))))

; type->datum : Type -> sexpr
(define (type->datum t)
  (syntax->datum t))

(define (tyerr-msg expected actual)
  (format "type mismatch, expected ~a, got ~a"
          (type->datum expected) (type->datum actual)))

;; stx utils --------------------

;; stx-andmap, with a shorter name
(define (all p? . stxs)
  (apply andmap p? (map syntax->list stxs)))
