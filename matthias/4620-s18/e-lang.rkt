#lang racket

;; -----------------------------------------------------------------------------

(provide
 define
 #%app
 #%top
 #%datum
 +

 (rename-out (show-me #%module-begin)))

;; -----------------------------------------------------------------------------
(require (for-syntax syntax/parse))

;; --------------------------------------------
;; SYNTAX

(define-syntax (show-me stx)
  (syntax-parse stx 
    [(_ e ...)
     #`(#%module-begin
	 ;; generate the code for counting 
	 (define N 0)
	 ;; -> VOID
	 ;; EFFECTS: 
	 (define (inc)
	   (set! N (+ N 1))
	   (printf "evaluating top-level form ~a\n" N))

	 ;; generate the macro for the REPL in the same context 
	 (define-syntax (#,(datum->syntax stx '#%top-interaction) stx)
          (syntax-parse stx
            [(_ . f) #`(begin (inc) f)]))

	 ;; now add the code for the 
	 (begin (inc) e) ...)]))
