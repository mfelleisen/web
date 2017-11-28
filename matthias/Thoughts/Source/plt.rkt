#lang slideshow

(require slideshow/pict mred/mred)

(define (image-width p) (inexact->exact (round (pict-width p))))
(define (image-height p) (inexact->exact (round (pict-height p))))

(define (text-frame s)
  (define t (text s '() FT))
  (define w (image-width t))
  (define h (image-height t))
  (cc-superimpose t (rectangle (+ w 10) (+ h 10))))

(define (rounded-text-frame s)
  (define t (text s '() FT))
  (define w (image-width t))
  (define h (image-height t))
  (cc-superimpose t (rounded-rectangle (+ w 10) (+ h 10))))

(define hspace (blank 15 1))
(define (vspace h) (blank 1 h))

(define DELTA 80)
(define FT 12)

(define racket (text-frame "#lang racket"))
(define lazy   (text-frame "#lang lazy"))
(define typed  (text-frame "#lang typed"))
(define datalg (text-frame "#lang datalog"))
(define dots   (text "..." '() FT))

(define langs  
  (hb-append racket hspace lazy hspace typed hspace dots hspace datalg))

(define base   (text-frame "Fully Expanded Program"))

(define expand0 
  (vc-append langs
             (vspace 60)
             (rounded-text-frame "   macro expand  ") 
             (vspace 60)
             base))

(define (expand-> src expand)
  (pin-arrow-line 5
                  expand 
                  src
                  cb-find
                  base
                  ct-find))

(define expand
  (foldr expand-> expand0 (list racket lazy typed datalg)))

(define compile 
  (vc-append expand (vspace 60) (rounded-text-frame "compile") (vspace 60)))

(define x 0)
(define y 0)
(define all
  (pin-arrow-line 5
                  compile 
                  base
                  (lambda (i j)
                    (set!-values (x y) (cb-find i j))
                    (values x y))
                  (blank 1 1)
                  (lambda _ 
                    (values x (+ y 140)))))

(define h 255 #;
  (inexact->exact (round (image-height all))))

(define brace
  (text "}" (make-object font% h 'modern 'normal 'light) h))

(define braced
  (hc-append all brace (text-frame "Redex: modeling")))

;; -----------------------------------------------------------------------------

(define the-image braced)

(define image-bm
  (make-object bitmap% 
    (inexact->exact (round (image-width the-image)))
    (inexact->exact (round (image-height the-image)))))

(send image-bm ok?)

(define image-dc
  (new bitmap-dc% [bitmap image-bm]))
(send image-dc clear)

(draw-pict the-image image-dc 0.0 0.0)

(send image-bm save-file "plt.png" 'png)

the-image
