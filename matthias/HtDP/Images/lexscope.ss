;; \scheme{N -> ColorList}
;; create a red diagonal in a green square
(define (diagonal n)
  (local ((define (diagonal i)
            (cond
              [(zero? i) empty]
              [else (local ((define (row k)
                              (cond
                                [(zero? k) empty]
                                [else (cond
                                        [(= i k) (cons RED (row (sub1 k)))]
                                        [else (cons GREEN (row (sub1 k)))])]))) 
                      (append (row n) (diagonal (sub1 i))))])))
    (diagonal n)))

(define RED   (make-color 200 20 20))
(define GREEN (make-color 20 200 20))

(equal? 
 (diagonal 3)
 (list RED GREEN GREEN
       GREEN RED GREEN
       GREEN GREEN RED))