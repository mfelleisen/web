#lang racket

(require (for-syntax syntax/parse))

(module+ test (require rackunit))

;; (my-and e1 ... eN) acts like (and e1 ... eN)

(module+ test
  (check-equal? (my-and) (and))
  (check-equal? (my-and 1) (and 1))
  (check-equal? (my-and #f) (and #f))
  (check-equal? (my-and 1 2) (and 1 2))
  (check-equal? (my-and 1 2 #false) (and 1 2 #false))

  (displayln '---) ;; to check effects 
  (check-equal? (my-and 1 2 (displayln "hello") #false (displayln "world"))
                (and    1 2 (displayln "hello") #false (displayln "world"))))

(define-syntax (my-and stx)
  (syntax-parse stx
    [(_) #'#true]
    [(_ e1:expr) #'e1]
    [(_ e1:expr e2:expr ...) #'(if e1 (my-and e2 ...) #false)]))
