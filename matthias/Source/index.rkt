#lang racket

(require
  (lib "list.ss")
  (lib "web-page.ss" "web")
  (lib "xml-qq.ss" "web")
  scheme/system)

;; -----------------------------------------------------------------------------
;; pubs 
(require (file "/Users/matthias/Hub/NUPLT/aux.scm") (file "///Users/matthias/Hub/NUPLT/pub-aux.ss") (lib "process.ss"))

;; defines: presentations
(require "../Presentations/index.ss")

(define where
  (build-path
    (find-system-path 'home-dir)
    "Hub"
    "Felleisen.org"
    "matthias"))

(displayln `(*************************************************))
(displayln `(these pages are placed into this directory ,where))
(displayln `(*************************************************))
(current-directory where)

; ---------------------------------------------------------------------------
; CONTENTS: my home directory

; (listof Nav-link)
(define LINKS
  (checked-links
   `(("PLT"           "http://www.racket-lang.org/")
;      ("Program by Design" "http://www.programbydesign.org/")
     ("NU PLT"        "http://www.ccs.neu.edu/racket/")
     ("NU PRL"        "http://prl.ccs.neu.edu")
     ; "http://nuprl.github.io/publications.html"
     ; http://www.ccs.neu.edu/home/matthias/friends.html
     ,LINE
     ("Books"         "books.html")
     ((nbsp nbsp nbsp "HtDP")         "http://www.htdp.org/")
     ((nbsp nbsp nbsp "HtDP/3e")      "HtDP3e/index.html")
     ((nbsp nbsp nbsp "On HtDP")      "OnHtDP/index.html")
;     ((nbsp nbsp nbsp "HtDC") "htdc.html")
     ((nbsp nbsp nbsp "Sem. Eng.") "http://redex.racket-lang.org/")
     ((nbsp nbsp nbsp "Realm of Racket") "http://realmofracket.com/")
     ; ("HtDP +"        "htdp-plus.html") ; ("HtUS" "HtUS/Book/howto.html") ; "http://www.htus.org/"
     
     ,LINE
     ("Research"      "research.html")
     ((nbsp nbsp nbsp "Publications")  "papers.html")
     ((nbsp nbsp nbsp "Presentations") "presentations.html")
     ((nbsp nbsp nbsp "JFP")           "http://journals.cambridge.org/action/displayJournal?jid=JFP")
     ((nbsp nbsp nbsp "NSF: Gradual") "http://prl.ccs.neu.edu/gtp/")

     ,LINE
     ("Teaching"      "teaching.html")
     ("Programming"      "programming.html")
     ,LINE
     ("Thoughts"      "Thoughts/index.html")
     ("Professional Coordinates" "plan.html")
     ("Miscellaneous" "misc.html")
;     ("Resources"     "resources.html")
;     ("Quotes"        "quotes.html")
     ,LINE
     ("Family"        "http://www.felleisen.org/")
     ,LINE
     ("Home"          "index.html"))))

; ---------------------------------------------------------------------------
; THE INDEX 
(produce-page "index.html"
              (html "Matthias Felleisen"
                    #false
                    (remove-link "Home" LINKS)
                    (xml "index.xml")))

(produce-page "htdp-plus.html"
              (html "Supplemental Materials for \"How to Design Programs\""
                    #f 
                    (remove-link "HTML +" LINKS) 
                    (xml "htdp-plus.xml")))

(produce-page "htdc.html"
              (html "How to Design Classes (Draft)"
                    #f 
                    (remove-link "HtDC" LINKS) 
                    (xml "htdc.xml")))

;                                                    
;                                                    
;                                                    
;   ;;;;                ;                            
;   ;   ;                                            
;   ;   ;                                 ;          
;   ;   ;  ; ;;  ;;;;   ;    ;;;    ;;;; ;;;;   ;;;; 
;   ;   ;  ;;   ;    ;  ;   ;   ;  ;      ;    ;     
;   ;;;;   ;    ;    ;  ;   ;   ;  ;      ;    ;     
;   ;      ;    ;    ;  ;   ;;;;;  ;      ;     ;;;  
;   ;      ;    ;    ;  ;   ;      ;      ;        ; 
;   ;      ;    ;    ;  ;   ;      ;      ;        ; 
;   ;      ;     ;;;;   ;    ;;;;   ;;;;   ;;  ;;;;  
;                       ;                            
;                       ;                            
;                     ;;                             

