#lang racket

;; -----------------------------------------------------------------------------

(provide

 define-syntax
 (for-syntax syntax)
 (for-syntax syntax-parse)

 define
 #%app
 #%top
 #%datum
 +

 #%top-interaction
 (rename-out (show-me #%module-begin)))

;; -----------------------------------------------------------------------------
(require (for-syntax syntax/parse))
(require (for-syntax syntax/kerncase))

;; --------------------------------------------
;; RUN-TIME 

(define N 0)
;; -> VOID
;; EFFECTS: 
(define (inc)
  (set! N (+ N 1))
  (printf "evaluating top-level form ~a\n" N))

;; --------------------------------------------
;; SYNTAX

(define-syntax (#%top-interaction stx)
  (syntax-parse stx
    [(_ . f) #`(begin (inc) f)]))

(define-syntax (show-me stx)
  (syntax-parse stx 
    [(_ e ...)
     #`(#%module-begin
	 ;; now add the code for the
	 (countable-top e) ...)]))

(define-syntax (countable-top stx)
  (syntax-parse stx
    [(_ e)
     (define f (local-expand #'e (syntax-local-context) (kernel-form-identifier-list)))
     (displayln f)
     (syntax-parse f
       #:literal-sets (kernel-literals)
       [(define-values ids rhs)
	f]
       [(~or define-syntaxes module #%provide #%require)
	f]
       [expr
	 #`(begin (inc) #,f)])]))
