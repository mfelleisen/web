#lang racket/gui


;; this is an example plugin; it creates a new 
;; message in each drracket frame

(require "drracket-plugin.rkt")

(define (sample-mixin base%)
  (class base%
    (super-new)
    (new message% [parent this] [label "mixin added"])))

(send mixin-registry register sample-mixin)