(define (project img-url url title)
  `(tr (td (img ([src ,(image img-url)][alt ""][width "50"])))
       (td (a ([href ,(path->string (build-path url "index.html"))]) ,title))))

(produce-page "research.html"
              (html "Research"
                    (image "researcher.jpg")
                    (remove-link "Research" LINKS)
                    (xml "projects.xml")))

(define (retrieve-papers) 
  (define retrieve-from-where
    (build-path (find-system-path 'home-dir) "Hub" "NUPLT/pubs.xml"))
  ;; Xexpr[publist] -> Boolean
  (define (mypaper? p)
    (pair? (regexp-match "Felleisen" (xauthors p))))
  (define raw (parameterize ([current-input-port (open-input-file retrieve-from-where)])
                (read-pure-xml)))
  (define y (map (lambda (x) `(,(car x) ,(cadr x) ,@(filter mypaper? (cddr x)))) (cddr raw)))
  (pub-directory "http://www.ccis.neu.edu/racket/pubs/")
  (map publist->html y))

(produce-page "papers.html"
              (html "Publications"
                    #f ; (image "researcher.jpg")
                    (remove-link "Publications" LINKS)
                    `(p "(papers available on-line; for others, please consult libraries)"
                        (p "(for PLT papers, see NU PLT tab on the left)"
                           ,@(retrieve-papers)))))



;                                                                                       
;                                                                                       
;                                                                                       
;   ;;;;                                                      ;                         
;   ;   ;                                                                               
;   ;   ;                                    ;           ;                              
;   ;   ;  ; ;;  ;;;    ;;;;   ;;;   ; ;;;  ;;;;   ;;;  ;;;;  ;    ;;;;   ; ;;;    ;;;; 
;   ;   ;  ;;   ;   ;  ;      ;   ;  ;;   ;  ;    ;   ;  ;    ;   ;    ;  ;;   ;  ;     
;   ;;;;   ;    ;   ;  ;      ;   ;  ;    ;  ;        ;  ;    ;   ;    ;  ;    ;  ;     
;   ;      ;    ;;;;;   ;;;   ;;;;;  ;    ;  ;     ;;;;  ;    ;   ;    ;  ;    ;   ;;;  
;   ;      ;    ;          ;  ;      ;    ;  ;    ;   ;  ;    ;   ;    ;  ;    ;      ; 
;   ;      ;    ;          ;  ;      ;    ;  ;    ;   ;  ;    ;   ;    ;  ;    ;      ; 
;   ;      ;     ;;;;  ;;;;    ;;;;  ;    ;   ;;   ;;;;;  ;;  ;    ;;;;   ;    ;  ;;;;  
;                                                                                       
;                                                                                       
;                                                                                       

(produce-page "presentations.html"
              (html "Presentations"
                    (image "present.gif")
                    (remove-link "Presentations" LINKS)
                    `(table () ,@presentations)))



;                                        
;                                        
;                                        
;   ;;;;                   ;             
;   ;   ;                  ;             
;   ;   ;                  ;             
;   ;  ;    ;;;;    ;;;;   ;   ;    ;;;; 
;   ;;;    ;    ;  ;    ;  ;  ;    ;     
;   ;  ;   ;    ;  ;    ;  ; ;     ;     
;   ;   ;  ;    ;  ;    ;  ;;;      ;;;  
;   ;   ;  ;    ;  ;    ;  ;  ;        ; 
;   ;   ;  ;    ;  ;    ;  ;   ;       ; 
;   ;;;;    ;;;;    ;;;;   ;    ;  ;;;;  
;                                        
;                                        
;                                        


