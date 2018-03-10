#lang scribble/manual 

@(require racket/list)
@(require racket/path)
@(require racket/file)
@(require racket/match)
@(require racket/pretty)
@(require racket/string)
@(require net/url)
@(require racket/system)

@(define lines (file->lines "index-data.txt"))
@(define sepa  "-----------")
@(define (comments lines (accu '()))
   (cond
     [(empty? lines) (values (reverse accu) '())]
     [(equal? (first lines) sepa) (values (reverse accu) lines)]
     [else (comments (rest lines) (cons (first lines) accu))]))
@(define (opt-url x h1 (h2 ""))
   (define ext  (if (equal? "" (string-trim x)) "" (path-get-extension x)))
   (define url? (and (not (equal? "" (string-trim x)))(string->url x)))
   (if (or url? (equal? #".pdf" ext) (equal? #".html" ext))
       (link x h1) 
       (t h2)))
@(define (one-piece lines)
   (unless (equal? (first lines) sepa)
     (pretty-print lines)
     (error "not a new piece"))
   (match-define `(,title ,date ,local ,remote ,rest ...) (cdr lines))
   (define-values (cmts lines0) (comments rest))
   (define piece (list (opt-url local title) (t date)  (opt-url remote "html") (apply t cmts)))
   (values piece lines0))

@; ---------------------------------------------------------------------------------------------------
@title[#:style '(unnumbered)]{Articles of Interest}

@tabular[#:sep @hspace[3]
         #:row-properties '(bottom-border)

 @(let loop ([lines lines])
   (cond
     [(empty? lines) '()]
     [else
       (define-values (piece lines0) (one-piece lines))
       (list* piece (loop lines0))]))

 ]
