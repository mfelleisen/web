#!/bin/sh
string=? ; exec mred -r $0 "$@"

(define LEGACY
  '( "PL"
     "HtDP2e"
     "1358-f01"
     "f03"
     "s03"
     "f02"
     "s02"
     "w02"
     "HtDP"
     "/211"
     "/670"
     "Helga"
    ))
 
; String [directory name] -> Void
; effect: require index.ss for the current directory and all
; subdirectoires, thus recreating the html files 
(define (all dir)
  (printf "all @ ~s\n" dir)
  (parameterize ([current-directory dir])
    (parameterize ([current-load-relative-directory (current-directory)])
      (when (and
	      (file-exists? "index.ss")
              (not (ormap (lambda (x) (regexp-match x (path->string (current-directory)))) LEGACY)))
	(printf "Making Web pages in ~a~n" (current-directory))
	(dynamic-require "index.ss" #f)
	(printf " ... done ~a~n" (current-directory)))

      (for-each (lambda (fd) (when (directory-exists? fd)
			       (printf "-> ~s\n" fd)
			       (all fd)))
	        (directory-list)))))

(all (current-directory))
