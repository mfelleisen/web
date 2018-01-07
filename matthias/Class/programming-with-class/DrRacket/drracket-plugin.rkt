#lang racket/gui

(provide 
 ;; object with two public methods: 
 ;; register and get-drr-frame%
 mixin-registry)

(define mixin-registry
  (new
   (class object% 
     (super-new)
     
     ;; Window -> Window 
     (define (mixin x) x)
     
     ;; [Maybe Window]
     (define drr-frame% #f)
     
     ;; (Window -> Window) -> Void 
     ;; register another mixin m with drracekt 
     (define/public (register m)
       (cond
         [drr-frame% (error 'register-mixin "too late")]
         [else (set! mixin (compose mixin m))]))
     
     ;; -> Window
     ;; create the top-level frame from current state of mixin 
     ;; effect: set drr-frame% to its final state, a top-level frame 
     (define/public (get-drr-frame%)
       (unless drr-frame%
         (set! drr-frame% (mixin frame%)))
       drr-frame%))))
