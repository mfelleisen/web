#lang racket

;; a regexp parser for network-lang

(provide read-syntax read)

;; parsing ------------------------------------------------------------
(define (read-syntax src port)
  (datum->syntax #f (parse port)))

(define (read port)
  (parse port))

;; matches "problem: <opt-fn> from <start node> to <end node>"
(define *problem-rx*
  (pregexp
   (string-append
    "problem:\\s+"
    "(\\w+)\\s+"  ; optimizing fn
    "from\\s+"
    "(\\w+)\\s+"  ; path start
    "to\\s+"
    "(\\w+)\\s+"  ; path end
    )))
;; matches "node <from> -- <weight> --> <to>
(define *edge-rx*
  (pregexp
   (string-append
    "node\\s+"
    "(\\w+)\\s+"   ; edge from
    "--\\s+"
    "(\\d+)\\s+"   ; edge weight
    "-->\\s+"
    "(\\w+)\\s+"   ; edge to
    )))

(define (parse port)

  ;; extract "problem"
  (match-define (list opt start end)
    (map mkid (cdr (regexp-match *problem-rx* port))))
  ;; extract "edges"
  (define grouped
    (collect (regexp-match* *edge-rx* port #:match-select process-res)))

  ;; post-processing ----------

  ;; add extra nodes that are only targets
  (define froms (map car grouped))
  (define tos*
    (append-map (λ (e) (map car (cdr e))) grouped))
  (define tos
    (remove-duplicates (foldl remove tos* froms)))
  (define nodes
    (map (λ (e) `(node ,e)) tos))
  (define edges
    (map 
     (match-lambda [(list-rest from tos) `(node ,from ,@tos)])
     grouped))

  ;; output --------------------
  `(module m "network-lang.rkt"
     ,@nodes ; pre-define nodes that are only targets
     ,@edges
     (solve-problem ,start ,end ,opt)))

;; other helper functions -----------------------------------------------------

(define (mkid bs)
  (string->symbol (bytes->string/utf-8 bs)))
(define (num bs)
  (string->number (bytes->string/utf-8 bs)))

;; input has shape:
;   (list big-string (#"a" #"10" #"b") (#"a" #"20" #"c") ...)
(define (process-res res)
  (match-define (list _ from wgt to) res)
  (list (mkid from) (list (mkid to) (num wgt))))

(define (collect es)
  (if (null? es)
      null
      (insert (car es) (collect (cdr es)))))
(define (insert e es)
  (if (null? es)
      (list e)
      (let ([e2 (car es)])
        (if (symbol=? (car e) (car e2))
            (insert (list (car e) (cadr e) (cadr e2)) (cdr es))
            (cons e2 (insert e (cdr es)))))))
