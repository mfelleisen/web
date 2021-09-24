#lang htdp/isl+

;; --------------------------------------------

#; {N -> N}

(check-expect (! 2) 2)

(define (! x) (if (= 0 x) 1 (* x (! (- x 1)))))


































;; --------------------------------------------

#; {N -> N}

(check-random (! (random 100)) (!-ds-cps (random 100)))

(define (!-ds-cps x)
  (local ((define (! x k)
            (if (= 0 x)
                (send k 1)
                (! (- x 1) (cons x k))))
          (define (send k n)
            (cond
              [(empty? k) n]
              [else (send (rest k) (* (first k) n))]))
          (define stop '[]))
    (! x stop)))