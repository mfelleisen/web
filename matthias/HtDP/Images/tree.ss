(define L 170)
(define DELTA-ANGLE (/ pi 9))
(define SCALE .5)
(define SCALE-LEFT  1/3)
(define SCALE-RIGHT 2/3)
(define SMALL 80) ;; for simple tree
(define SMALL 1)  ;; for complex tree


(define WIDTH 250)
(define HIGHT 250)
(define BASE (make-posn (/ WIDTH 2) HIGHT))

;; twig : posn number number -> #t
(define (twig base l angle)
  (cond
    ((< l SMALL) #t)
    (else
       (let ((l-left (* l SCALE-LEFT))
	     (l-right (* l SCALE-RIGHT)))
	 (and (draw-solid-line base (line base l angle) RED)
	      (twig (line base l-left angle)  (* l SCALE) (+ angle DELTA-ANGLE))
	      (twig (line base l-right angle) (* l SCALE) (- angle DELTA-ANGLE))
	      )))))
  
(define (line p l angle)
  (let ((delta-x (* l (sin angle)))
	(delta-y (* l (cos angle))))
    (posn+ p (make-posn delta-x delta-y))))

(define (posn+ a b)
  (make-posn 
   (+ (posn-x a) (posn-x b))
   (+ (posn-y a) (posn-y b))))

(start WIDTH HIGHT)

(twig BASE L pi)
(line BASE L pi)
