(module order mzscheme 
  
  (require (planet "test.ss" ("schematics" "schemeunit.plt" 1 0))
           (planet "text-ui.ss" ("schematics" "schemeunit.plt" 1 0)))
  
  ;; Order = Listof[Cost]
  
  ;; compute the total of this order
  ;; Order -> Amount
  (define (getTotal order) (apply + order))
  
  (define testcase1
    (make-test-case "testing basic getTotal"
                    (assert = (getTotal '()) 0)
                    ))
  
  (define testcase2
    (make-test-case "testing one book getTotal"
                    (assert = (getTotal '(99.99))
                            99.99)))
  
  (test/text-ui 
   (make-test-suite "tests for getTotal"
                    testcase2
                    testcase1))
  
  
  )