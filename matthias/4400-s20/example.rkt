#lang racket

(require "rename.rkt")

;; - - - - - - - - - - - - - - - - - - - - - 
;; grab is a form of catch and throw
;; it "names" a return point in code
;; throw is just a function call to
;;   a named return point

(grab exit-point
      (* 10 (exit-point 42) 20))

;; - - - - - - - - - - - - - - - - - - - - - 

(+ 1
   (grab done
         (* 2 (done 42))))

;; the call to done eliminates (* 2 ..)
;; and sends 42 to the exit point of done

;; - - - - - - - - - - - - - - - - - - - - - 

(/ 
 (grab exit1
       (* 2
          (grab done
                (+ 1 (exit1 42)))))
 2)

(/ 
 (grab exit1
       (* 2
          (grab done
                (+ (done 1) (exit1 42)))))
 2)

;; it is useful to have named exit points

;; - - - - - - - - - - - - - - - - - - - - -

(let ([cell (@ (fun* (x) x))])
  (seq*
   (= cell (grab done (if-0 (! cell) 0 done)))
   (if-0 (! cell) 42 [(! cell) 0])))

;; grab generalizes catch even more in that
;; the function it binds to the variable can
;; not only be called, it can even be stored
;; in a cell .. just like ordinary functions