#lang typed/racket

(provide final-grade %)

;; -----------------------------------------------------------------------------
(define-type Projects      (Pair Natural [Listof Assignment]))
(define-type Assignment    (Pair Exact-Rational Natural))
(define-type Presentations [Listof OK])
(define-type Panels        [Listof OK])
(define-type LabBooks      [Listof OK])
(define-type Percent       Real) ;; between 0.0 and 1.0
(define-type OK            (U 'ok+ 'ok 'ok- 'zero))
(define-type Ten           10)

;; -----------------------------------------------------------------------------
(define (% {x : Real}) (/ x 100))
(define PROJECT      (% 50))
(define PRESENTATION (% 20))
(define PANEL        (% 20))
(define LAB          (%  9))
(define FINAL        (% 20))
(define ASSIGNMENTS  (% 80))

[define ok+  (% 99)]
[define ok   (% 90)]
[define ok-  (% 77)]
[define zero (% 42)]

;; -----------------------------------------------------------------------------
(: final-grade (Projects Presentations Panels LabBooks -> Percent))
(define (final-grade projects presentations panels labs)
  (+ (* PROJECT      (project-grade projects))
     (* PRESENTATION (presentation-grade presentations))
     (* PANEL        (panel-grade panels))
     (* LAB          (lab-book-grade labs))
     (% 1))) ;; instructors' whim 

(: project-grade (Projects -> Percent))
(define (project-grade projects)
  (match-define (cons final-code-walk assignments) projects)
  (+ (* FINAL       (/ final-code-walk 10.))
     (* ASSIGNMENTS (assignment-grades assignments))))

(: assignment-grades (-> [Listof Assignment] Percent))
(define (assignment-grades grades)
  (define-values (student-score max-score)
    (for/fold : (values Real Real)
      ([student-score 0.0][max-score 0])
      ([g : Assignment grades])
      ;; -- IN -- 
      (match-define (cons student max) g)
      (values (+ student-score student) (+ max-score max))))
  (/ student-score max-score))

(: okay-grades (-> [Listof OK] Percent))
(define (okay-grades oks)
  (/ (for/sum : Percent ((o : OK oks)) (grade-mapping o))
     (length oks)))

(: presentation-grade (Presentations -> Percent))
(define presentation-grade okay-grades)

(: panel-grade (Panels -> Percent))
(define panel-grade okay-grades)

(: lab-book-grade (LabBooks -> Percent))
(define lab-book-grade okay-grades)

(: grade-mapping (OK -> Percent))
(define (grade-mapping o)
  (cond
    [(eq? o 'ok+) ok+]
    [(eq? o 'ok ) ok ]
    [(eq? o 'ok-) ok-]
    [(eq? o 'zero) zero]
    [else (error 'grade-mapping "unreachable code")]))

;; -----------------------------------------------------------------------------

(module+ test
  (require typed/rackunit)

  ;; The Perfect Student
  (: perfect-projects Projects)
  (: perfect-final-walk Ten)
  (define perfect-final-walk    10)
  (define perfect-projects      (cons perfect-final-walk (list (cons 100 100))))
  (define value-projects        1.0)
  (define perfect-presentations '(ok+ ok+))
  (define value-presentations   (/ (+ ok+ ok+) 2))
  (define perfect-panels        '(ok+ ok+ ok+))
  (define value-panels          (/ (+ ok+ ok+ ok+) 3))
  (: perfect-labs LabBooks)
  (define perfect-labs          '(ok+))
  (define value-labs            1.0)

  (define perfect-grade
    (+ (* 50/100 value-projects)
       (* 20/100 value-presentations)
       (* 20/100 value-panels)
       (* 09/100 value-labs)
       (% 1))) ;; <-- whim of the instructor 

  (check-=
   (final-grade perfect-projects perfect-presentations perfect-panels perfect-labs)
   perfect-grade
   .001))
