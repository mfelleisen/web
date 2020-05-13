(module grade mzscheme 
  
  (require (lib "list.ss"))
  
  ;; Grade = ok+ | ok | ok- | 0
  
  ;; [Listof Grade] -> (list Grade Number)
  (define (average g)
    ;; factor in increasing performance 
    (define (sorted g)
      (if (null? (cdr g))
          #t
          (and (<= (car g) (cadr g)) (sorted (cdr g)))))
    (define b(map convert g))
    (define a (/ (* (if (sorted b) 1.1 1.0) (foldl + 0 b)) (length g)))
    (list a (back a)))
  
  
  (define (back h)
    (cond
      [(< h 1.7) 0]
      [(< h 2.3) 'ok-]
      [(< h 3.6) 'ok]
      [else 'ok+]))
  (define (convert g)
    (case g
      ['ok+  5]
      ['ok   3]
      ['ok-  2]
      [(0)   0]
      [else (error 'average "not a grade: ~a" g)]))
  
  (average (list 'ok+ 'ok+))
  (average (list 'ok- 'ok+))
  
  ;; --- Projects 
  
  (define REACHABLE 201)
  (define TOTAL     (* .9 REACHABLE))
  
  (define (project->ok numeric)
    (cond
      [(< numeric (* .50 TOTAL)) 0]
      [(< numeric (* .65 TOTAL)) 'ok-]
      [(< numeric (* .80 TOTAL)) 'ok]
      [else 'ok+]))
  #|
  (printf "ok+: ~s\n" (project->ok 180))
  (printf "ok:  ~s\n" (project->ok 140))
  (printf "ok-: ~s\n" (project->ok 100))
  (printf "0:   ~s\n" (project->ok 45))
  |#
  ;; --- TOTAL GRADES
  ;; Number [Listof Grade] -> Grade
  (define (total project people)
    (define j (convert (project->ok project)))
    (define e (car (average people)))
    (define r (+ (* .6 j) (* .4 e)))
    (back r))
  
  (printf "ok+ : ~s\n" (total 180 '(ok+ ok+ ok)))
  (printf "ok+ : ~s\n" (total 180 '(ok+ ok- ok)))
  (printf "ok+ : ~s\n" (total 180 '(ok ok- ok)))
  (printf "ok+ : ~s\n" (total 160 '(ok ok- ok)))
  (printf "ok  : ~s\n" (total 140 '(ok ok- ok)))
  (printf "ok- : ~s\n" (total 100 '(ok ok- ok)))
  (printf "ok- : ~s\n" (total 100 '(ok- ok- ok-)))
  (printf "0   : ~s\n" (total 100 '(ok- 0 0)))
  (printf "0   : ~s\n" (total  80 '(ok- ok- ok-)))
  
    


     )
    