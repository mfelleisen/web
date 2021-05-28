;; -----------------------------------------------------------------------------
;; MAIN: 

;; String -> String
(define (main name)
  (announcement
   (fly-until-down (create-ufo (/ WIDTH 2)) (create-platform (/ WIDTH 2)))
   name))

;; Boolean String -> String 
(define (announcement result name)
  (string-append name
                 (cond
                   [result " is a loser"]
                   [else   " is a winner"])))

;; UFO Platform -> Boolean
;; if UFO lands on the platform, produce false (meaning the player lost)
(define (fly-until-down ufo platf)
  (cond
    [(below-ground? ufo) (not (landed-on-platform? platf ufo))]
    [(hit-shot? platf ufo) (not (draw-scene ufo platf))]
    [else
     (and (draw-scene ufo platf)
          (sleep-for-a-while .05)
          (clear-scene ufo platf)
          (fly-until-down (move-ufo ufo) (move-plat platf (get-key-event))))]))

;; UFO Platform -> true
(define (draw-scene p i) (and (draw-ufo p) (draw-platform i)))

;; UFO Platform -> true
(define (clear-scene p i) (and (clear-ufo p) (clear-platform i)))


;; -----------------------------------------------------------------------------
;; UFO

;; UFO = Posn 
;;  where left-most, lower-most point of UFO is located 

;; create-ufo : Number -> UFO
(define (create-ufo n) (make-posn n 0))

;; below-ground? : UFO -> Boolean
(define (below-ground? p) (> (posn-y p) HEIGHT))

;; Posn -> true
(define (fff-ufo solid-disk solid-rect line)
  (lambda (p)
    (and 
     (solid-rect p UFO-WIDTH UFO-HEIGHT 'green)
     (solid-disk (posn+ p (make-posn (/ UFO-WIDTH 2) +1)) UFO-RADIUS 'green))))

(define UFO-WIDTH 20)
(define UFO-HEIGHT 3)
(define UFO-RADIUS 3)

;; draw-ufo : UFO -> true
(define draw-ufo (fff-ufo draw-solid-disk draw-solid-rect draw-solid-line))

;; clear-ufo : UFO -> true
(define clear-ufo (fff-ufo clear-solid-disk clear-solid-rect clear-solid-line))

;; move-ufo : Platform -> Platform 
(define (move-ufo p)
  (cond
    [(<= 0 (posn-x p) WIDTH) (posn+ p (make-posn (- (random 8) 4) 3))]
    [(> (posn-x p) WIDTH) (posn+ p (make-posn -2 3))]
    [(< (posn-x p) 0) (posn+ p (make-posn 2 3))]))

;; -----------------------------------------------------------------------------
;; Platform 

(define-struct platform (posn shot))
;; Platform = (create-platform Posn Shot)
;;  posn-x interval: left boundary
;;  posn-y interval: width of interval 

;; Shot = Posn u false 
;;  where is the top of the shot located

;; Number -> Platform
(define (create-platform n) (make-platform (make-posn n 10) #f))

;; Platform UFO -> Boolean
(define (hit-shot? p ufo)
  (cond
    [(boolean? (platform-shot p)) false]
    [else 
     (and (<= (posn-x ufo) (posn-x (platform-shot p)) (+ (posn-x ufo) UFO-WIDTH))
          (<= (posn-y (platform-shot p)) (posn-y ufo) (+ (posn-y (platform-shot p)) SHOT-LENGTH)))]))

;; landed-on-platform? : Platform UFO -> Boolean
(define (landed-on-platform? p ufo) 
  (<= (posn-x (platform-posn p)) 
      (posn-x ufo) 
      (+ (posn-x (platform-posn p)) (posn-y (platform-posn p)))))

;; ... ... ... Posn Posn -> true
(define (fff-platform solid-disk solid-rect line p q)
  (and
   (solid-rect (make-posn (posn-x p) (- HEIGHT 3)) (posn-y p) 3 'blue)
   (cond
     [(boolean? q) true]
     [else (solid-rect q SHOT-WIDTH SHOT-LENGTH 'red)])))
    
(define SHOT-LENGTH 5)
(define SHOT-WIDTH  2)

;; draw-platform : Platform -> true
(define (draw-platform p)
  (fff-platform draw-solid-disk draw-solid-rect draw-solid-line 
                (platform-posn p) (platform-shot p)))

;; clear-platform : Platform -> true
(define (clear-platform p)
  (fff-platform clear-solid-disk clear-solid-rect clear-solid-line 
                (platform-posn p) (platform-shot p)))

;; Platform Event -> Platform 
(define (move-plat p q)
  (move-shot
   (cond
     [(boolean? q) p]
     [(char? q) p]
     ;; now we know it's a symbol
     [(symbol=? 'left  q) (move-platform p -5)]
     [(symbol=? 'right q) (move-platform p +5)]
     [(symbol=? 'up q) (fire-platform p)]
     [else p])))

;; move-platform : Platform Number -> Platform 
(define (move-platform p d)
  (make-platform (posn+ (platform-posn p) (make-posn d 0)) (platform-shot p)))

;; Platform -> Platform 
(define (move-shot p)
  (cond
    [(boolean? (platform-shot p)) p]
    [else 
     (make-platform (platform-posn p) (posn+ (platform-shot p) (make-posn 0 -10)))]))

;; Platform -> Platform 
(define (fire-platform p)
  (cond
    [(boolean? (platform-shot p)) 
     (make-platform (platform-posn p) (mid-platform (platform-posn p)))]
    [else p]))

;; middle : Posn -> Posn
(define (mid-platform p)
  (make-posn (+ (posn-x p) (/ (posn-y p) 2)) HEIGHT))

;; -----------------------------------------------------------------------------
;; Auxiliaries

;; Posn Posn -> Posn 
(define (posn+ p q)
  (make-posn (+ (posn-x p) (posn-x q)) (+ (posn-y  p) (posn-y  q))))

(define WIDTH 200)
(define HEIGHT 500)


;; tests

(not (landed-on-platform? (make-platform (make-posn 0 10) #f) (make-posn 22 0)))
(landed-on-platform? (make-platform (make-posn 0 10) #f) (make-posn 5 0))

;; -----------------------------------------------------------------------------
;; run program run

(start WIDTH HEIGHT)
(main "matthias")
