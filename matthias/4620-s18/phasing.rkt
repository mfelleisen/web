#lang racket

;; ASSUMPTION: using the same definitions at different phases = BAD TIME
;; see: Flatt ICFP 2002, "Compilable and Composable Macros"


; top-level: PHASE n

(define x 1)


(require syntax/parse) ; imports syntax/parse ids at phase n

(require (for-syntax syntax/parse)) ; imports syntax/parse ids at phase n+1



;; begin-for-syntax, define-syntax, define-for-syntax: PHASE n+1

;; f : Stx -> Stx
;; - may only be used at phase n+1
(define-for-syntax (f stx)

  ; inside define-for-syntax: PHASE n+1

  
  (syntax-parse stx
    [(_ x) #'(list x)]))

;; (define-for-syntax (f stx) stx) equivalent to:
;;   (begin-for-syntax
;;     (define (f stx) stx))

(begin-for-syntax

  ; inside begin-for-syntax: PHASE n+1
  (define (g stx) stx)
)



;; m : Stx -> Stx
(define-syntax m

  ; inside define-syntax: PHASE n+1

  (syntax-parser
    [(_ x)
     
     #'(list ; inside syntax tempate: PHASE n+1-1
        x)]))


;; what's the difference between `f` and `m`?

;; - `m` has SPECIAL STATUS with the macro expander
;;   - ie, it's registered as a macro
;; - it's typically used at phase n as a macro call
;; - extract raw phase n+1 value with `syntax-local-value`
;;   (you probably will not need this)
(begin-for-syntax
  (displayln ((syntax-local-value #'m) #'(m 1))))

(define-syntax m2 f)
(m2 1)



;; QUIZ

(require (for-syntax (for-syntax syntax/parse))) ; imports at phase n+2

(define-syntax m3
  ; PHASE: n+1
  (syntax-parser
    [(_ x)
     ; PHASE: n+1
     #'(define-syntax x
         ; PHASE: n+1
         (syntax-parser
           [(_ y) #'( ; PHASE: n
                     y)]))]))

(m3 m4)
(m4 list)
