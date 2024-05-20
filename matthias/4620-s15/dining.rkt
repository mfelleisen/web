#lang racket

(define N 16)

(define forks (make-vector N 1))

(define (dining-philosophers)
  (thread
   (lambda ()
     (let LOOP ()
       (count-forks)
       (LOOP))))
  (sleep 3)
  (for ((i (in-range 0 N)))
    (thread 
     (lambda ()
       (let LOOP ()
         (define right i)
         (when (fork-available right)
           (take-fork right))
         (define left (modulo (+ i 1) N))
         (when (fork-available left)
           (take-fork left))
         (eat)
         (return-fork left)
         (return-fork right)
         (LOOP))))))


(define (take-fork i)
  (vector-set! forks i (sub1 (vector-ref forks i))))
(define (return-fork i)
  (vector-set! forks i (add1 (vector-ref forks i))))
(define (fork-available i)
  (> (vector-ref forks i) 0))
(define (eat)
  (sleep 1))
(define (count-forks)
  (displayln (for/sum ((x forks)) x)))