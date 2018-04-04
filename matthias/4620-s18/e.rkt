#lang racket

(require (for-syntax syntax/parse))

(module+ test (require rackunit))

(define-syntax (smatch stx)
  (syntax-parse stx
    [(_ e:expr [(tag1:str x1-1:id ...) e1] ...)
     #'(let* ([val e]
              [_ (unless (and (list? val) (cons? val))
                   (error 'smatch "expected a list, given: ~e" val))]
              [tag (first val)]
              [_ (unless (string? tag)
                   (error 'smatch "expected a string, given: ~e" tag))]
              [rst (rest val)]
              [nnn (length rst)])
         (cond
           [(and (string=? tag1 tag) (= (length '(x1-1 ...)) nnn))
            (apply (lambda (x1-1 ...) e1) rst)]
           ...))]))
     
;; EXAMPLE

;; CountDown is one of:
;; -- (list "counting" p)
;; -- (list "halted" p p)
;; -- (list "launch"]
;; -- (list "flying" n) 
;; where p is a positive integer and n is a negative one 

;; CountDown -> String 
(module+ test (check-equal? (render '("halted" 9 10)) 'orange))
(define (render ws)
  (smatch ws
    [("counting" t) 'green]
    [("halted" n h) 'orange]
    [("launch")     'red]
    [("flying" p)   'blue]))

























































;; -----------------------------------------------------------------------------
(define-syntax (dmatch stx)
  (syntax-parse stx
    [(_ e:expr [(tag1:id x1-1:id ...) e1] ...)
     #'(let* ([val e]
              [_ (unless (and (list? val) (cons? val))
                   (error 'smatch "expected a list, given: ~e" val))]
              [tag (first val)]
              [_ (unless (string? tag)
                   (error 'smatch "expected a string, given: ~e" tag))]
              [rst (rest val)]
              [nnn (length rst)])
         (cond
           [(and (string=? (~a 'tag1) tag) (= (length '(x1-1 ...)) nnn))
            (apply (lambda (x1-1 ...) e1) rst)]
           ...))]))

;; CountDown -> String
(module+ test (check-equal? (render '("halted" 9 10)) 'orange))
(define (render/2 ws)
  (dmatch ws
    [(counting t) 'green]
    [(halted n h) 'orange]
    [(launch)     'red]
    [(flying p)   'blue]))