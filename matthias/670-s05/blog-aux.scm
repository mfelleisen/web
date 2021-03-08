(module blog-aux mzscheme
   
  (require (lib "list.ss")
           (lib "file.ss")
           (lib "date.ss")
           (lib "xml.ss" "xml"))

  (provide 
   blog ;; -> Element(XML)
   )

  ;; -> XML
  ;; create a single [div] from the blogs in the Blog/ directory
  (define (blog)
    (parameterize ([current-directory "Blog"]) 
      (let* ([dir (directory-list)]
             [xml (filter (lambda (x) (regexp-match "\\.xml$" (path->bytes x))) dir)]
             [dts (map (lambda (x)
                         (list x (file-or-directory-modify-seconds x))) 
                       xml)]
             [srt (quicksort dts (lambda (x y) (> (cadr x) (cadr y))))]
             [txt (map (lambda (x)
                         (list (with-input-from-file (car x) read-xml/element)
                               (cadr x)))
                       srt)]
             [fnl (map (lambda (x)
                         (list (car x)
                               (date->string (seconds->date (cadr x)))))
                       txt)])
        (xexpr->xml
         `(div () 
               ; (h3 "Important Messages from the Instructors")
	    ,@(map format-blog fnl))))))
  
  ;; (list Element String) -> Xexpr[div]
  (define (format-blog x)
    (let ([ele (car x)]
          [dat (cadr x)])
      `(div ()
	 (p (b ,dat))
	 (hr)
	 ,(xml->xexpr ele))))

  )
