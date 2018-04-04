#lang typed/racket

(provide
 Node
 Edge
 make-network

 Path
 Total

 optimized-path)

(: make-network ((Pairof NodeName Node) * -> Network))
(: optimized-path [NodeName NodeName Optimizer Network -> [List Path Total]])

(define-type Network  [Immutable-HashTable NodeName Node])
(define-type NodeName Symbol)
(struct Node [{reachable : [Listof Edge]}] #:transparent)
(struct Edge [{to : Symbol} {cost : Weight}] #:transparent)
(define-type Weight   Positive-Integer)

(define-type Optimizer [ [[List Path Total] -> Total]
                         (Listof [List Path Total])
                         ->
                         [List Path Total]])
(define-type Path      [Listof NodeName])
(define-type Total     Nonnegative-Integer)

;; -----------------------------------------------------------------------------
(define node-eq? eq?)

(define (make-network . lo-node)
  ((inst make-immutable-hash Symbol Node) lo-node))

(: lookup-node (NodeName Network -> Node))
(define (lookup-node nn nw)
  (hash-ref nw nn))

(define (optimized-path from0 to argmax nw)

  (: good-path [NodeName -> [List Path Total]])
  (define (good-path from)
    (cond
      [(node-eq? from to) (list `(,to) 0)]
      [else
       (define steps-to-neighbors (Node-reachable (lookup-node from nw)))
       (define nexts
         (for/list : [Listof (List Path Total)] ((e : Edge steps-to-neighbors))
           (match-define (Edge neighbor cost) e)
           (match-define (list full-path full-cost) (good-path neighbor))
           (list (cons from full-path) (+ cost full-cost))))
       (argmax second nexts)]))
  
  (good-path from0))
     
;; -----------------------------------------------------------------------------
(module+ test 

  (define node Node)
  (define edge Edge)


  ;; sample graph 
  (define a-edges (list (edge 'b 10) (edge 'c 20)))
  (define a-node  (node a-edges))
  (define x-edges (list (edge 'd 30)))
  (define b-node  (node x-edges))
  (define c-node  (node x-edges))
  (define d-node  (node '()))
  

  (define a-b-c-graph (make-network (cons 'a a-node) (cons 'b b-node) (cons 'c c-node)))

  (cons 'shortest: (optimized-path 'a 'd (inst argmin (List Path Total)) a-b-c-graph))
  (cons 'longest:  (optimized-path 'a 'd (inst argmax (List Path Total)) a-b-c-graph)))