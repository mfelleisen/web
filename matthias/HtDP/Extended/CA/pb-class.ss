
;; VISUAL REPRESENTATIONS: 
(define WHITE (rectangle 10 10 'outline 'black))
(define BLACK (rectangle 10 10 'solid 'black))

(define cell% 
  (class object% 
    (init-field c)
    
    (define/public (color) c)
    
    (field
     (left this)
     (right this)) 
    
    (define/public (wire-up l r)
      (set! left l)
      (set! right r))
    
    (define/public (draw)
      (cond [(symbol=? 'white c) WHITE]
            [(symbol=? 'black c) BLACK]))
    
    (define (next l c)      
      (cond
        [(equal? l '(black black black)) 'white]
        [(equal? l '(black black white)) 'white]
        [(equal? l '(black white black)) 'white]
        [(equal? l '(black white white)) 'black]
        [(equal? l '(white black black)) 'black]
        [(equal? l '(white black white)) 'black]
        [(equal? l '(white black black)) 'black]      
        [(equal? l '(white white black)) 'black]      
        [(equal? l '(white white white)) 'white]))
    
    (define/public (switch)
      (new cell% (c (next (list (send left color) c (send right color)) c))))
    
    (super-new)))

(define world%
  (class object% 
    (init-field cells image)
    
    (define (wire-up cells)
      (for-each (lambda (i) 
                  (send (vector-ref cells i) wire-up
                        (vector-ref cells (modulo (- i 1) 31))
                        (vector-ref cells (modulo (+ i 1) 31))))
                (build-list 31 identity))
      cells)
    
    (define/public (tock)
      (let ([img (image-stack 
                  (list (image-append
                         (map (lambda (c) (send c draw)) (vector->list cells)))
                        image))])
        (update 
         img
         produce
         (new world%
              [cells (vmap (lambda (c) (send c switch)) cells)]
              [image img]))))
    
    (super-new)
    
    (wire-up cells)))

(define world0 
  (new world% 
       [cells (build-vector 31 (lambda (i) (new cell% (c (if (=  i 15) 'black 'white)))))]
       [image (rectangle 1 1 'solid 'red)]))

(define (vmap f cells)
  (list->vector (map f (vector->list cells))))



;; -----------------------------------------------------------------------------
;; 5: Auxiliary Functions 

;; (NE.Listof Image) -> Image 
;; juxtapose the images from the non-empty loi
(define (image-append loi)
  (cond
    [(empty? (rest loi)) (first loi)]
    [else (overlay/xy (first loi) 10 0 (image-append (rest loi)))]))


;; (NE.Listof Image) -> Image 
;; stack up the pictures in this list
(define (image-stack loi)
  (cond
    [(empty? (rest loi)) (first loi)]
    [else (overlay/xy (first loi) 0 -10 (image-stack (rest loi)))]))

;; -----------------------------------------------------------------------------
;; Symbol -> Void
;; create the canvas, start the clock; specify how to deal with ticks
(define (main dummy)
  (and (big-bang 300 HEIGHT .1 world0)
       (on-tick-event (lambda (world) (send world tock)))))

;; enlarge if you want to see more 
(define HEIGHT 250)

(main 'm)