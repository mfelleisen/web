#lang typed/racket

(require/typed "dictionary.rkt" (in-dictionary? (String -> Any)))

(provide count-words)

(: count-words : ((Listof String) -> Natural))
(define (count-words lw)
  (for/fold: ({c  : Natural 0}) ({w lw} #:when (in-dictionary? w))
             (+ c 1)))

