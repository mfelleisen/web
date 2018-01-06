#lang at-exp racket

(require
  scribble/base
  scribble/core
  scribble/manual
  scribble/eval
  "unnumbered.rkt"
  (only-in scribble/struct make-flow)
  scribble/html-properties
  racket/sandbox
  (for-label racket))

(provide red blue green yellow orange pink background-white)

(provide
  (for-label (all-from-out racket))
  (all-defined-out)
  (all-from-out scribble/core)
  (all-from-out scribble/manual)
  (all-from-out scribble/eval)
  (all-from-out "unnumbered.rkt"))

(define (htdp) (hyperlink "http://www.htdp.org" "HtDP"))
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

(define ((colored c) . t)
  (element (style #f (list (color-property c))) t))

(define-syntax-rule (define-colored c) (define c (colored (format "~a" 'c))))

(define-colored red)
(define-colored green)
(define-colored yellow)
(define-colored orange)
(define-colored pink)
(define-colored blue)

(define (background-white c . t)
  (define s (style #f `(,(background-color-property "white") ,(color-property c))))
  (element s t))

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

;; -----------------------------------------------------------------------------

(provide bsl-eval)

(require teachpack/2htdp/scribblings/img-eval mzlib/pconvert file/convertible)

(define-syntax-rule
  (*sl-eval module-lang reader def ...)
  ;; ===>>>
  (let ()
    (define me (parameterize ([sandbox-propagate-exceptions #f])
                 (make-img-eval)))
    (me '(require (only-in racket empty? first rest cons? sqr true false)))
    (me '(require lang/posn))
    (me '(require racket/pretty))
    (me '(current-print pretty-print-handler))
    (me '(pretty-print-columns 65))
    (me 'def)
    ...
    (call-in-sandbox-context me (lambda () (error-print-source-location #f)))
    (call-in-sandbox-context me (lambda () (sandbox-output 'string)))
    (call-in-sandbox-context me (lambda () (sandbox-error-output 'string)))
    (call-in-sandbox-context me (lambda () (sandbox-propagate-exceptions #f)))
    (call-in-sandbox-context me (lambda ()
				  (current-print-convert-hook
				    (let ([prev (current-print-convert-hook)])
				      ;; tell `print-convert' to leave images as themselves:
				      (lambda (v basic sub)
					(if (convertible? v)
					    v
					    (prev v basic sub)))))

				  (pretty-print-size-hook
				    (let ([prev (pretty-print-size-hook)])
				      ;; tell `pretty-print' that we'll handle images specially:
				      (lambda (v w? op)
					(if (convertible? v) 1 (prev v w? op)))))
				  
				  (pretty-print-print-hook
				    (let ([prev (pretty-print-print-hook)])
				      ;; tell `pretty-print' how to handle images, which is
				      ;; by using `write-special':
				      (lambda (v w? op)
					(if (convertible? v) (write-special v op) (prev v w? op)))))

				  ((dynamic-require 'htdp/bsl/runtime 'configure)
				   (dynamic-require reader 'options))))
    (call-in-sandbox-context me (lambda () (namespace-require module-lang)))
    (interaction-eval #:eval me (require 2htdp/image))
    (interaction-eval #:eval me (require 2htdp/batch-io))
    (error-display-handler
     (lambda (msg exn)
       (if (exn? exn)
           (display (get-rewriten-error-message exn) (current-error-port))
           (eprintf "uncaught exception: ~e" exn))))
    me))

(require lang/private/rewrite-error-message)
	
(define-syntax-rule
  (bsl-eval def ...)
  (*sl-eval 'lang/htdp-beginner 'htdp/bsl/lang/reader def ...))
