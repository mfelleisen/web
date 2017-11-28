#lang scheme

(require slideshow mred/mred)

(define b (blank 3 12))

(define (write-and-return file-name the-image)
  (define image-bm
    (make-object bitmap% 
      (inexact->exact (round (pict-width the-image)))
      (inexact->exact (round (pict-height the-image)))))
  (define _ (unless (send image-bm ok?) (error 'write-and-return "bad image")))
  (define image-dc
    (new bitmap-dc% [bitmap image-bm]))
  (send image-dc clear)
  (draw-pict the-image image-dc 0.0 0.0)
  (send image-bm save-file (string-append file-name ".png") 'png)
  the-image)

(write-and-return "quote" 
                  (ht-append (linewidth 2 (pin-line b b rt-find b lb-find))
                             (vc-append (blank 0 2) (text "quotes" '() 20))))
