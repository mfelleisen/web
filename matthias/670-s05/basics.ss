(module basics mzscheme 

  (provide generalp red-title)

  ; String -> Xexpr[p]
  ;; a red-colored italics word 
  (define (red-title title)
    `(font ([color "red"][style "italic"]) ,title))


  ;; String -> Xexpr[div]
  ;; a red-colored title
  (define (generalp title)
    `(div (hr) (font ([color "red"]) ,title)))
)
