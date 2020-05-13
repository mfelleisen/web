(module index mzscheme

  ;; =============================================================================
  ;; CHANGE HERE
  (define (set-weeks!) '(1 2 3 4 5 6 7 8 9 10 11 12 13 14))
  ;; =============================================================================

  (require
    "../basics.ss"
   (lib "teaching.ss" "web")
   (lib "web-page.ss" "web")
   (lib "xml-qq.ss" "web")  
   (lib "xml.ss" "xml")
   (lib "list.ss")
   (lib "process.ss")
   (lib "etc.ss"))
  
  'cleaning
  (for-each (lambda (f)
	      (define fs (path->string f))
              (when (regexp-match "[0-9]+.html" fs)
		(printf "deleting ~s\n" fs)
                (delete-file f)))
            (directory-list))

  (parameterize ([current-directory "/Users/matthias/svn/Squadron/Tex/"])
    (system "tex2page contracts.tex"))
  
  'reminder:xml-private
  
  (define hiddens? (begin
		     (printf "All assignments [yes, y, or a number]?~n")
		     (let ([x (read)])
		       (if (and (number? x) (<= 1 x 14))
			   (begin
			     (set! set-weeks! (lambda () (build-list x add1)))
			     #f)
			   (or (eq? x 'yes) (eq? x 'y))))))
  
  (define THIS-COURSE "670 S '07")
  
  (define WEEKS-ALL '(1 2 3 4 5 6 7 8 9 10 11 12 13))
  (define WEEKS (if hiddens? WEEKS-ALL (set-weeks!)))

  ;; (listof (list String[title] String[link]))
  (define LINKS-1100
    (checked-links
     `(("Teaching"    "../../index.html")
       (,THIS-COURSE  "../index.html")
       (nbsp #f)
       ("Projects"      "index.html")
       ("Presentations" "presentations.html")
       ("Programming"   "programming.html")
       (nbsp #f)
       ("Squadron Scramble"   "squadron.html")
       ("Aircrafts"     "aircraft.html")
       ,@(map (lambda (x) `(,(format "Project ~a" x) ,(format "~a.html" x)))
              WEEKS))))
  

  ; String String -> Xexpr[p]
  ;; a red-colored italics word 
  (define (question q a) `(p (font ([color "blue"]) "Q: " ,q)
			     (font ([color "purple"]) " A: " ,a)))


  ; String[out file] String[page title] (union String false) Xexpr -> Void
  ;; produce and write out a page
  (define (write-normal-page file title xml)
    (produce-page file (html title #f
                             (reverse (remove-link title (reverse LINKS-1100)))
                             xml)))
  
  ; String[page title] (union String false) Xexpr -> Void
  ;; produce an index page
  (define (write-index-page title icon xml)
    (produce-page 
     "index.html" 
     (html title icon (remove-link "Projects" LINKS-1100) xml)))
  
  (define (read-assignment no)
    (let* ([x (read-xml/element (open-input-file no))]
           [y (xml->xexpr x)]
	   ;; assert: (assignment ...) must occur in (cdr y)
           [z (let loop ([y (cdr y)])
                (if (and (pair? (car y)) (eq? (caar y) 'assignment))
		    (let ((body (cdr (car y))))
		      (if (and (pair? (car body))
                               (pair? (caar body))
                               (eq? (caaar body) 'due))
			  `(div
                            (p (font ([color "red"]) "Due date: ")
                               ,(cadaar body)
                               #;(font ([color "red"]) " @ 6:00 pm"))
                            ,@(cdr body)
                            )
			  `(div ,@body)))
                    (loop (cdr y))))])
      (xexpr->xml z)))
  
  ;; --- PAGES --- 
  
  (write-index-page "Projects" #f (xml "index.xml"))
  
  (write-normal-page "programming.html" "Programming"
                     (xml "programming.xml"))
  
  (write-normal-page "presentations.html" "Presentations"
                     (xml "codewalk.xml"))
  
  (write-normal-page "squadron.html" "Squadron Scramble"
                     (xml "squadron.xml"))

  (write-normal-page "aircraft.html" "Aircrafts"
                     (xml "SquadronScramble/deck.xml"))

  (for-each (lambda (x)
              (let ([file (format "~a.xml" x)])
                (when (file-exists? file)
                  (let ([a (read-assignment (format "~a.xml" x))])
                    (write-normal-page
                     (format "~a.html" x)
                     (format "Project ~a" x)
                     a)))))
            WEEKS)
  
  (all-pages-produced?)
  
  )
