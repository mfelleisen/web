#lang scribble/manual 

@(require racket/list)
@(require racket/path)
@(require racket/file)
@(require racket/match)
@(require racket/pretty)
@(require racket/string)
@(require net/url)
@(require racket/system)

@; ---------------------------------------------------------------------------------------------------
@(define sepa  "-----------")
@(define sect #px"# (.*)")

@(define (global-loop lines)
   (let global-loop ([lines lines])
     (cond
       [(empty? lines) '()]
       [else
        (define-values (section-title section-content lines0) (one-section lines))
        (list* 
         @subsection[#:style '(unnumbered)]{@section-title}
         @tabular[#:sep @hspace[3] #:row-properties '(bottom-border) @section-content]
         (global-loop lines0))])))

@(define (one-section lines)
   (define title-line (regexp-match sect (first lines)))
   (unless title-line 
     (pretty-print lines)
     (error "not a new section"))
   (define title (second title-line))
   (define-values (content lines1)
     (let section-loop ((lines (rest lines)))
       (cond
         [(empty? lines) (values '() '())]
         [(string=? "" (first lines)) (section-loop (rest lines))]
         [(regexp-match sect (first lines)) (values '() lines)]
         [else
          (define-values (piece lines0) (one-piece lines))
          (define-values (others lines1) (section-loop lines0))
          (values (cons piece others) lines1)])))
   (values title content lines1))

@(define (one-piece lines)
   (unless (equal? (first lines) sepa)
     (pretty-print lines)
     (error "not a new piece"))
   (match-define `(,title ,date ,local ,remote ,rest ...) (cdr lines))
   (define-values (cmts lines0) (comments rest))
   (define piece (list (opt-url local title) (t date)  (opt-url remote "html") (apply t cmts)))
   (values piece lines0))

@(define (comments lines (accu '()))
   (cond
     [(empty? lines) (values (reverse accu) '())]
     [(regexp-match sect (first lines)) (values (reverse accu) lines)]
     [(equal? (first lines) sepa) (values (reverse accu) lines)]
     [else (comments (rest lines) (cons (first lines) accu))]))

@(define (opt-url x h1 (h2 ""))
   (define ext  (if (equal? "" (string-trim x)) "" (path-get-extension x)))
   (define url? (and (not (equal? "" (string-trim x)))(string->url x)))
   (if (or url? (equal? #".pdf" ext) (equal? #".html" ext))
       (link x h1) 
       (t h2)))

@; ---------------------------------------------------------------------------------------------------
@title[#:style '(unnumbered)]{Articles of Interest}

@section[#:style '(unnumbered)]{}
@(global-loop (file->lines "index-data.txt"))