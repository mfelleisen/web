#lang racket
(require
  (lib "xml-qq.ss" "web")
  "../Source/books.ss")

(define by "Ralph E. Johnson")

(book-index
  "A Little Java"
  (xml "index.xml")
  by
  ; Publisher's Page:
  "http://mitpress.mit.edu/catalog/item/default.asp?sid=86C0EAF5-85CE-41EB-AE2C-828F76F52209&ttype=2&tid=3609"
  ; AMAZON's Page
  "http://www.amazon.com/exec/obidos/ASIN/0262561158/qid=1010888710/sr=2-3/ref=sr_2_11_3/103-5471398-9229403"
  '("A Sample Page" "y-java.pdf")
  '("Information about Java" "http://www.javasoft.com/")
  )
    
  
