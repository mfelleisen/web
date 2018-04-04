#lang racket

(require (for-syntax syntax/parse))

(module+ test (require rackunit))

;; PROBLEM (my-or e1 ... eN) acts like (or e1 ... eN)

(module+ test
  (check-equal? (my-or) (or))
  (check-equal? (my-or 1) (or 1))
  (check-equal? (my-or #f) (or #f))
  (check-equal? (my-or 1 2) (or 1 2))
  (check-equal? (my-or 1 2 #false) (or 1 2 #false))

  (displayln '---) ;; to check effects 
  (check-equal? (my-or (displayln "hello") #false (displayln "world"))
                (or    (displayln "hello") #false (displayln "world"))))

(define-syntax (my-or stx)
  (syntax-parse stx
    [(_) #'false]
    [(_ e1:expr) #'e1]
    [(_ e1:expr e2:expr ...) #'(let ((x e1)) (if x x (my-or e2 ...)))]))