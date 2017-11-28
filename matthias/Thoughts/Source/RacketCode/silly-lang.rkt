#lang racket

(provide (rename-out (count-forms #%module-begin)))

(define-syntax-rule
  (count-forms mexpr ...)
  (#%module-begin `(the module contains ,(length '(mexpr ...)) forms)))
