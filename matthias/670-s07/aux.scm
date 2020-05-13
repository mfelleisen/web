(module aux mzscheme 
  
  (require 
    (lib "teaching.ss" "web")
    (lib "web-page.ss" "web")  
    (lib "xml.ss" "xml")
    (file "blog-aux.scm")
    (lib "list.ss"))
  
  (provide
    red-title-word 
    write-normal-page
    write-index-page
    write-blog)

  ; String[out file] String[page title] (union String false) Xexpr -> Void
  ;; produce and write out a page
  (define (write-normal-page file title icon xml)
    (produce-page file (html title icon (remove-link title LINKS-1205) xml)))
  
  ; String[page title] (union String false) Xexpr -> Void
  ;; produce an index page
  (define (write-index-page title icon xml)
    (produce-page "index.html"
      (html title icon (remove-link THIS-COURSE LINKS-1205) xml)))
  
  ; ---------------------------------------------------------------------------
  (define THIS-COURSE "670 S '07")

  ;; (listof (list String[title] String[link]))
  (define LINKS-1205
    (checked-links
      (append
	(remove '("Assignments" "assignments.html") (course-links THIS-COURSE))
	'(
	  ("Communications" "communications.html")
	  ("Blog"           "blog.html")
	  ("Journal"        "log.html")
	  ("Lectures" "Lectures/index.html")	  
	  ("Projects" "Projects/index.html")
          ))))

  ; String -> Xexpr[p]
  ;; a red-colored italics word 
  (define (red-title-word title) `(font ([color "red"][style "italic"]) ,title ": "))

  
  ; --> this was an attempt to turn this whole thing into a class hierarchy
  ; --> another time 
  
  ; String[out file] String[page title] (union String false) Xexpr -> Void
  ;; produce and write out a page
  '(define (write-normal-page file title icon xml)
     (produce-page file (html title icon (remove-link title LINKS-1100) xml)))
  
  ; String[page title] (union String false) Xexpr -> Void
  ;; produce an index page
  '(define (write-index-page title icon xml)
     (produce-page "index.html" (html title icon (remove-link THIS-COURSE LINKS-1100) xml)))
  
  
  ;; -> Void
  (define (write-blog)
    (write-normal-page "blog.html" "Blog" #f (blog)))
  )
