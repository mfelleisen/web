#lang racket

(provide
 (all-from-out racket)
 node
 solve-problem
 (rename-out [argmax maximize])
 #%datum)

;; same as previous network-lang.rkt, but with syntax of network-syn-lang.rkt
;; parsed with a read-syntax fn

;; -----------------------------------------------------------------------------
;; DEPENDENCY

(require (for-syntax syntax/parse))
(require "network-lib.rkt")

;; -----------------------------------------------------------------------------
;; IMPLEMENTATION

;; -----------------------------------------------------------------------------
;; SYNTAX (compile time functions) 

(define-syntax (node stx)
  (syntax-parse stx
    [(_ from:id (to:id weight:number) ...)
     #'(begin (define from (cons 'from (Node (list (Edge (id to) weight) ...))))
              (update-pre from))]))

(define-syntax (solve-problem stx)
  (syntax-parse stx
    [(_ from:id to:id optimizer)
     #'(begin
         (update-network)
         (define solution (optimized-path (id from) (id to) optimizer network))
         (match-define (list path weight) solution)
         (printf "The solution is the path ~a with a weight of ~a\n" path weight))]))

(define-syntax-rule (id x) (begin x 'x))

;; -----------------------------------------------------------------------------
;; RUNTIME LIB 

(define pre-network '())
(define (update-pre new-node)
  (set! pre-network (cons new-node pre-network)))
  
(define network #false)
(define (update-network)
  (unless network
    (set! network (apply make-network pre-network))))
