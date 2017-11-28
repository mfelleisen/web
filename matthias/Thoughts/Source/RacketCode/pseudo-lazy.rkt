#lang racket

(provide #%module-begin #%datum #%top-interaction
         ; [except-out (all-from-out racket) #%app + - * /]
         define lambda ; quasiquote unquote lambda 
         [rename-out (application #%app) (add +) (sub -) (mul *) (div /)])

(define-syntax-rule
  (application function-position argument ...)
  (function-position (lambda () argument) ...))

(define (strictify f)
  (lambda args (apply f (map force* args))))

(define (force* th)
  (if (procedure? th) (force* (th)) th))

(define add (strictify +))
(define sub (strictify -))
(define mul (strictify *))
(define div (strictify /))
