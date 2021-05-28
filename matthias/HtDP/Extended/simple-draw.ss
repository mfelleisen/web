(module simple-draw mzscheme
  
  (require (lib "draw.ss" "htdp")
           (prefix adv: (lib "htdp-advanced.ss" "lang")))
  
  (provide draw)
  
  (provide 
   start            ; Number Number -> true
   big-bang         ; Number X -> true
   on-tick-event    ; (X -> X) -> true
   end-of-time      ; -> X 
   on-key-event     ; ((union Char Symbol) X -> X) -> true
   draw-solid-disk0 ; Number Number Number Color -> true
   draw-solid-rect0 ; Number Number Number Number Color -> true
   draw-solid-line0 ; Number Number Number Number Color -> true
   )
  
  (define (draw-solid-disk0 x y r c) (draw-solid-disk (adv:make-posn x y) r c))
  (define (draw-solid-rect0 x y w h c) (draw-solid-rect (adv:make-posn x y) w h c))
  (define (draw-solid-line0 x0 y0 x1 y1 c) 
    (draw-solid-line (adv:make-posn x0 y0) (adv:make-posn x1 y1) c))
  )

    
   
