;; Cellular Automata: Beginners with hints for state-next 

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
;; Constraint: The list is always WIDTH items wide. 
(define WIDTH 61) ; odd? 

;; Interpretation: The state of a CA is infinite, but we can deal only with a 
;; finite portion of it. Here we choose a fixed-width "window" on that part of 
;; the  state that is populated with "active" cells. It would therefore be 
;; acceptable to represent this "window" with a vector (array). However, 
;; the full truth is that we should use a list that contains only those 
;; cells that are active. It should be a list because the active portion of 
;; a CA expands to the left and right. -- The choice here is a compromise 
;; that fits best with what HtDP offers to beginners. 

;; Grid is one of: 
;; -- empty
;; -- (cons State Grid)
;; Interpretation: This is the history of the CA's evolution. 

;; -----------------------------------------------------------------------------
;; 1: The Initial State and Transition Function for one Cell in the CA "Rule 30"
;; Citation: http://mathworld.wolfram.com/Rule30.html

;; Nat -> State 
(define (build n)
  (cond
    [(zero? n) empty]
    [else (cons 'white (build (sub1 n)))]))

;; initial state 
(define rule31/black ;; 15 white, 1 black, 15 white 
  (list 
   (append (build (quotient WIDTH 2)) (list 'black) (build (quotient WIDTH 2)))))

;; Cell Cell Cell -> Cell 
;; produce a cell from itself and its left and right neighbors 
;; This "RULE 30" and if you want another one, you need to edit this function. 
;; Exercise: Use abstraction (HtDP part iv) to do better. 
(define (cell-next left this right)
  (cond
    [(equal? (list left this right) '(black black black)) 'white]
    [(equal? (list left this right) '(black black white)) 'white]
    [(equal? (list left this right) '(black white black)) 'white]
    [(equal? (list left this right) '(black white white)) 'black]
    [(equal? (list left this right) '(white black black)) 'black]
    [(equal? (list left this right) '(white black white)) 'black]
    [(equal? (list left this right) '(white black black)) 'black]      
    [(equal? (list left this right) '(white white black)) 'black]      
    [(equal? (list left this right) '(white white white)) 'white]))

;; -----------------------------------------------------------------------------
;; 2: The Main Function 
;; To *run* the program (not *test*), evaluate (main 'silly)

;; Symbol -> Void
;; create the canvas, start the clock; specify how to deal with ticks
(define (main dummy)
  (and (big-bang (* WIDTH SIZE) HEIGHT .1 rule31/black) 
       (on-tick-event tock)))

;; enlarge if you want to see more 
(define HEIGHT 250)

;; Grid -> Grid
;; on every clock tick, draw the history of CA transitions, extend it by one
(define (tock g)
  (update (grid-draw g) produce (grid-next g)))

;; -----------------------------------------------------------------------------
;; 3: Dealing with States in the CA

;; State -> State 
;; produce the next state from a state 
(define (state-next s) 
  (state-next-aux (lefties s) s (righties s)))

;; State State State -> State 
(define (state-next-aux lefts these rights)
  (cond
    [(empty? lefts) empty]
    [else (cons (cell-next (first lefts) (first these) (first rights))
                (state-next-aux (rest lefts) (rest these) (rest rights)))]))

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

;; State -> Image
;; turn a state into an image
(define (state-draw s) (image-append (state-draw-all-cells s)))

;; State -> List-of-images
;; transform all cells in a state into images 
(define (state-draw-all-cells s)
  (cond
    [(empty? s) empty]
    [else (cons (cell-draw (first s)) (state-draw-all-cells (rest s)))]))

;; -----------------------------------------------------------------------------
;; 4: Dealing with the History of States for a CA 

;; Grid -> Grid 
;; produce the next CA from the first item in grid
(define (grid-next g)
  (cons (state-next (first g)) g))

;; Grid -> Image 
;; produce an image of an n x n grid from Grid
(define (grid-draw g) (image-stack (grid-draw-all-states g)))

;; Grid -> List-of-images
;; transform all states in a grid into images 
(define (grid-draw-all-states g)
  (cond
    [(empty? g) empty]
    [else (cons (state-draw (first g)) (grid-draw-all-states (rest g)))]))

;; -----------------------------------------------------------------------------
;; 5: Auxiliary Functions 

;; (NE.Listof Image) -> Image 
;; juxtapose the images on loi, assuming they all have the same height
(define (image-append loi)
  (cond
    [(empty? (rest loi)) (first loi)]
    [else (overlay/xy (first loi) (image-width (first loi)) 0
                      (image-append (rest loi)))]))


;; (NE.Listof Image) -> Image 
;; stack up the pictures on loi, assuming they all have the same width 
(define (image-stack loi)
  (cond
    [(empty? (rest loi)) (first loi)]
    [else (overlay/xy (first loi) 0 (- (image-height (first loi)))
                      (image-stack (rest loi)))]))

;; -----------------------------------------------------------------------------
;; TESTS

(equal? (lefties (list 'white 'white 'black 'black 'white 'white))
        (list 'white 'white 'white 'black 'black 'white))

(equal? (righties (list 'white 'white 'black 'black 'white 'white))
        (list 'white 'black 'black 'white 'white 'white))


(equal? (state-next (list 'white))
        (list 'white))

(equal? (state-next (list 'white 'black 'white))
                    (list 'black 'black 'black))

(equal? (state-next (list 'black 'black 'black))
                    (list 'black 'white 'white))

(equal?
 (state-next
  (list 'white 'white 'white 'white 'black 'white 'white 'white))
  (list 'white 'white 'white 'black 'black 'black 'white 'white))

(equal?
 (grid-next (list (list 'white 'white 'white 'white 'black 'white 'white 'white)))
 (list (list 'white 'white 'white 'black 'black 'black 'white 'white)
       (list 'white 'white 'white 'white 'black 'white 'white 'white)))

(equal? 
 (grid-next 
  (list (list 'white 'white 'black 'black 'black 'white)
        (list 'white 'white 'white 'black 'white 'white)))
 (list
        (list 'white 'black 'black 'white 'white 'black)
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
        (image-append (list BLACK WHITE BLACK BLACK)))
                      
