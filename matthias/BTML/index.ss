(module index mzscheme
  (require
    (lib "xml-qq.ss" "web")
    "../Source/books.ss")

  (define by "Robin Milner")

  (book-index
    "The Little MLer"
    (xml "index.xml")
    by
    ; Publisher's Page:
    "http://mitpress.mit.edu/catalog/item/default.asp?sid=86C0EAF5-85CE-41EB-AE2C-828F76F52209&ttype=2&tid=4787"
    ; AMAZON's Page
    "http://www.amazon.com/exec/obidos/ASIN/026256114X/ref=pd_sim_books/103-5471398-9229403"
    '("A Sample Page" "y-sml.pdf")
    '("A Companion to Chapter 10" "SML/")
    '("Information about SML and the SML/NJ implementation"
      "http://cm.bell-labs.com/cm/cs/what/smlnj/index.html")
    ))
    
  
