;; -----------------------------------------------------------------------------
;; MAIN: 

;; AUP -> Boolean
;; move an AUP at most n times 
(define (move-n-times n an-aup)
  (cond
    [(zero? n) true]
    [else
     (and (draw-aup an-aup)
          (sleep-for-a-while .05)
          (clear-aup an-aup)
          (move-n-times (sub1 n) (move-plat an-aup (get-key-event))))]))

;; -----------------------------------------------------------------------------
;; AUP

(define-struct aup (posn shot))
;; Platform = (create-aup Posn Shot)
;;  posn-x interval: left boundary
;;  posn-y interval: width of interval 

;; Shot = Posn u false 
;;  where is the top of the shot located

;; Number -> Platform
(define (create-aup n) (make-aup (make-posn n 10) #f))

;; Platform UFO -> Boolean
(define (hit-shot? p ufo)
  (cond
    [(boolean? (aup-shot p)) false]
    [else 
     (and (<= (posn-x ufo) (posn-x (aup-shot p)) (+ (posn-x ufo) UFO-WIDTH))
          (<= (posn-y (aup-shot p)) (posn-y ufo) (+ (posn-y (aup-shot p)) SHOT-LENGTH)))]))

;; landed-on-aup? : Platform UFO -> Boolean
(define (landed-on-aup? p ufo) 
  (<= (posn-x (aup-posn p)) 
      (posn-x ufo) 
      (+ (posn-x (aup-posn p)) (posn-y (aup-posn p)))))

;; ... ... ... Posn Posn -> true
(define (fff-aup solid-disk solid-rect line p q)
  (and
   (solid-rect (make-posn (posn-x p) (- HEIGHT 3)) (posn-y p) 3 'blue)
   (cond
     [(boolean? q) true]
     [else (solid-rect q SHOT-WIDTH SHOT-LENGTH 'red)])))
    
(define SHOT-LENGTH 5)
(define SHOT-WIDTH  2)

;; draw-aup : Platform -> true
(define (draw-aup p)
  (fff-aup draw-solid-disk draw-solid-rect draw-solid-line 
                (aup-posn p) (aup-shot p)))

;; clear-aup : Platform -> true
(define (clear-aup p)
  (fff-aup clear-solid-disk clear-solid-rect clear-solid-line 
                (aup-posn p) (aup-shot p)))

;; Platform Event -> Platform 
(define (move-plat p q)
  (move-shot
   (cond
     [(boolean? q) p]
     [(char? q) p]
     ;; now we know it's a symbol
     [(symbol=? 'left  q) (move-aup p -5)]
     [(symbol=? 'right q) (move-aup p +5)]
     [(symbol=? 'up q) (fire-aup p)]
     [else p])))

;; move-aup : Platform Number -> Platform 
(define (move-aup p d)
  (make-aup (posn+ (aup-posn p) (make-posn d 0)) (aup-shot p)))

;; Platform -> Platform 
(define (move-shot p)
  (cond
    [(boolean? (aup-shot p)) p]
    [else 
     (make-aup (aup-posn p) (posn+ (aup-shot p) (make-posn 0 -10)))]))

;; Platform -> Platform 
(define (fire-aup p)
  (cond
    [(boolean? (aup-shot p)) 
     (make-aup (aup-posn p) (mid-aup (aup-posn p)))]
    [else p]))

;; middle : Posn -> Posn
(define (mid-aup p)
  (make-posn (+ (posn-x p) (/ (posn-y p) 2)) HEIGHT))

;; -----------------------------------------------------------------------------
;; Auxiliaries

;; Posn Posn -> Posn 
(define (posn+ p q)
  (make-posn (+ (posn-x p) (posn-x q)) (+ (posn-y  p) (posn-y  q))))

(define WIDTH 200)
(define HEIGHT 500)


;; tests


(landed-on-aup? (make-aup (make-posn 0 10) #f) (make-posn 5 0))

;; -----------------------------------------------------------------------------
;; run program run

(start WIDTH HEIGHT)
(move-n-times 10000 (create-aup 0))
