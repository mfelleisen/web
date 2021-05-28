(module io mzscheme
  (provide
    read ;; IPort -> S-expression
    open-input-file ;; String -> IPort 
    (rename displayt display) ;; S-expression -> true 
    (rename newlinet newline) ;; -> true
    )
  
  (define (displayt s) (display s) #t)
  
  (define (newlinet) (newline) #t)
  
  )
