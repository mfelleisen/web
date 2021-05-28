;; Cellular Automata: Intermediate plus lambda 

;; -----------------------------------------------------------------------------
;; 0: DATA DEFINITIONS: 

;; Cell is one of: 
;; -- 'black 
;; -- 'white 
;; Interpretation: We use the color of the cell to record its state. 

;; VISUAL REPRESENTATIONS: 
(define SIZE  10) ; >= 3
(define WHITE (rectangle SIZE SIZE 'outline 'black))
(define BLACK (rectangle SIZE SIZE 'solid 'black))

;; Cell -> Image 
;; translate a cell into an image 
(define (cell-draw c)
  (cond [(symbol=? 'white c) WHITE]
        [(symbol=? 'black c) BLACK]))

;; State is one of: 
;; -- empty 
;; -- (cons Cell State)

;; Interpretation: The state of a CA is growing at both ends. It can start with a 
;; single black cell (or some other pattern) and adds a white cell on each end 
;; to the state per round. These cells are combined with the left and right end 
;; to create the next fringe elements. 

(define WIDTH 61)
;; These are the number of cells per state that the program visualizes. 

;; Grid is one of: 
;; -- empty
;; -- (cons State Grid)
;; Interpretation: This is the history of the CA's evolution. 

;; -----------------------------------------------------------------------------
;; 1: The Initial State and Transition Function for one Cell in the CA "Rule 30"
;; Citation: http://mathworld.wolfram.com/Rule30.html

;; initial state 
(define rule31/black (list (list 'black)))

;; Cell Cell Cell -> Cell 
;; produce a cell from itself and its left and right neighbors 
;; This "RULE 30" and if you want another one, you need to edit this function. 
;; Exercise: Use abstraction (HtDP part iv) to do better. 
(define (cell-next left this right)
  (local ((define l (list left this right)))
    (cond
      [(equal? l '(black black black)) 'white]
      [(equal? l '(black black white)) 'white]
      [(equal? l '(black white black)) 'white]
      [(equal? l '(black white white)) 'black]
      [(equal? l '(white black black)) 'black]
      [(equal? l '(white black white)) 'black]
      [(equal? l '(white black black)) 'black]      
      [(equal? l '(white white black)) 'black]      
      [(equal? l '(white white white)) 'white])))

;; -----------------------------------------------------------------------------
;; 2: The Main Function 
;; To *run* the program (not *test*), evaluate (main 'silly)

;; Symbol -> Void
;; create the canvas, start the clock; specify how to deal with ticks
(define (main dummy)
  (and (big-bang (* WIDTH SIZE) HEIGHT .1 rule31/black) 
       (on-tick-event
        (lambda (g) (update (grid-draw g) produce (grid-next g))))))

;; enlarge if you want to see more 
(define HEIGHT 250)

;; -----------------------------------------------------------------------------
;; 3: Dealing with States in the CA

;; State -> Image
;; turn a state into an image
(define (state-draw s)
  (image-append (map cell-draw (state-pad s WIDTH))))

;; State -> State 
;; produce the next state from a state 
(define (state-next s)
  (local ((define n (length s))
          (define s++ 
            (cond
              [(= n WIDTH) s]
              [(< n WIDTH) (state-pad s (+ (length s) 2))]
              [else (error 'state-next "internal error")])))
     (map cell-next (lefties s++) s++ (righties s++))))

;; State -> State 
;; rotate to the left, place a white at the beginning
(define (lefties s) (cons 'white (all-but-last s)))

;; State -> State 
;; rotate to the left, place a white at the end 
(define (righties s) (append (rest s) (list 'white)))

;; State -> State 
;; remove the last item from the state [so it isn't really a state]
(define (all-but-last s)
  (cond
    [(empty? (rest s)) empty]
    [else (cons (first s) (all-but-last (rest s)))]))

;; State Nat -> State 
;; surround s with white cells until s is exactly n cells wide
;; exception if too wide already 
(define (state-pad s n)
  (local ((define n-1 (- n 1))
          (define (pad s)
            (local ((define l (length s)))
              (cond
                [(< l n-1) (pad (append (list 'white) s (list 'white)))]
                [(= l n) s]
                [(= l n-1) (cons 'white s)]))))
    (cond 
      [(> (length s) n) (error 'state-pad (format "given list too wide: ~a ~a" n (length s)))]
      [else (pad s)])))

;; -----------------------------------------------------------------------------
;; 4: Dealing with the History of States for a CA 

;; Grid -> Grid 
;; produce the next CA from the first item in grid
(define (grid-next g) (cons (state-next (first g)) g))

;; Grid -> Image 
;; produce an image of an n x n grid from Grid
(define (grid-draw g) (image-stack (map state-draw g)))

;; -----------------------------------------------------------------------------
;; 5: Auxiliary Functions 

;; (NE.Listof Image) -> Image 
;; juxtapose the images on loi, assuming they all have the same height

(define (image-append loi)
  (foldr
   (lambda (f r) (overlay/xy f (image-width f) 0 r)) (first loi) (rest loi)))


;; (NE.Listof Image) -> Image 
;; stack up the pictures on loi, assuming they all have the same width 
(define (image-stack loi)
  (local ((define l (reverse loi)))
    (foldl 
     (lambda (f r) (overlay/xy f 0 (- (image-height f)) r)) (first l) (rest l))))

;; -----------------------------------------------------------------------------
;; TESTS

(equal? (lefties (list 'white 'white 'black 'black 'white 'white))
        (list 'white 'white 'white 'black 'black 'white))

(equal? (righties (list 'white 'white 'black 'black 'white 'white))
        (list 'white 'black 'black 'white 'white 'white))

(equal? (state-next (cons 'black (build-list (- WIDTH 1) (lambda (n) 'white))))
        (cons 'black (cons 'black (build-list (- WIDTH 2) (lambda (n) 'white)))))

(equal? (state-pad (list 'black) 3) (list 'white 'black 'white))

(equal? (state-pad (list 'white 'black) 3) (list 'white 'white 'black))

(= (length (state-pad (list 'black) WIDTH)) WIDTH)

(equal? (state-next (list 'white)) (list 'white 'white 'white))


(equal? (state-next (list 'white 'black 'white))
        (list 'white 'black 'black 'black 'white))

(equal? (state-next (list 'black 'black 'black))
        (list 'black 'black 'white 'white 'black))

(equal?
 (state-next
  (list 'white 'white 'white 'white 'black 'white 'white 'white))
  (list 'white 'white 'white 'white 'black 'black 'black 'white 'white 'white))

(equal?
 (grid-next (list (list 'white 'white 'white 'white 'black 'white 'white 'white)))
 (list (list 'white 'white 'white 'white 'black 'black 'black 'white 'white 'white)
       (list 'white 'white 'white 'white 'black 'white 'white 'white)))

(equal? 
 (grid-next 
  (list (list 'white 'white 'black 'black 'black 'white)
        (list 'white 'white 'white 'black 'white 'white)))
 (list
        (list 'white 'white 'black 'black 'white 'white 'black 'white)
        (list 'white 'white 'black 'black 'black 'white)
        (list 'white 'white 'white 'black 'white 'white)))

(equal? (image-append (list (rectangle 10 10 'outline 'black)
                            (rectangle 10 10 'outline 'black)
                            (rectangle 10 10 'outline 'black)))
        (place-image 
         (line 0 9 'black)
         10 0
         (place-image 
          (line 0 9 'black)
          20 0
          (empty-scene 30 10))))

(equal? (image-stack (list (rectangle 10 10 'outline 'black)
                           (rectangle 10 10 'outline 'black)
                           (rectangle 10 10 'outline 'black)))
        (place-image 
         (line 9 0 'black)
         0 10
         (place-image 
          (line 9 0 'black)
          0 20
          (empty-scene 10 30))))

(equal? (grid-draw (list (list 'black 'white 'black 'black)))
        (image-append
         (map cell-draw (state-pad '(black white black black) WIDTH))))
                      
