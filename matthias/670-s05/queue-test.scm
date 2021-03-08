(module queue-test mzscheme 
  
  (require "queue.scm"
           (lib "class.ss")
           (planet "test.ss" ("schematics" "schemeunit.plt" 1 0))
           (planet "text-ui.ss" ("schematics" "schemeunit.plt" 1 0)))
  
  (define test
    (make-test-suite 
     "queue"
     (make-test-case 
      "empty/size"
      (assert = (send queue size) 0))
     (make-test-case 
      "enq/size/deq"
      'setup
      (send (send (send queue enq 'a) enq 'b) enq 'c)
      (assert = (send queue size) 3)
      'teardown 
      (begin 
        (send queue deq)
        (send queue deq)
        (send queue deq)))
     (make-test-case 
      "empty/empty"
      (assert-true (send queue empty?)))
     (make-test-case 
      "enq/deq"
      'setup
      (send (send (send queue enq 'a) enq 'b) enq 'c)
      (assert eq? (send queue deq) 'a)
      'teardown 
      (begin 
        (send queue deq)
        (send queue deq)))))
      
  
  (test/text-ui test)
  
  )
