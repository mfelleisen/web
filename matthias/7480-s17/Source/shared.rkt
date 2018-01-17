#lang at-exp racket

;; this file defines some common scribble and racket utilities

;; TURN OFF THE FIRST and TURN ON THE SECOND TO DEPRECATE A SEMESTER 
(provide top) (provide title)
; (provide [rename-out [deprecate top] [deprecate-title title]])

(provide (except-out (all-from-out scribble/manual) title))

(provide
 ;; String -> [Listof history]
 make-history
 
 (all-from-out scribble/core)
 
 (all-from-out racket/format)

 make-list first
 
 ;; QuotedCode -> Void
 ;; a base evaluator with the test engine pre-loaded so that check-expect
 ;; is available
 ev 

 ;; (def code ...)
 ;; expands
 ;; to type-set racket code and evaluates the code with ev,
 ;; one piece at a time; at the end the evaluator runs (test)
 def
 
 HTDP
 ;; location of book, this will go permanent by 2017
 ;; String String -> link element 
 htdp

 ;; (-> [Listof String]) -> table of names and images 
 images-of)

(provide
 usec usub

 nested-table the-end
 ;; syntax: (ps <number or string> string)
 ;; creates a begin that is expected to be sliced into the top level
 ;; scribble doc
 ps psref pslink

 ;; syntax: (lab <number or string> string)
 ;; creates a begin that is expected to be sliced into the top level
 ;; scribble doc
 lab labref lablink

 (contract-out
  ;; create a problem label with running number, per problem set
  [problem (-> element?)])
         
 ;; create a sample problem element, nested, indented
 sample-problem

 exercise ex-label

 grid

 separator
 
 black red blue navy green yellow orange pink
 background-white background-gray
 strike)

;; ---------------------------------------------------------------------------------------------------
;; requiring and explorting the documentation links for BSL, ISL, teachpacks
(require teachpack/2htdp/scribblings/img-eval)
(require scribble/manual)
(require scribble/core)
(require scribble/html-properties)

(require racket/format)

(require 2htdp/image)

;; ---------------------------------------------------------------------------------------------------
(define HTDP "http://www.ccs.neu.edu/home/matthias/HtDP2e/")

(define (htdp w . t)
  (apply link (string-append HTDP w) t))

;; ---------------------------------------------------------------------------------------------------
(define (images-of tas-list)
  @tabular[#:sep @hspace[3] #:style 'boxed
           (for/list ((ta (tas-list)))
             (define-values (fst lst) (apply values (string-split ta)))
             (define file-name
               (format "Images/StaffPictures/~a_~a.png" (string-downcase lst) (string-downcase fst)))
             (define img 
               (if (file-exists? file-name) (image file-name) "not supplied yet"))
             (list ta img))])
;; ---------------------------------------------------------------------------------------------------

(define ev (make-img-eval))

