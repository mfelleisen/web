(module index mzscheme
  
  (require
   (file "../basics.ss")
   (lib "teaching.ss" "web")
   (lib "web-page.ss" "web")
   (lib "xml-qq.ss" "web")  
   (lib "xml.ss" "xml")
   (lib "list.ss"))
  
  'cleaning
  (for-each (lambda (f) 
              (when (regexp-match ".html" (path->string f)) 
                (delete-file f)))
            (directory-list))
  
  'reminder:xml-private
  
  (define hiddens? (begin
		     (printf "All assignments?~n")
		     (let ([x (read)])
		       (or (eq? x 'yes) (eq? x 'y)))))
  
  
  (define THIS-COURSE "670 S '05")
  
  (define WEEKS-ALL '(1 2 3 4 5 6 7 8 9 10 11 12 13))
  ;; =============================================================================
  ;; CHANGE HERE
  (define WEEKS (if hiddens? WEEKS-ALL '(1)))
  ;; =============================================================================
  
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
       ("Carcassonne"   "carcassonne.html")
       ("Tiles"         "tiles.html")
       ,@(map (lambda (x) `(,(format "Project ~a" x) ,(format "~a.html" x)))
              WEEKS))))
  
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
  
  (write-normal-page "carcassonne.html" "Carcassonne"
                     (xml "carcassonne.xml"))
  
  (write-normal-page "tiles.html" "Tiles" (xml "Tiles/index.xml"))
  
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
