#lang racket

;; growing a programmer

(provide
 ;; PositiveNumber -> Pict
 diagram
 recipe
 
 ;; exact-positive-integer -> 2d-plot
 ;; (_ width height) create a width x height plot
 stepwise
 wall)

;; ---------------------------------------------------------------------------------------------------
(require plot pict)

(define courses
  '((("Fundamentals I" "systematic problem solving" "explicit design" "pair programming"))
    (("Logic in Computer Science" "predicting behavior" "theorems and proofs")
     ("Fundamentals II" "explicit and systematic design in Java"
                        "... + code presentation to instructor"
			 "pair programming"))
    (("Object-oriented Design" "scaling up, small projects"
                               "logical assertions"
                               "pair programming and code presentations"))
    (("Software Development"
      "from design to maintenance"
      "... class-wide presentations + peer review panels"))))

(define independent "independent exploration of programming languages")

;; -> Pict Pict
(define (diagram s)
  (define stack
    (map (lambda (c) (map (λ (x) (render* x) #;(send course render x #:w #false)) c)) courses))
  (match-define (list (list F1) (list Logic F2) (list OOD) (list SwDev)) stack)
  (define diagram
    (let* ([c (apply vc-append 80 (reverse (map (lambda (c) (apply ht-append 50 c)) stack)))]
           [w (pict-width c)][h (pict-height c)]
           [co-op1 (render* '("Co-op 1") #:fg "black" #:bg "gray")]
           [co-op2 (render* '("Co-op 2") #:fg "black" #:bg "gray")]
           [ind0 (render* (list independent)  #:fg "white" #:bg "navy")]
           [ind_ (rotate ind0 (/ pi 2))]
           [c (hb-append c (vc-append co-op2 (blank 1 50) co-op1 (blank 1 550)))]
           [c (pin-arrow-line 10 c F2 ct-find co-op1 lb-find)]
           [c (pin-arrow-line 10 c OOD rc-find co-op1 lb-find #:style 'long-dash)]
           [c (hb-append c (blank 0 1)  (vc-append ind_ (blank 1 100)))]
           [c (connect c F1 F2)]
           [c (connect c F1 Logic)]
           [c (connect c F2 OOD)]
           [c (connect c Logic OOD)]
           [c (connect c OOD SwDev)]
           [c (pin-arrow-line 10 c co-op1 lc-find SwDev (rc-find* +10))]
           [c (pin-arrow-line 10 c SwDev  (rc-find* -10) co-op2 lc-find)])
      c))
  (scale diagram s))

(define (rc-find* delta)
  (λ (x y)
    (define-values (x0 y0) (rc-find x y)) (values x0 (+ y0 delta))))

;; [NEListof String] -> Pict 
(define (render* s* #:bg [bg "black"] #:fg [fg "white"])
  (match-define (cons title description) s*)
  (define description-pict (apply vc-append 5 (map render-text description)))
  (define description-width (pict-width description-pict))
  (define description-hight (pict-height description-pict))
  (define description-bg
    (if (empty? description)
        (blank 0 0)
        (filled-rectangle (+ 10 description-width) (+ 10 description-hight))))
  
  (define title*-pict
    (vc-append
     10
     (colorize (render-text title) fg)
     (cc-superimpose (colorize description-bg "white") (colorize description-pict "black"))))
  
  (define width (pict-width title*-pict))
  (define hight (pict-height title*-pict))
  (define title-bg (filled-rounded-rectangle (+ width 50) (+ hight 20)))
  (cc-superimpose (colorize title-bg bg) title*-pict))

;; String -> Pict 
(define (render-text t)
  (text t 'roman 18))

;; Pict Pict Pict -> Pict 
(define (connect c F1 F2)
  (pin-arrow-line 10 c F1 ct-find F2 cb-find))

(module+ test (diagram .75))

;; -----------------------------------------------------------------------------

(define data
  '("atomic (numbers, strings, images, etc)"
    "intervals (of numbers) and enumerations (of atoms)"
    "compound data (structures, finite fixed-size trees)"
    "self-referential data descriptions (N, lists)"
    "mutually-referential data descriptions (trees, forests)"
    "functions as data"
    "processing complex data in parallel"))

(define steps
  '("extract description(s) of data from problem statement"
    "articulate a concise purpose statement and signature"
    "work through functional examples"
    "create an outline"
    "fill in the outline"
    "turn examples into test suite"
    ))


(define course
  (new
   (class object%
     (super-new)
     
     (define *max-width 0)
     (define *max-hight 0)
     
     ;; -> Number Number
     (define/public (reset)
       (begin0
         (values *max-width *max-hight)
         (set! *max-width 0)
         (set! *max-hight 0)))
     
     ;; String -> [-> Pict]
     (define/public (render title #:w [width? #true] #:fg [fg "white"] #:bg [bg "black"])
       (define title-text (render-text title))
       (define width (pict-width title-text))
       (define hight (pict-height title-text))
       (set! *max-width (max width *max-width))
       (set! *max-hight (max hight *max-hight))
       (lambda ()
         (define width (+ (if width? *max-width (pict-width title-text)) 15))
         (define frame (filled-rounded-rectangle width (+ *max-hight 15)))
         (cc-superimpose (colorize frame bg) (colorize title-text fg))))
     )))

;; Number Number Number Number -> Pict
(define (grid dx dy w h)
  (define squ (rectangle (+ dx 15) (+ dy 15)))
  (define row (apply hc-append (make-list w squ)))
  (apply vc-append (make-list h row)))

(define (recipe s)
  (define-values (_w _h) (send course reset))
  (define x-axis 
    (apply hc-append 10 
           (map (λ (p) (scale (rotate p (/ pi 2)) .75))
                (map (λ (t) (t))
                     (map (λ (x) (send course render x #:bg "gray" #:fg "black")) data)))))
  (define-values (xw xh) (send course reset))
  
  (define y-axis
    (apply vc-append 10
           (map (λ (p) (scale p .75))
                (map (λ (t) (t))
                     (map (λ (x) (send course render x #:bg "navy" #:fg "white")) steps)))))
  (define-values (yw yh) (send course reset))
  (scale
   (hb-append (vc-append
               (cc-superimpose (text "the structural design recipe" 'roman 22)
                               (blank (pict-width y-axis) (pict-height x-axis)))
               y-axis)
              (vc-append x-axis
                         (grid xh yh (length data) (length steps)))) s))

(module+ test (recipe .75))

;; ---------------------------------------------------------------------------------------------------
(define (stepwise w h)
  (parameterize [(plot-decorations? #f)]
    
    (plot (list
           ;; frame 
           (function (lambda (x) 0) #:color "black")
           (inverse (lambda (x) 0) #:color "black")
           (inverse (lambda (x) 1) #:color "black")
           (function (lambda (x) .001) #:color "black")
           ;; steps 
           (function (lambda (x) (* .001 x x)) #:color "blue")
           (function
            (lambda (x)
              (cond
                [(< x .2) .000]
                [(< x .4) .0002]
                [(< x .6) .0004]
                [(< x .8) .0006]
                [else     .0008]))
            #:color "red"))
          #:width  w 
          #:height h
          #:x-min 0
          #:x-max 1)))

(module+ test (stepwise 200 200))

;; ---------------------------------------------------------------------------------------------------

(define (wall w h)
  (parameterize [(plot-decorations? #f)]
    (define ex 5.)
    (define c1 .30)
    (define (st x) (+ (/ (sqrt (* .1 (- x .3))) 1000) (expt c1 ex)))
    (define mx (st 1.0))
    (plot (list
           ;; frame 
           (function (lambda (x) 0) #:color "black")
           (inverse (lambda (x) 0) #:color "black")
           (inverse (lambda (x) 1) #:color "black")
           (function (lambda (x) mx) #:color "black")
           ;; steps
           (function (lambda (x) (* .0027 x x)) #:color "blue")
           (function
            (lambda (x)
              (cond
                [(<= x c1) (expt x ex)]
                [else (st x)]))))
          #:width  w 
          #:height h
          #:x-min 0
          #:x-max 1)))

(module+ test (wall 200 200))
