#lang racket

(provide grades average)

;; ---------------------------------------------------------------------------------------------------
(define grades
  '(
    ;                                              WARMUP HW1   HW2   HW3  PROJ   HW4   Pro1  HW5   HW6    HW7  code pres memo refl
    ("Tran" "Anh" "panhtran249@gmail.com"           7/10  8/10  8/10  7/10 10/15  6/10  8/10  6/10  7/10  6/10  .90  .95 13/16 1.0)
    ("Boehman" "Isaac" "boehman.i@husky.neu.edu"    6/10  8/10  8/10  7/10 10/15  6/10  8/10  6/10  7/10  6/10  .90  .95 13/16 1.0)
    ("Bower" "Jonathan" "bower.j@husky.neu.edu"     9/10  7/10  9/10  7/10 11/15 10/10  9/10  9/10 10/10  9/10  .95  .90 11/16 1.0)
    ("Cheung" "Howard" "cheung.ho@husky.neu.edu"    6/10  6/10  6/10  6/10 13/15  8/10  5/10 10/10  9/10 10/10  .80  .80 10/16 1.0)
    ("Coates" "Joshua" "coates.jo@husky.neu.edu"   10/10  8/10  9/10  8/10 14/15  7/10  7/10 10/10  7/10  9/10  .90 1.00 14/16 1.0)
    ("Corbett" "David" "corbett.dav@husky.neu.edu" 10/10  9/10  8/10 10/10 12/15  8/10 10/10 10/10 10/10  9/10  .80  .90 13/16 1.0)
    ("Furtado" "Paul" "furtado.p@husky.neu.edu"     8/10  8/10  8/10  8/10 11/15  9/10 10/10  7/10  8/10 10/10  .95  .75 14/16 1.0)
    ("Jensen" "Robert"  "jensen.r@husky.neu.edu"    7/10  6/10  6/10  6/10 13/15  8/10  5/10 10/10  9/10 10/10  .80  .80 10/16 1.0)
    ("Kelly" "Eric" "kelly.eric@husky.neu.edu"      5/10  9/10 10/10 10/10 13/15  9/10 10/10  9/10  8/10 10/10  .85 1.00 12/16 1.0)
    ("Kolek" "Chris" "kolek.c@husky.neu.edu"        9/10  7/10  9/10  7/10 11/15 10/10  9/10  9/10 10/10  9/10  .95  .90 11/16 1.0)
    ("Lin" "Mimi" "lin.f@husky.neu.edu" 10/10       9/10  8/10 10/10 12/15  8/10 10/10 10/10 10/10  9/10  9/10  .80  .90 13/16 1.0)
    ("Nimick" "Francis" "nimick.f@husky.neu.edu"    5/10  9/10 10/10 10/10 13/15  9/10 10/10  9/10  8/10 10/10  .85 1.00 12/16 1.0)
    ("Silva" "David" "silva.davi@husky.neu.edu"    10/10  8/10  9/10  8/10 14/15  7/10  7/10 10/10  7/10  9/10  .90 1.00 14/16 1.0)
    ("Ukani" "Ali" "ukani.a@husky.neu.edu"          7/10  9/10  8/10  8/10 11/15  9/10 10/10  7/10  8/10 10/10  .95  .75 14/16 1.0)
    ))

(define clean (lambda (x) (if x x 0)))

(define (gpas f)
  (for/list ((one grades))
    (f (first one) (second one) (average one))))

(define (average one)
      (define scores (map clean (cdddr one)))
      (/ (apply + scores) (length scores)))

(define (f last-name first-name average)
  (~a (~a first-name #:min-width 20)
      (if (>= average .85) " * " "   ")
      (~r average
          #:min-width 3
          #:pad-string "0"
          #:precision 2)))

(pretty-print (gpas f))
