#lang racket

(require
  (lib "xml-qq.ss" "web")
  "../Source/books.rkt")

(define by "Gerald J. Sussman")

(book-index
  "The Little Schemer"
  (xml "index.xml")
  by
  ; Publisher's Page:
  "http://mitpress.mit.edu/catalog/item/default.asp?sid=86C0EAF5-85CE-41EB-AE2C-828F76F52209&ttype=2&tid=4825"
  ; AMAZON's Page
  "http://www.amazon.com/exec/obidos/ASIN/0262560992/ref=pd_sim_books/103-5471398-9229403"
  '("Exercises: TLL/3rd" "exercises.pdf")
  '("A Food Preparation Place" "dan-s-burgers.gif")
  #:schemer #t
  )
    
  