(ev '(require test-engine/racket-tests))
(ev '(define true #t))
(ev '(define false #t))
(ev '(require (only-in lang/htdp-intermediate local)))
;; can't do the following, why?
; (ev '(require 2htdp/image))
; (ev '(require 2htdp/universe))

(define-syntax-rule
  (def code ...)
  ;; ==>
  (begin
    (racketblock
     code
     ...)
    (ev 'code)
    ...
    (ev '(test))
    ))

;; ---------------------------------------------------------------------------------------------------
(define separator (line 550 0 "blue"))

(define the-end (toc-element #f "" (hyperlink "http://www.racket-lang.org/" (smaller "DrRacket"))))

(define *p 0)
(define *e 0)
(define (*reset) (set! *p 0) (set! *e 0))
(define-syntax-rule
  (ps n a-b-c pl)
  (begin
    (*reset)
    (define n:str (format "~a~a" n a-b-c))
    (margin-note (image "Images/homework.png" #:scale .22 "home work!"))
    (title #:tag n:str 
           #:style '(toc grouper unnumbered)
           "Week " (number->string n) " Set " a-b-c)
    (bold "Programming Language")
    "  "
    pl))
(define (psref psname) (secref (string-append "ps" psname)))
(define (pslink psname linktext) (seclink (string-append "ps" psname) linktext))

(define-syntax-rule
  (lab n pl)
  (begin
    (*reset)
    (define n:str (if (string? n) n (number->string n)))
    (margin-note (image "Images/lab.png" #:scale .22 "home work!"))
    (title #:tag (string-append "lab" n:str) #:style '(grouper unnumbered) "Lab  " n:str " "pl)))
(define (labref labname) (secref (string-append "lab" labname)))
(define (lablink labname linktext) (seclink (string-append "lab" labname) linktext))

(define (problem)
  (set! *p (+ *p 1))
  (bold "Problem " (number->string *p)))

(define (grid s)
  (style #f
         (list
          (attributes `((cellpadding . "2") (cellspacing . ,(number->string s)) (border . "1"))))))

(define (sample-problem . t)
  (nested #:style 'inset (bold "Sample Problem ") t))

(define ex-label (make-parameter "Exercise ~a "))
(define (exercise . t)
  (set! *e (add1 *e))
  (nested #:style 'inset (bold (format (ex-label) *e)) t))

;; ---------------------------------------------------------------------------------------------------

(define (nested-table t)
  (nested (tabular #:style 'boxed #:sep (hspace 3) t)))

;; ---------------------------------------------------------------------------------------------------
(define (usec . t) (section #:style '(unnumbered) #:tag (symbol->string (gensym)) t))
(define (usub . t) (subsection #:style '(unnumbered) #:tag (symbol->string (gensym)) t))

;; ---------------------------------------------------------------------------------------------------
(define (top #:tag [t #f] #:unnumbered? [unnumbered? #f] . c)
  (list
   (apply title #:style '(grouper unnumbered) #:tag t c)
   (section #:tag (and t (string-append "chap:" t))
            #:style (append
                     (if unnumbered? '(toc unnumbered) null)
                     '(hidden toc-hidden)))))

(define MAIN-URL "http://www.ccs.neu.edu/course/cs2500/")
(define (deprecate #:tag [t #f] #:unnumbered? [unnumbered? #f] . c)
  `(,@(deprecated)
    ,(apply top #:tag t #:unnumbered? unnumbered? c)))
    
(define (deprecate-title #:tag [t (format "tag ~a" (gensym))] #:style [s (make-style #f '(toc))] . c)
  `(,@(deprecated)
    ,(apply title #:tag t #:style s c)))

(define (deprecated)
  (list
   (centerline
    (red @list{This web page is deprecated.}))

   (centerline
    (red @list{Please see the @link[MAIN-URL]{main page} for Fundamentals I.}))))

;; ---------------------------------------------------------------------------------------------------
(define (strike . t)
  (element (style "strike" (list (attributes '((style . "text-decoration:line-through")))))
           t))

(define ((colored c) . t)
  (element (style #f (list (color-property c))) t))

(define-syntax-rule (define-colored c) (define c (colored (format "~a" 'c))))

(define-colored red)
(define-colored black)
(define-colored vlack)
(define-colored green)
(define-colored yellow)
(define-colored orange)
(define-colored pink)
(define-colored blue)
; (define-colored navy)

(define (navy . t) (element (style #f (list (color-property "#07A"))) t))

(define (background-white c . t)
  (define s (style #f `(,(background-color-property "white") ,(color-property c))))
  (element s t))

(define (background-gray c . t)
  (define s (style #f `(,(background-color-property "gray") ,(color-property c))))
  (element s t))

;; ---------------------------------------------------------------------------------------------------
(define (ltable c #:sep (sep #f))
  (if sep
      (tabular #:sep (hspace 1) #:style (ltable-style c #t) c)
      (tabular #:style (ltable-style c) c)))

(define (ltable-style content (sep #f))
  (define col# (length (car content)))
  (define cell-left
    (make-list (length content)
               (make-list (if sep (sub1 (* 2 col#)) col#) (style 'left '()))))
  (style #f `(,(table-cells cell-left))))

;; ---------------------------------------------------------------------------------------------------

(provide
 in-latex-mode?
 cover
 coverbox
 newpage newline empty-style)

(define in-latex-mode? (make-parameter #f))

(define-syntax-rule
  (define/latex (name . s) body)
  (define (name . s)
    (if (in-latex-mode?)
        body
        "")))

(define exact (make-style #f '(exact-chars)))

(define/latex (hstrut n)
  @element[exact (format "\\rule{~a}{0pt}" n)])

(define/latex (np)
  @element[exact "\\newpage"])

(define/latex (nb)
  @element[(make-style #f '(no-break)) ""])

(define/latex (nl)
  @element[exact "\\hfill\\newline"])

(define/latex (noindent)
  @element[exact "\\noindent"])

(define/latex (roman)
  @element[exact "\\pagenumbering{roman}\\setcounter{page}{7}"])

(define/latex (arabic)
  @element[exact
           (string-append
            ;; this ought to be parametrized over odd/even 
            "~\\newpage\\thispagestyle{empty}"
            "\\pagenumbering{arabic}\\setcounter{page}{2}"
            "\\renewcommand{\\thesection}{\\arabic{section}}"
            "\\setcounter{section}{0}")])

(define/latex (newpage)
  @elem[#:style (symbol->string '\newpage)]{})

(define (newline)
  @element['newline ""])

(define (empty-style)
  @element[exact "\\thispagestyle{empty}"])

(define (student-id)
  @element[exact
           #<< sid
           \par{\bf STUDENT NAME: \hrulefill}\par
 sid
           ])

(define (cover t)
  @element[exact (format "\\cover{~a}" t)])

(define (coverbox)
  @element[exact (format "\\coverbox{}")])

@; -----------------------------------------------------------------------------

(define (make-history path)
  (define groups 
    (let loop ([l (for/list ((f (in-lines (open-input-file path)))) f)]
               [s '()])
      (cond
        [(null? l)
         (if (empty? s)
             '()
             (list (reverse s)))]
        [(string=? (first l) "") (cons (reverse s) (loop (rest l) '()))]
        [else (loop (rest l) (cons (first l) s))])))

  (define L (length groups))

  (for/list ((g groups) (i (in-naturals)))
    (match-define `(,date-line . ,lines) g)
    @history[#:changed (format "1.~a" (- L i 1))
             (cons @list{ on @date-line @newline[]}
                   (for/list ((l lines)) @list{@hspace[5] @l @newline[]}))]))

@; -----------------------------------------------------------------------------
;; 2016 only 

(provide
 standards)

(define (standards)
  "Before proceeding, fix your solution in response to our feedback.")