(module index mzscheme
  (require
    (lib "xml-qq.ss" "web")
    "../Source/books.ss")

  (define by "")

  (book-index
    "The Little Prover"
    (xml "index.xml")
    by
    ; Publisher's Page:
"https://mitpress.mit.edu/books/little-prover"
    ; AMAZON's Page
"http://www.amazon.com/Little-Prover-Daniel-P-Friedman/dp/0262527952/ref=sr_1_3?s=books&ie=UTF8&qid=1452004703&sr=1-3&keywords=daniel+p+friedman"
    ))
    
  
