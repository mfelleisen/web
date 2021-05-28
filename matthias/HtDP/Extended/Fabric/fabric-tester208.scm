
;; create-item : image image -> image
;; creates first image in pattern of second
(define (create-item item fabric)
  (overlay fabric item))

;; create-shirt : image -> image
;; returns tshirt colored in pattern of given image
(define (create-shirt fabric)
  (create-item tshirt fabric))

;; add-center-logo : image image -> image
;; centers first image on top of the second image
(define (add-center-logo logo item) 
  (overlay item logo))

;; stack-logos : image image -> image
;; stacks first image atop second, returning new image
(define (stack-logos l1 l2)
  (move-pinhole-center
   (overlay/xy l1 0 (image-height l1) l2)))

(define fabric1 (create-solid-fabric 'pink tshirt))
(define fabric2 (add-print chili (create-solid-fabric 'purple tshirt)))
(define fabric3 (add-print flower (create-vertical-stripe-fabric 'purple 5 tshirt)))
(define fabric4
  (add-vertical-stripe 'pink 15 (add-horiz-stripe 'teal 15 (create-solid-fabric 'purple tshirt))))
(define fabric5 (add-horiz-stripe 'yellow 20 (create-solid-fabric 'violet tshirt)))

(define shirt1 (create-shirt fabric2))
(define shirt2 (add-center-logo worm (create-shirt fabric1)))
(define shirt3 (create-shirt fabric3))
(define shirt4 (create-shirt fabric4))
(define shirt5 (add-center-logo (stack-logos chili worm) (create-shirt fabric5)))
