;; UFO = Posn

;; \scheme{UFO -> Boolean}
;; fly UFO until it lands on bottom 
(define (fly-until-down ufo)
  (cond
    [(at-bottom? ufo) true]
    [else
     (and (draw-ufo ufo)
          (sleep-for-a-while .05)
          (clear-ufo ufo)
          (fly-until-down (move-ufo ufo)))]))

;; -----------------------------------------------------------------------------
;; UFOs

;; create-ufo : Number -> UFO
(define (create-ufo n) (make-posn n 0))

;; move-ufo : Platform -> Platform 
(define (move-ufo p)
  (cond
    [(<= 0 (posn-x p) WIDTH) (posn+ p (make-posn (- (random 8) 4) 3))]
    [(> (posn-x p) WIDTH) (posn+ p (make-posn -2 3))]
    [(< (posn-x p) 0) (posn+ p (make-posn 2 3))]))

;; at-bottom? : UFO -> Boolean
(define (at-bottom? p) (> (posn-y p) HEIGHT))

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

;; -----------------------------------------------------------------------------
;; Auxiliaries

;; Posn Posn -> Posn 
(define (posn+ p q)
  (make-posn (+ (posn-x p) (posn-x q)) (+ (posn-y  p) (posn-y  q))))

(define WIDTH 200)
(define HEIGHT 500)

(start WIDTH HEIGHT)
(fly-until-down (create-ufo (random WIDTH)))