; String String -> Xexpr[td]
(define (book t u)
  `(td
    (div 
     (p (a ([href ,(string-append u "index.html")]) 
           (img ([src ,(path->string (build-path u "cover-icon.jpg"))]
                 [height "85"][border "0"][alt ,t]))))
     (p ""))))

(produce-page "books.html"
              (html "Books"
                    (image "bookshelf.gif")
                    (remove-link "Books" LINKS)
                    (xml "books.xml")))


;                                                                  
;                                                                  
;                                                                  
;   ;;;;;                                                          
;   ;    ;                                                         
;   ;    ;                                                         
;   ;    ;   ;;;    ;;;;   ;;;;   ;    ;  ; ;;  ;;;;   ;;;    ;;;; 
;   ;   ;   ;   ;  ;      ;    ;  ;    ;  ;;   ;      ;   ;  ;     
;   ;;;;    ;   ;  ;      ;    ;  ;    ;  ;    ;      ;   ;  ;     
;   ;  ;    ;;;;;   ;;;   ;    ;  ;    ;  ;    ;      ;;;;;   ;;;  
;   ;   ;   ;          ;  ;    ;  ;    ;  ;    ;      ;          ; 
;   ;    ;  ;          ;  ;    ;  ;   ;;  ;    ;      ;          ; 
;   ;     ;  ;;;;  ;;;;    ;;;;    ;;; ;  ;     ;;;;   ;;;;  ;;;;  
;                                                                  
;                                                                  
;                                                                  

; String String String String[url] -> Xexpr[tr]
(define (resource image:url authors title url . optional)
  `(tr
    (td
     (img ([align "center"][src ,(image image:url)][alt "resource"]
                           ,(if (pair? optional) (car optional) '(width "50")))))
    (td (div ,authors (br) (a ([href ,url]) (i ,title))))))

(produce-page "resources.html"
              (html "Resources"
                    (image "tools.gif")
                    (remove-link "Resources" LINKS)
                    `(table
                      ,(resource "strunk.gif" 
                                 "Strunk and White" "The Elements of Style"
                                 "http://www.bartleby.com/141/index.html")
                      ,(resource "leaf.gif"
                                 "Dorai Sitaram" "Teach Yourself Scheme in Fixnum Days"
                                 "http://www.ccs.neu.edu/home/dorai/t-y-scheme/t-y-scheme.html")
                      ,(resource "sicp-small2.gif"
                                 "Abelson and Sussman, with Sussman" 
                                 "Structure and Interpretation of Computer Programs"
                                 "http://mitpress.mit.edu/sicp/sicp.html")
                      ,(resource "bar.jpg"
                                 "Barendregt" "The Lambda Calculus"
                                 "http://reference.elpress.com/readittoc.jsp?Book=0444875085")
                      ,(resource "prlpage.gif"
                                 "Constable, et alii"
                                 "Implementing Mathematics with the Nuprl Proof Development System"
                                 "http://www.cs.cornell.edu/Info/Projects/NuPrl/book/doc.html"
                                 '(height "33"))
                      ,(resource "ml.jpg"
                                 "Robert Harper" "Programming in Standard ML (PDF)"
                                 "http://www-2.cs.cmu.edu/~rwh/smlbook/offline.pdf")
		      ,(resource "delta.gif" "Felleisen"
				 "Proceedings of the 2000 Montreal Workshop on Scheme and Functional Programming"
                                 "Scheme2000/index.html")
		      ,(resource "delta.gif" "Felleisen, Thompson"
			         "Proceedings of the 1999 Paris Workshop on Functional and Declarative Programming in Education"
                                 "FDPE99/index.html")
		      )))


;                                           
;                                           
;                                           
;   ;;;;;                     ;   ;         
;   ;                             ;         
;   ;                             ;         
;   ;       ;;;   ; ;;; ;;    ;   ;  ;     ;
;   ;;;;   ;   ;  ;;  ;;  ;   ;   ;   ;   ; 
;   ;          ;  ;   ;   ;   ;   ;   ;   ; 
;   ;       ;;;;  ;   ;   ;   ;   ;    ;  ; 
;   ;      ;   ;  ;   ;   ;   ;   ;    ; ;  
;   ;      ;   ;  ;   ;   ;   ;   ;     ;;  
;   ;       ;;;;; ;   ;   ;   ;   ;     ;   
;                                       ;   
;                                       ;   
;                                      ;    

(produce-page "family.html"
              (html "Family"
                    (image "children.gif")
                    (remove-link "Family" LINKS)
		    "http://www.felleisen.org/"))

;                            
;                            
;                            
;   ;;;;   ;                 
;   ;   ;  ;                 
;   ;   ;  ;                 
;   ;   ;  ;    ;;;   ; ;;;  
;   ;   ;  ;   ;   ;  ;;   ; 
;   ;;;;   ;       ;  ;    ; 
;   ;      ;    ;;;;  ;    ; 
;   ;      ;   ;   ;  ;    ; 
;   ;      ;   ;   ;  ;    ; 
;   ;      ;    ;;;;; ;    ; and misc 
;                            
;                            
;                            

(produce-page "misc.html"
              (html "Miscellaneous"
                    (image "misc.jpg")
                    (remove-link "Miscellaneous" LINKS)
                    (xml "misc.xml")))

; -----------------------------------------------------------------------------
; PLAN
(produce-page "plan.html"
              (html "Coordinates"
                    (image "compass.gif")
                    (remove-link "Coordinates" LINKS)
                    (xml "plan.xml")))

(produce-page "quotes.html"
              (html "Quotes"
                    (image "quote.png")
                    (remove-link "Quotes" LINKS)
                    (xml "quotes.xml")))


;                                                           
;                                                           
;                                                           
;  ;;;;;;;;                      ;       ;                  
;     ;                          ;                          
;     ;                          ;                          
;     ;      ;;;    ;;;    ;;;;  ; ;;;   ;   ; ;;;    ;;; ; 
;     ;     ;   ;  ;   ;  ;      ;;   ;  ;   ;;   ;  ;   ;; 
;     ;     ;   ;      ;  ;      ;    ;  ;   ;    ;  ;    ; 
;     ;     ;;;;;   ;;;;  ;      ;    ;  ;   ;    ;  ;    ; 
;     ;     ;      ;   ;  ;      ;    ;  ;   ;    ;  ;    ; 
;     ;     ;      ;   ;  ;      ;    ;  ;   ;    ;  ;   ;; 
;     ;      ;;;;   ;;;;;  ;;;;  ;    ;  ;   ;    ;   ;;; ; 
;                                                         ; 
;                                                    ;    ; 
;                                                     ;;;;  

(produce-page "programming.html"
              (html "Programming"
                    (image "quote.png")
                    (remove-link "Programming" LINKS)
                    (xml "programming.xml")))

#| Assumption: 
  
  All course directories are located in ~matthias/Web/.
  
  The name of a course directory consists of the course number, "-", and 
  the quarter/year, e.g., w02, s02, f02. 
  
  The directory is created manually. 
  
  The parent directory contains two files: index.html and teaching.html
  |#

; Symbol String String String -> Xexpr [tr]
; generates directory name and ensure that it exists [single threading]
; term-code and term should be related [unchecked]
(define (course term-code term number course-title #:link (link #f))
  (let* ([dir-name  (format "~a-~a" number term-code)]
         [directory (string-append dir-name "/")])
    (unless (directory-exists? dir-name)
      (make-directory dir-name))
    `(tr (td ,term)
         (td ,number) 
         (td (a ([href ,(or link (string-append directory "index.html"))])
                ,course-title)))))

(define (old-course term-code term number course-title)
  `(tr (td ,term) (td ,number) (td  ,course-title)))

(produce-page
 "teaching.html"
 (html "Teaching @ NU"
       (image "teacher.gif")
       (remove-link "Teaching" LINKS)
       `(table ([valign "top"])
	      ,(course 's18 "Spring 2018" "4620" "Hack Your Own Language")
	      ,(course 'f17 "Fall 2017" "2500" "Principles of Computing and Programming (Accelerated)"
                        #:link "http://www.ccs.neu.edu/course/cs2500accelf17/")
	       ,(course 's17 "Spring 2017" "7480" "History of Programming Languages")
               ,(course 'f16 "Fall 2016" "2500" "Principles of Computing and Programming"
                        #:link "http://www.ccs.neu.edu/course/cs2500f16/")
               ,(course 's16 "Spring 2016" "4500" "Software Development")
	       ,(course 's15 "Spring 2015" "4620"  "Building Extensible Systems")
               ,(course 's14 "Spring 2014" "7400"  "Principles of Programming Languages (PhD)")
               ,(course 'f13 "Fall 2013" "2500" "Principles of Computing and Programming"
                        #:link "http://www.ccs.neu.edu/course/cs2500f13/")
               ,(course 's13 "Spring 2013" "6515" "Software Development")
               ,(course 'f12 "Fall 2012" "7400"  "Principles of Programming Languages (PhD)")
               ,(course 'f11 "Fall 2011" "7400"  "Principles of Programming Languages (PhD)")
               ,(course 's11 "Spring 2011" "6515"  "Software Development")
               ,(course 'f10 "Fall 2010" "7400"  "Principles of Programming Languages (PhD)")
               ,(course 's10 "Spring 2010" "369"  "History of Programming Languages")
               ,(course 'f09 "Fall 2009" "107"  "Program Design Paradigms")
               ,(course 's09 "Spring 2009" "379"  "Practical Tools for Working Semanticists")
               ,(course 'f08 "Fall 2008" "107"  "Program Design Paradigms")
               ,(course 's07 "Spring 2007" "670"  "Software Construction")
               ,(course 'f06 "Fall 2006" "211"  "Principles of Computing and Programming")
               ,(course 'f05 "Fall 2005" "711"  "Principles of Programming Languages (PhD)")
               ,(course 'f05 "Fall 2005" "211"  "Principles of Computing and Programming")
               ,(course 's05 "Spring 2005" "670"  "Software Construction")
               ,(course 'f04 "Fall 2004"   "211"  "Principles of Computing and Programming")
               ,(course 's04 "Spring 2004" "369"  "History of Programming Languages")
               ,(course 'f03 "Fall 2003"   "211"  "Principles of Computing and Programming")
               ,(old-course 's03 "Spring 2003" "1205" "Software Design and Development")              
               ,(old-course 'f02 "Fall 2002"   "1100" "Principles of Computing and Programming")
               ,(old-course 's02 "Spring 2002" "1205" "Software Design and Development")
               ,(old-course 'w02 "Winter 2002" "3810" "Topics in Programming Languages: Type Theory")
               ,(old-course 'f01 "Fall 2001"   "1358" "Principles of Programming Languages"))))
;                                                
;                                                
;                                                
;   ;;;;;       ;                       ;        
;   ;                                   ;        
;   ;                                   ;        
;   ;      ; ;; ;    ;;;   ; ;;;    ;;; ;   ;;;; 
;   ;;;;   ;;   ;   ;   ;  ;;   ;  ;   ;;  ;     
;   ;      ;    ;   ;   ;  ;    ;  ;    ;  ;     
;   ;      ;    ;   ;;;;;  ;    ;  ;    ;   ;;;  
;   ;      ;    ;   ;      ;    ;  ;    ;      ; 
;   ;      ;    ;   ;      ;    ;  ;   ;;      ; 
;   ;      ;    ;    ;;;;  ;    ;   ;;; ;  ;;;;  
;                                                
;                                                
;                                                


(define (friend name-link)
  `(div (a ([href ,(cadr name-link)]) ,(car name-link))))

(produce-page 
 "friends.html"
 (html "" ; "PLT Friends"
       #f ; (image "friends.gif") 
       (remove-link "PLT Friends" LINKS)
       `(table ([background "Images/mx.jpg"][height "600"][width "500"])
               (tr  ([valign "middle"][width "100%"])
                    (td ([align "right"])
                        ,@(map (lambda (x)
                                 `(p
                                   (a ([href ,(cadr x)][style "text-decoration: none"])
                                      (font ([size "+2"][color "red"]) (b ,(car x))))))
                               '(("John Clements"         "http://www.csc.calpoly.edu/~clements/")
                                 ("Matthew Flatt"         "http://www.cs.utah.edu/~mflatt/")
                                 ("Robby Findler"         "http://people.cs.uchicago.edu/~robby/")
                                 ("Shriram Krishnamurthi" "http://www.cs.brown.edu/~sk/")
                                 ("Kathi Fisler"          "http://www.cs.wpi.edu/~kfisler/"))))))))

(all-pages-produced?)

(system "open index.html")

