;; http://planet.plt-scheme.org/docs/schematics/schemeunit.plt/1/0/doc.txt
(module fun2 mzscheme 
  (require (lib "class.ss")
           (planet "test.ss" ("schematics" "schemeunit.plt" 1 0))
           (planet "text-ui.ss" ("schematics" "schemeunit.plt" 1 0)))
  
  (define queue<%>
    (interface () 
      mt?  ;; -> Boolean
      enq  ;; X -> Void 
      deq  ;; -> X
      ))

  (define-struct (exn:mtQ exn) ())
  
  ;; a queue of numbers 
  (define queue%
    (class* object% (queue<%>)
      (super-new)
      ;; reverse entries : Listof[Number]
      (define state '())
      (define/public (enq x) (set! state (cons x state)))
      (define/public (mt?) (null? state))
      (define/public (deq) (if (null? state) 
                               (raise
                                (make-exn:mtQ "the queue is empty" 
                                              (current-continuation-marks)))
                               (let* ([rstate (reverse state)]
                                      [head   (car rstate)]
                                      [tail   (cdr rstate)])
                                 (begin0 head 
                                         (set! state (reverse tail))))))))
                               
  
  (define Q (new queue%))
  (define (defq) (set! Q (new queue%)))

  
  ;; --- test cases ---
  (define tc-mt
    (make-test-case "enq fills the queue "
                    (assert-false (send Q mt?)) 
                    setup (send Q enq 10)
                    teardown (send Q deq)))
  
  (define tc-eed
    (make-test-case "two enq-s followed by one deq gets the first enq value"
                    (assert-equal? (send Q deq) 10)
                    setup (begin (send Q enq 10) (send Q enq 11))
                    teardown (defq)))
  
  (define tc-eedd
    (make-test-case "two enq-s followed by two deq retrieves the second enq value"
                    (assert-equal? (send Q deq) 10)
                    setup (begin (send Q enq 10) (send Q enq 11))
                    teardown (defq)))
  
  (define tc-eeddm
    (make-test-case "two enq-s followed by two deq empties the queue"
                    (assert-true (send Q mt?))
                    setup (begin (send Q enq 1) (send Q enq 2) 
                                 (send Q deq)  (send Q deq))
                    teardown (defq)))

  (define tc-exn 
    (make-test-case "a deq on an empty queue throws an exception"
                    (assert-exn exn:mtQ? (lambda () (send Q deq)))))

  (test/text-ui 
   (make-test-suite "stack" 
                    tc-exn
                    tc-eedd
                    tc-eed
                    tc-mt))
  
  )