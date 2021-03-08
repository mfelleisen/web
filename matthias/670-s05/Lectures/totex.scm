(module tot mzscheme
  
  (require (lib "xml.ss" "xml") (lib "pretty.ss"))
  
  (define (read-lecture no)
    (let* ([x (read-xml/element (open-input-file no))]
           [y (xml->xexpr x)])
      y))
  
  (define (strip x)
    (let-values ([(lecture att body) (pick-apart x)])
      (unless (eq? lecture 'lecture) 
        (error 'strip "expected lecture, found ~e" x))
      (printf "\\newpart{~a}~n" (cadr (car att)))
      body))
  
  ;; Xexpr -> Symbol x Listof[Attribute] x Listof[Xexpr]
  (define (pick-apart x)
    (let* ([tag (car x)]
           [___ (set! x (cdr x))]
           [att (if (and (pair? x) 
                         (list? (car x))
                         (andmap list? (car x)))
                    (begin0
                      (car x) 
                      (set! x (cdr x)))
                    '())]
           [body x])
      (values tag att body)))
  
  (define (process-xml x proc)
    (cond
      [(pair? x)
       (let-values ([(tag att body) (pick-apart x)])
         (define (p x) (process-xml x proc))
         (define-values (begin end) (proc tag))
         (if begin
             `(,begin ,@(map p body) ,end)
             ((other-tags) `(,tag ,att ,@(map p body)))))]
      [(symbol? x)
       (case x 
         [(le) (msym 'leq)]
         [(gt) (msym 'geq)]
         [(forall) (msym 'forall)]
         [else x])]
      [else x]))
  (define (msym x) (format "$\\~s$" x))
  
  (define other-tags (make-parameter (lambda (x) x)))
  
  (define (moo x)
    (define end "}")
    (define (env tag)
      (values (format "\\begin{~a}" tag) (format "\\end{~a}" tag)))
    (define (stf tag) (values (format "\\~a{" tag) end))
    (define (fnt tag) (values (format "{\\~a " tag) end))
    (case x
      [(h3) (stf "section")]
      [(li) (values "\\item " "")]
      [(p)  (values "" "")]
      [(b)    (fnt "bf")]
      [(em)   (fnt "em")]
      [(code) (fnt "tt")]
      [(ol) (env "enumerate")]
      [(ul) (env "itemize")]
      [(verbatim pre) (env "verbatim")]
      [(center) (env "center")]
      ;; --- 
      [(font) (values "" "")]
      [(a)    (values "" "")]      
      [else (values #f #f)]))
  
  (define (test xml expected)
    (unless (equal? (process-xml xml  moo) expected)
      (printf "given: ~s~nexpected: ~s~nreceived: ~s~n" 
              xml expected (process-xml xml moo))))
  
  ;; expected: 
  (test '(body () "hello world")   (list 'body '() "hello world"))
  (test '(body "hello world")      (list 'body '() "hello world"))
  (test '(body (h3 "hello world")) (list 'body '() '("\\section{" "hello world" "}")))
  (test '(body (h3 "hello world") (li "code"))
        (list 'body
              '()
              '("\\section{" "hello world" "}")
              '("\\item " "code" "")))

  (define (pre-process-xml x)
    (if (pair? x)
        (let-values ([(tag att body) (pick-apart x)])
          (if (and (eq? 'pre tag) (pair? body) (pair? (car body)) (eq? (caar body) 'code))
              (let-values ([(tag att2 bdy) (pick-apart (car body))])
                `(verbatim ,(append att att2) ,@(map pre-process-xml bdy)))
              `(,tag ,att ,@(map pre-process-xml body))))
        x))
  
  (define (test2 xml expected)
    (unless (equal? (pre-process-xml xml) expected)
      (printf "given: ~s~nexpected: ~s~nreceived: ~s~n" 
              xml expected (pre-process-xml xml))))
  
  (test2 '(body () "hello world") '(body () "hello world"))
  (test2 '(body () (pre () (code "x"))) '(body () (verbatim () "x")))
  (test2 '(body () (pre () (code (font ([color "red"]) "x") "y")))
         '(body () (verbatim ()  (font ([color "red"]) "x") "y")))
   
  (define (do-print x)
    (cond
      [(string? x) (printf "~a" 
                           (regexp-replace* 
                            "#" 
                            (regexp-replace* 
                             "_"
                             x
                             "\\\\_")
                            "\\\\#"))]
      [(pair? x) (map do-print x)]
      [(null? x) #t]
      [(symbol? x) (printf "&~s;" x)]
      [else (error 'do-print "~e" x)]))
        
  (other-tags (lambda (x) (error 'process-xml "unknown tag ~e" x)))
  
  (define twelve "12")
  (with-output-to-file (string-append twelve ".tex")
    (lambda ()
      (printf "\\documentclass[11pt]{article}~n")
      (printf "\\input{preamble.tex}")
      (printf "\\begin{document}~n")
      (do-print (map (lambda (x) (process-xml x moo))
                     (pre-process-xml 
                      (strip 
                       (read-lecture (string-append twelve ".xml"))))))
      (printf "\\end{document}~n")
      )
    'replace)
  
  (require (lib "slatex-wrapper.ss" "slatex"))
  
  (slatex (string-append twelve ".tex"))
  )
   