#lang htdp/isl+

(require 2htdp/image)
(require 2htdp/universe)

(define (lift-off t)
  (place-image rocket middle t background-scene))

(define rocket (rectangle 3 20 'solid 'red))
(define background-scene (empty-scene 100 300))
(define height (image-height background-scene))
(define middle (/ (image-width background-scene) 2))



;; -----------------------------------------------------------------------------
(define (server debug?)
  (universe '()
    (state debug?)
    (on-new add-world)
    (on-msg send-to-all-worlds)))

(define (add-world q iw)
  (make-bundle (cons iw q) '() '()))

(define (send-to-all-worlds q iw m)
  (make-bundle q (map (lambda (iw) (make-mail iw 'reset)) q) '()))

;; -----------------------------------------------------------------------------

;; run program run
(define (one-world height)
  (big-bang height
    (on-tick sub1)
    (on-key (lambda (w key) (make-package w 'reset)))
    (register LOCALHOST)
    (on-receive (lambda (s m) height))
    (to-draw lift-off)
    (stop-when zero?)))

(launch-many-worlds (one-world 100)  (one-world 200) (server 'a))