#lang racket 

(require
  (lib "xml-qq.ss" "web")
  "../Source/books.ss")

(define by "Guy L. Steele Jr.")

(book-index
  "The Seasoned Schemer"
  (xml "index.xml")
  by
  ; Publisher's Page:
  "http://mitpress.mit.edu/catalog/item/default.asp?sid=86C0EAF5-85CE-41EB-AE2C-828F76F52209&ttype=2&tid=7510"
  ; AMAZON's Page
  "http://www.amazon.com/exec/obidos/ASIN/026256100X/ref=pd_sim_books/103-5471398-9229403"
  '("Another Food Preparation Place" "matthias-s-pizzas.gif")
  '("Reader Contribution: rember-upto-last in \"one line\"" "rutl.html")
  '("Reader Contribution: rember-upto-last without cons-ing" "rember-upto-last.html")
  #:schemer #t
  )
