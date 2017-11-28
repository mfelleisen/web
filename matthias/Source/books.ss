#lang racket

(provide book-index)

(require
 (lib "web-page.ss" "web")
 (lib "xml-qq.ss" "web"))

;; assume:
;; book directory contains
;; index.xml : a blurb
;; cover-sm.jpg : a cover picture
;; [*] toc, foreword, preface, faq, errata

;; generate index.html from that
;; TODO: process toc, foreword, preface, faq, errata

; String Xepxr String String[url] String[url] (list String String[url])
; -> Void
; effect: produce index for a book
(define (book-index title blurb:xexpr by pub:link amazon:link #:schemer [schemer? #f] . label-url)
  (produce-page "index.html"
                (html title
                      "cover-sm.jpg"
                      (book-links title)
                      `(div
                        (hr)
                        ,blurb:xexpr
                        (hr)
                        ,(append
                          `(ul
                            ,@(info "toc.html"      "Table of Contents")
                            ,@(info "foreword.html" (string-append "Foreword by " by))
                            ,@(info "preface.html"  "Preface")
                            ,@(info "sample.pdf"    "Sample Chapter")
                            ,@(info "faq.html"      "Frequently Asked Questions")
                            ,@(info "errata.html"   "Errata")
                            ,@(if schemer?
                                  (exfo "mailto:schemer-books@googlegroups.com"
                                        "Google Groups (thanks to Samuel Joseph for setting it up)")
                                  '()))
                          (apply append
                                 (map exfo (map cadr label-url) (map car label-url))))
                        ,@(if (string=? by "") '() '((hr)))
                        (table ([width "100%"])
                               (tr
                                (td ([align "left"]) (a ([href ,pub:link]) "MIT Press"))
                                (td ([align "right"]) (a ([href ,amazon:link]) "Amazon.com")))))
                      #;
                      45)))

#|
 <ul>
  <li> <a href ="toc.html">Table of Contents</a> </li>
  <li> <a href ="foreword.html">Foreword</a></li>
  <li> <a href ="preface.html">Preface</a></li>
  <li> <a href ="faq.html">Frequently Asked Questions </a></li>
  <li> <a href =>Amazon</a></li>
  <li> <a href = > </a></li>
 </ul>
|#

; String String -> Xexpr[li]
(define (info file-name label)
  (if (file-exists? file-name) (exfo file-name label) '()))

(define (exfo file-name label)
  `((li (a ([href ,file-name]) ,label))))

; String -> (listof Nav-Link)
; produce a standard list of links from book Title 
(define (book-links self-book)
  (remove-link self-book
               `(("Home"          "../index.html")
                 ("Books"         "../books.html")
                 ,LINE
                 ("The Little Schemer"   "../BTLS/")
                 ("The Seasoned Schemer" "../BTSS/")
                 ("A Little Java"        "../BALJ/")
                 ("The Little MLer"      "../BTML/")
                 ("How to Design Programs" "http://www.htdp.org/")
                 ("Semantics Engineering"  "http://redex.plt-scheme.org/")
                 ,LINE
                 ("The Reasoned Schemer"      "../BRS/")
                 )))

