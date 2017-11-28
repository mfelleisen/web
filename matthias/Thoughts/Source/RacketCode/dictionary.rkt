#lang racket

(provide in-dictionary?)

(define *dictionary 
  '("cat" "dog" "frog" "zebra"))

(define (in-dictionary? w)
  (member w *dictionary))