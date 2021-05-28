(module webpages mzscheme
  (require (lib "xml.ss" "xml"))
  (provide 
   write-page ; String Xexpr -> true
   ul         ; (Listof X) -> Xexpr[ul]
   li         ; Xexpr -> Xexpr[li]
   table      ; (Listof (Listof X)) -> Xexpr[table]
   tr         ; Xexpr -> Xexpr[tr]
   td         ; Xexpr -> Xexpr[td]    
   )

  ;; String[file name] Xexpr -> true
  (define (write-page file x)
    (with-output-to-file file 
      (lambda () (display-xml/content (xexpr->xml x)))
      'replace)
    #t)
  
  ;; (Listof (Listof x)) -> Xexpr[table]
  (define (table t)
    `(table ,(map (lambda (row) (tr (map td row))))))
  (define (tr x) `(tr ,x))
  (define (td x) `(td ,x))
  
  ;; (Listof X) -> Xpexr[UL]
  (define (ul l) `(ul ,(map li l)))
  (define (li x) `(li ,x))

  )
