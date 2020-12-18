#lang typed/racket

(: final-grade (Final Projects Presentations Panels LabBooks -> Percent))
(provide final-grade %)

;; -----------------------------------------------------------------------------
(module+ test
  (require typed/rackunit))

;; -----------------------------------------------------------------------------
(define-type Final         (U 0 1 2 3 4 5 6 7 8 9 10))

(define-type Projects      [Listof Assignment])
(define-type Assignment    (Pair ActualScore BaseScore))
(define-type ActualScore   Exact-Rational)
(define-type BaseScore     Natural)

(define-type Presentations [Listof OK])
(define-type Panels        [Listof OK])
(define-type LabBooks      [Listof OK])
(define-type OK            (U 0 'ok+ 'ok 'ok- 'zero))

(define-type Percent       Real) ;; between 0.0 and 1.0
(define-type Ten           10)

;; -----------------------------------------------------------------------------
(define (% {x : Real}) (/ x 100))
(define HOMEWORK     (% 40))
(define PRESENTATION (% 20))
(define PANEL        (% 20))
(define LAB          (%  5))
(define FINAL        (% 14))
(module+ test 
  (define TOTAL        (+ HOMEWORK PRESENTATION PANEL LAB FINAL))
  (check-= TOTAL .99 .001 "assert:: percentage total"))

(define ASSIGNMENTS  (% 80))

[define ok+  (% 99)]
[define ok   (% 94)]
[define ok-  (% 88)]
[define zero (% 61)]

;; -----------------------------------------------------------------------------
(define (final-grade the-code-walk projects presentations panels labs)
  (+ (* HOMEWORK     (homework-grades projects))
     (* PRESENTATION (okay-grades presentations))
     (* PANEL        (okay-grades panels))
     (* LAB          (okay-grades labs))
     (* FINAL        (/ the-code-walk 10)))) ;; <<--- magic 
     
(: okay-grades (-> [Listof OK] Percent))
(define (okay-grades oks)
  (/ (for/sum : Percent ((o : OK oks)) (grade-mapping o))
     (length oks)))

(: grade-mapping (OK -> Percent))
(define (grade-mapping o)
  (cond
    [(eq? o 'ok+) ok+]
    [(eq? o 'ok ) ok ]
    [(eq? o 'ok-) ok-]
    [(eq? o 'zero) zero]
    [else (% 0)]))

(: homework-grades (-> [Listof Assignment] Percent))
(define (homework-grades grades)
  (define total-score ((inst sum-map Assignment) car grades))
  (define total-max   ((inst sum-map Assignment) cdr grades))
  (define all-possible-scores
    (for/list : [Listof Real] ([g : Assignment grades])
      (/ (- total-score (car g)) (- total-max (cdr g)))))
  (4digits (apply max all-possible-scores)))

(: sum-map (All (X) (-> (-> X Real) [Listof X] Real)))
(define (sum-map f l) (apply + (map f l)))

(: 4digits (-> Real Real))
(define (4digits x) (cast (string->number (~r #:precision 4 x)) Real))

;; -----------------------------------------------------------------------------

(module+ test
  ;; The Perfect Student
  (: perfect-projects Projects)
  (: perfect-final-walk Ten)
  (define perfect-final-walk    10)
  (define perfect-projects      (list (cons 100 100) (cons 120 120)))
  (define value-projects        1.0)
  (define perfect-presentations '(ok+ ok+))
  (define value-presentations   (/ (+ ok+ ok+) 2))
  (define perfect-panels        '(ok+ ok+ ok+))
  (define value-panels          (/ (+ ok+ ok+ ok+) 3))
  (: perfect-labs LabBooks)
  (define perfect-labs          '(ok+))
  (define value-labs            1.0)

  (define perfect-grade
    (+ (* HOMEWORK value-projects)
       (* PRESENTATION value-presentations)
       (* PANEL value-panels)
       (* LAB value-labs)
       (* FINAL(/  perfect-final-walk 10))))
  
  (check-=
   (final-grade perfect-final-walk perfect-projects perfect-presentations perfect-panels perfect-labs)
   perfect-grade
   .005))
