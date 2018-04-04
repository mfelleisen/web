#lang racket

(provide
 
 problem:
 from
 to
 (rename-out (argmax maximize))
 (rename-out (argmin minimize))
 --
 -->
 node

 #%top-interaction
 #%datum 
 ; #%top
 
 (rename-out (parse-it #%module-begin)))

;; ---------------------------------------------------------------------------------------------------
;; DEPENDENCY

(require (for-syntax syntax/parse))
(require "network-lib.rkt")
(module+ test 
  (require rackunit))

;; ---------------------------------------------------------------------------------------------------
;; IMPLEMENTATION

;; -----------------------------------------------------------------------------
;; SYNTAX (compile time functions) 

;; 'keywords' for language 
(define problem: 0)
(define from     1)
(define to       2)
(define node     3)
(define --       4)
(define -->      5)

;; (parse-it problem: ...)
;; extracts a network and solves the specified problem 
(define-syntax (parse-it stx)
  (syntax-parse stx
    [(_ (~and stuff (~or e:id f:number)) ...)
     (define-values (statement remainder) (problem #'(stuff ...)))
     (define-values (network leftover) (nodes remainder))
     (define leftover-as-list (syntax->list leftover))
     (unless (null? leftover-as-list)
       (displayln leftover-as-list)
       (raise-syntax-error #f "foo" leftover))
     #`(#%module-begin
        (match-define    (list optimizer from to) #,statement)
        (define network  (from-edges-to-network #,@network))
        (define solution (optimized-path from to optimizer network))
        (match-define (list path weight) solution)
        (printf "The solution is the path ~a with a weight of ~a\n" path weight))]))

;; auxiliary functions for parsing a sequence of 'keywords' and numbers 

;; Syntax ->* #'(min-max Id Id), Syntax 
(define-for-syntax (problem e:stx)
  (syntax-parse e:stx
    #:literals (problem: from to)
    [(problem: min-max from F to T . remainder)
     (values #'`(,min-max F T) #'remainder)]))

;; Syntax -> #'[Listof (list Id Number Id)], Syntax 
(define-for-syntax (nodes e:stx)
  (syntax-parse e:stx
    #:literals (node -- -->)
    [(node F:id -- C:number --> T:id . rst)
     (define-values (network stuff) (nodes #'rst))
     (values (cons #''(F C T) network) stuff)]
    [other
     (values '() #'other)]))

;; -----------------------------------------------------------------------------
;; RUNTIME LIB 

;; (List Symbol Number Symbol) * -> Network
;; construct a network from the independently specified edges 
(define (from-edges-to-network . lo-stuff)
  (define from (map (λ (x) (cons (first x) '())) lo-stuff))
  (define to   (map (λ (x) (cons (third x) '())) lo-stuff))
  (define nodes:hash (make-hash (append from to)))
  (for ((edge lo-stuff))
    (match-define (list from weight to) edge)
    (hash-update! nodes:hash from (λ (old) (cons (Edge to weight) old))))
  (define lo-nodes (hash-map nodes:hash (lambda (NN edges) (cons NN (Node edges)))))
  (apply make-network lo-nodes))

(module+ test
  (define (sorted-hash h)
    (define h:list (hash->list h))
    (sort h:list string<=? #:key (compose symbol->string car)))
    
  (sorted-hash (from-edges-to-network '(a 10 b) '(a 20 c) '(b 20 d) '(c 20 d)))
  (sorted-hash 
   (make-hash `((a . ,(Node (list (Edge 'b 10) (Edge 'c 20))))
                (b . ,(Node (list (Edge 'd 20))))
                (c . ,(Node (list (Edge 'd 20))))
                (d . ,(Node '()))))))