(module index mzscheme
  
  (require
   (file "../basics.ss")
   (lib "teaching.ss" "web")
   (lib "web-page.ss" "web")
   (lib "xml-qq.ss" "web")  
   (lib "xml.ss" "xml")
   (lib "list.ss"))
  
  (define THIS-COURSE "670 S '05")

  (define WEEKS
    (map (lambda (f) (cadr (regexp-match "([0-9][0-9]*).xml$" (path->string f))))
         (filter (lambda (f) (regexp-match "[0-9][0-9]*.xml$" (path->string f)))
                 (directory-list))))

  (set! WEEKS
    (quicksort WEEKS
      (lambda (x y) (< (string->number x) (string->number y)))))

  'weeks: (printf "~s ~n" WEEKS)
  
  ;; (listof (list String[title] String[link]))
  (define LINKS-1100
    (checked-links
     `(("Teaching"    "../../index.html")
       (,THIS-COURSE  "../index.html")
       (nbsp #f)
       ("Lectures"      "index.html")
       ,@(map (lambda (x) `(,(format "Lecture ~a" x) ,(format "~a.html" x)))
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
     (html title icon (remove-link "Lectures" LINKS-1100) xml)))
  
  (define (read-lecture no)
    (let* ([x (read-xml/element (open-input-file no))]
           [y (xml->xexpr x)]
	   ;; assert: (assignment ...) must occur in (cdr y)
           [title (cadr y)]
	   [title (cadr (car title))]
	   [z `(div ,@(cdddr y))])
      (values (xexpr->xml z) title)))
  
  ;; --- PAGES --- 

  (define titles* '())
  (for-each (lambda (x)
              (let ([file (format "~a.xml" x)])
                (when (file-exists? file)
                  (let-values ([(a title) (read-lecture (format "~a.xml" x))])
		    (set! titles* (cons title titles*))
                    (write-normal-page
                     (format "~a.html" x)
                     (format "Lecture ~a: ~a" x title)
                     a)))))
            WEEKS)
  (set! titles* (reverse titles*)) ; (printf "~s~n" titles*)

  (write-index-page "Lectures" #f (xml "index.xml"))

  (all-pages-produced?)
  
  )
