<HEAD>
<TITLE>Rember Up To Last</TITLE>
</HEAD>
<BODY>

<pre>
(define (rember-upto-last a lat) ; Look Ma, no cons   
  (letcc skip
    (letrec 
      ((R
	 (lambda (l)
	   (cond
	     ((null? l) (void))
	     (else (let ()
		     (R (cdr l))
		     (cond
		       ((eq? a (car l))
			(skip (cdr l)))
		       (else (void)))))))))
      (R lat)
      lat)))
</pre>

(define (rember-upto-last a lat) ; Look Ma, no cons   
  (call/cc
   (lambda (skip)
     (letrec 
	 ((R
	   (lambda (l)
	     (if (null? l) 
		 (list)
		 (begin
		   (R (cdr l))
		   (if (eq? a (car l))
		       (skip (cdr l))
		       (list)))))))
       (begin (R lat) lat)))))

(define (rember-upto-last a lat) ; Look Ma, no cons   
  (letcc skip
    (letrec 
      ((R
	 (lambda (l)
	   (cond
	     ((null? l) (void))
	     (else (let ()
		     (R (cdr l))
		     (cond
		       ((eq? a (car l))
			(skip (cdr l)))
		       (else (void)))))))))
      (R lat)
      lat)))

(define (rul a lat) (reverse (rember-beyond-first a (reverse lat)))


</html>
