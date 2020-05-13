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
      (define (retrieve-time-and-add f)
        (define fst (with-input-from-file f read-line))
        (define mch (regexp-match "<div time=\"([0-9]*)\">" fst))
        (define tme (current-seconds))
        (if mch
            (string->number (cadr mch))
            (begin 
              (copy-except-for-first-line f (format "<div time=~s>" (number->string tme)))
              tme)))
      (define (copy-except-for-first-line f ln)
        (define ftmp (make-temporary-file "blog~a.xml" f))
        (with-input-from-file ftmp
          (lambda () 
            (read-line)
            (with-output-to-file f
              (lambda ()
                (display ln) (newline)
                (let L ()
                  (define next (read-char))
                  (unless (eof-object? next) 
                    (write-char next)
                    (L))))
              'truncate))))
      (define (time-tag-or-read-time x)
        (list x (retrieve-time-and-add x)))
      [define dir (directory-list)]
      [define xml (filter (lambda (x) (regexp-match "\\.xml$" (path->bytes x))) dir)]
      [define dts (map time-tag-or-read-time xml)]
      [define srt (sort dts (lambda (x y) (> (cadr x) (cadr y))))]
      [define txt (map (lambda (x)
			 (with-handlers ([exn:xml? (lambda (ex)
						     (printf "processing ~a\n" (car x))
						     (raise ex))])
			   (list (with-input-from-file (car x) read-xml/element)
			     (cadr x))))
                       srt)]
      [define fnl (map (lambda (x)
                         (list (car x) (date->string (seconds->date (cadr x)))))
                       txt)]
      ; xexpr->xml
       `(div () 
             (h3 "Important Messages from the Instructors")
             ,@(map format-blog fnl))))
  
  ;; (list Element String) -> Xexpr[div]
  (define (format-blog x)
    (let ([ele (car x)]
          [dat (cadr x)])
      `(div ()
            (hr)
            (p (b ,dat))
            (blockquote ,(xml->xexpr ele)))))
  
  )
