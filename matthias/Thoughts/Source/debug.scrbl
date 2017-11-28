#lang scribble/base

@(require racket/sandbox scribble/eval)

@(define LAZY "RacketCode/pseudo-lazy.rkt")

@(define-syntax sexp-eval
   (syntax-rules ()
     [(_ d ...)
      (let ()
        (define me
          (parameterize ([sandbox-output 'string]
                         [sandbox-error-output 'string])
            (make-module-evaluator `(module m ,LAZY) #:allow-read `((file ,LAZY)))))
        me)]))

@interaction[
 #:eval (sexp-eval (define x 1))
((lambda (x) 42) 
 ((lambda (x) (x x)) 
  (lambda (x) (x x))))
]
