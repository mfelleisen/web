(module basics mzscheme 
  
  (require 
   (lib "teaching.ss" "web")
   (lib "web-page.ss" "web")  
   (lib "xml.ss" "xml")
   (file "blog-aux.scm"))
  
  (provide 
   red-title-word 
   write-normal-page
   write-index-page
   write-blog)
  
  (define THIS-COURSE "U211 F '06")
  
  ;; (listof (list String[title] String[link]))
  (define LINKS-1100
    (checked-links
     (append
      (remove-links 
       (course-links THIS-COURSE "/home/matthias/") ;; base url
       "Assignments"
       #;"Syllabus")
      '(
        ("Readings"      "reading-schedule.html")
        ("Assignments"   "Assignments/index.html")
        ("Communication" "communication.html")
        ("Blog"          "blog.html")
        ("Labs"          "labs.html")
        ("Ofc Hrs"       "officehours.html")
        ("Advice"        "advice.html")
        ("Contract"      "contract.html")
        ("DrScheme"      "http://www.drscheme.org/")
        ))))
  
  ; String -> Xexpr[p]
  ;; a red-colored italics word 
  (define (red-title-word title) `(font ([color "red"][style "italic"]) ,title ": "))
  
  ; --> this was an attempt to turn this whole thing into a class hierarchy
  ; --> another time 
  
  ; String[out file] String[page title] (union String false) Xexpr -> Void
  ;; produce and write out a page
  (define (write-normal-page file title icon xml)
    (produce-page file (html title icon (remove-link title LINKS-1100) xml)))
  
  ; String[page title] (union String false) Xexpr -> Void
  ;; produce an index page
  (define (write-index-page title icon xml)
    (produce-page "index.html" (html title icon (remove-link THIS-COURSE LINKS-1100) xml)))
  
  
  )
