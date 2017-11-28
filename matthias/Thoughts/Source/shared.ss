#lang at-exp racket

(require
  scribble/base
  scribble/core
  scribble/manual
  scribble/eval
  scriblib/figure
  "unnumbered.rkt"
  (only-in scribble/struct make-flow)
  scribble/html-properties
  racket/sandbox
  (for-label racket))

(provide
  (for-label (all-from-out racket))
  (all-defined-out)
  (all-from-out scriblib/figure)
  (all-from-out scribble/core)
  (all-from-out scribble/manual)
  (all-from-out scribble/eval)
  (all-from-out "unnumbered.rkt"))

(define special-thought (make-style "special" (list (make-css-addition "thoughts.css"))))

(define htdp (hyperlink "http://www.htdp.org" "HtDP"))
(define (htdp2e)
  @hyperlink["http://www.ccs.neu.edu/home/matthias/HtDP2e/"]{HtDP/2e})
(define (htdc)
  @hyperlink["http://www.ccs.neu.edu/home/matthias/htdc.html"]{How to Design Classes})
(define (plt) (hyperlink "http://www.racket-lang.org/people.html" "PLT"))

;; String *-> NestedFlow (inset)
(define (blockquote . str*)
  (make-nested-flow (make-style "blockquote" '())
    (list (make-paragraph plain str*))))

;; String *-> Line
(define (date . str*)
  (apply margin-note str*))

(define ts (italic "TeachScheme!"))

;; ---------------------------------------------------------------------------------------------------
;; a question-answer form for FAQ like things 

(define-syntax-rule
  (q-a (q a) ...)
  (let ()
    (define top (make-style #f `(top ,(attributes '((width . "500"))))))
    (make-table
      (make-style #f
	(list
	  (attributes '((cellspacing . "10") (cellpadding . "10")))
	  (table-cells
	    (list 
	      (list (begin q top) (begin a top))
	      ...))))
      (list (list q a) ...))))
    
(define (a . stuff)
  (apply para (bold "A: ") stuff))

(define (q . stuff)
  (apply para (bold "Q: ") stuff))

;; ---------------------------------------------------------------------------------------------------
;; an evaluator for the simplistic lazy language 

(define LAZY "RacketCode/pseudo-lazy.rkt")

(define-syntax sexp-eval
   (syntax-rules ()
     [(_ d ...)
      (let ()
        (define me
          (parameterize ([sandbox-output 'string]
                         [sandbox-error-output 'string])
            (make-module-evaluator `(module m ,LAZY) #:allow-read `((file ,LAZY)))))
	me
	;; the following doesn't work
	#;
        (lambda (x) 
          (define y (me x))
	  (displayln `(debug '(d ...) ,y))
          y))]))

;; ---------------------------------------------------------------------------------------------------
;; compare: two code snippets, in two columns: left is good, right is bad 
(define (compare stuff1 stuff2)
  (define stuff (list (list stuff1) (list stuff2)))
  (table (sty 2 500) (apply map (compose make-flow list) stuff)))

(define (sty columns width)
  (define space
    (style #f `(,(attributes `((width . ,(format "~a" width)) (align . "center") (valign . "top"))))))
  ;; -- in -- 
  (style #f
    (list
      (attributes '((border . "1") (cellpadding . "10")))
      (table-columns (make-list columns space)))))
