(module index mzscheme
  (require
    (lib "xml-qq.ss" "web")
    "../Source/books.ss")

  (define by "")

  (book-index
    "The Reasoned Schemer"
    (xml "index.xml")
    by
    ; Publisher's Page:
    "http://mitpress.mit.edu/catalog/item/default.asp?ttype=2&tid=10663"
    ; AMAZON's Page
"http://www.amazon.com/exec/obidos/tg/detail/-/0262562146/qid=1129928921/sr=2-1/ref=pd_bbs_b_2_1/002-5049180-6327265?v=glance&s=books"
;    '("Exercises: TLL/2nd" "exercises.ps")
;    '("A Food Preparation Place" "dan-s-burgers.gif")
    ))
    
  
