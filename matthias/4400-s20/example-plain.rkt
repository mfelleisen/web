#lang racket

;; - - - - - - - - - - - - - - - - - - - - - 
(let/cc exit-point
  (* 10 (exit-point 42) 20))

;; - - - - - - - - - - - - - - - - - - - - - 
(+ 1
   (let/cc done
     (* 2 (done 42))))

;; - - - - - - - - - - - - - - - - - - - - - 
(/ 
 (let/cc exit1
   (* 2
      (let/cc done
        (+ 1 (exit1 42)))))
 2)

;; - - - - - - - - - - - - - - - - - - - - - 
(/ 
 (let/cc exit1
   (* 2
      (let/cc done
        (+ (done 1) (exit1 42)))))
 2)

;; - - - - - - - - - - - - - - - - - - - - -

(define @ box)
(define ! unbox)
(define = set-box!)
(define-syntax-rule
  (if-0 x y z)
  (let ([tst x]) (if (and (number? tst) (zero? tst)) y z)))

(let ([cell (@ (λ (x) x))])
  (begin
    (= cell (let/cc done (if-0 (! cell) 0 done)))
    (if-0 (! cell) 42 [(! cell) 0])))
