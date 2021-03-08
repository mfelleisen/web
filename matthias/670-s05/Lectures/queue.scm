;; http://planet.plt-scheme.org/docs/schematics/schemeunit.plt/1/0/doc.txt
(module queue mzscheme
  (require (lib "class.ss")
           (planet "test.ss" ("schematics" "schemeunit.plt" 1 0))
           (planet "text-ui.ss" ("schematics" "schemeunit.plt" 1 0)))
  
  ;; a queue of Xs 
  (define queue<%>
    (interface ()
      enq ;; X -> Void
      ;; adds one X element to this queue
      deq ;; -> X
      ;; removes and returns one X element from this queue
      sze ;; -> Int
      ;; returns the number of Xs currently in this queue
      ))
  

  
  (define queue% ;;; where X = Number 
    (class* object% (queue<%>)
      (super-new)
      ;; Listof[Number] 
      ;; represents all the currently enq'ed elements
      (define state '())
      (define/public (enq x) (set! state (cons x state)))
      (define/public (deq) 
        (when (null? state)
          (raise (make-exn:queue-mt "the queue is empty" 'stuff)))
        (let* ([rev (reverse state)]
               [head (car rev)]
               [tail (cdr rev)])
          (begin0 head
                  (set! state (reverse! tail)))))
               
      (define/public (sze) (length state))))
  
  (define the-queue (new queue%))
  
  (define tc0-a
    (make-test-case "size of a empty queue"
                    (assert = 0 (send the-queue sze))))

  (define tc0
    (make-test-case "size of a one-enq queue"
                    (assert = 1 (send the-queue sze))
                    setup (send the-queue enq 11)
                    teardown (set! the-queue (new queue%))
                    ))
  
  (define tc1 
    (make-test-case "size of an mt queue"
                    (assert = 0 (send the-queue sze))))
  
  (define tc2
    (make-test-case "deq an mt queue"
                    (assert-exn exn:queue-mt? 
                                (lambda () (send the-queue deq)))))
  
  (test/text-ui
   (make-test-suite "test for queue"
                    tc0-a
                    tc0
                    tc1
                    tc2))

  )
