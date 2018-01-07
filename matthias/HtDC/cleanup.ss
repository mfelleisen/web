#! /bin/sh
#|
exec mzscheme -qu "$0" ${1+"$@"}
|#

;; todo: clean up #i1.414 in the section on arithmetic 

#lang scheme 

;; Change all occurrences of #t to true and #f to false in 
;; the .html files of this directory. 

(define (main)
  (define all (directory-list))
  (for-each fix-1-file
            (filter (lambda (f) (regexp-match ".html$" (path->string f))) all)))

;; String -> Void 
;; given the file name ... 
(define (fix-1-file file-name)
  (define (change-all)
    (define (loop)
      (define next (read-char))
      (unless (eof-object? next) 
        (cond
          [(char=? next #\#)
           (let ([next2 (read-char)])
              (cond
                [(char=? next2 #\t) (display "true")]
                [(char=? next2 #\f) (display "false")]
                [else (display next) (display next2)]))]
          [(char=? next #\-)
           (let ([next2 (read-char)])
             (if (char=? #\1 next2)
                 (let ([next3 (read-char)])
                   (if (char=? #\. next3)
                       (let ([next4 (read-char)])
                         (if (char=? #\0 next4)
                             (display "#i-1.0")
                             (for-each display (list #\- #\1 #\. next4))))
                       (for-each display (list #\- #\1 next3))))
                 (for-each display (list #\- next2))))]
          [else (display next)])
        (loop)))
    (with-output-to-file "tmp.html" loop #:exists 'truncate))  
  (with-input-from-file file-name change-all)
  (rename-file-or-directory "tmp.html" file-name #t))

; (fix-1-file "Prologue.html")

;; now display the file
(require net/sendurl)
;(send-url (format "file:///~a~a" (path->string (current-directory)) "Prologue.html"))

(main)
