(module queue mzscheme
  
  (require (lib "contract.ss")
           (lib "class.ss"))
  
  (define queue%
    (class object%
      (field [items '()])
      (super-new)

      (define/public (toString) items)

      (define/public (empty?) (null? items))
  
      (define/public (enq x)
        (set! items (append items (list x)))
        this)
  
      (define/public (deq)
        (begin0
          (car items)
          (set! items (cdr items))))
  
      (define/public (size) (length items))))
  
  (define queue (new queue%))

  (provide/contract 
   [queue (object-contract 
           [empty?    (-> boolean?)]
           [enq       (any/c . ->d .
                             (lambda (x)
                               (let ([OLD.size (send queue size)])
                                 (lambda (RESULT)
                                   (and (not (send RESULT empty?)) 
                                        (= (send RESULT size) (+ OLD.size 1)))))))]
           [deq       (->d (lambda ()
                             (let ([OLD.size (send queue size)])
                               (lambda (RESULT)
                                 (printf ">>> ~s~n" (get-field items queue))
                                 (and (not (send queue empty?))
                                      (= (send queue size) (- OLD.size 1)))))))]
           [size      (-> (union zero? positive?))])]))
    