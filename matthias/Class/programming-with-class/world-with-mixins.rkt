#lang racket/gui 

;; how to implement big-bang for just mouse and key events
;; with first-class classes and mixins 

;; -----------------------------------------------------------------------------
;; the sample library, which exports a world class with "big-bang" functionality

(module mini-world racket/gui
  (provide world%)
  
  (define INSET 5)
  
  (define world%
    (class object% 
      (init-field 
       ;; exists type State 
       ;; State 
       state0 
       ;; State -> Image 
       to-draw
       ;; Number 
       width
       ;; Number 
       height
       ;; [Maybe [State Nat Nat MouseEvent -> State]]
       (on-mouse #f)
       ;; [Maybe [State KeyEvent -> State]]
       (on-key #f))
      
      ;; -> Void 
      (define/public (start)
        (send editor-canvas min-client-width (+ width INSET INSET))
        (send editor-canvas min-client-height (+ height INSET INSET))
        (send editor-canvas focus)
        (send frame show #t))
      
      ;; PRIVATE PART 
      
      ;; (instance-of Frame%)
      (define frame
        (new frame%
             (label "The World Canvas")
             (alignment '(center center))
             (style '(no-resize-border))))
      
      ;; (instance-of World-pasteboard%)
      (define visible 
        (new world-pasteboard% [state0 state0][to-draw to-draw]))
      
      ;; EditorCanvas% -> EditorCanvas% possibly with on-char 
      (define/private (deal-with-key %)
        (if (not on-key)
            %
            (class %
              (super-new)
              ;; (instance-of Key-event%) -> State 
              ;; compute new state in reaction to key event 
              (define/override (on-char e) 
                (define state (send visible get))
                (send visible update! (on-key state (key-event->parts e))))
              
              ;; (instance-of Key-event%) -> String
              ;; turn essential key event information into string 
              (define/private (key-event->parts e)
                (define x (send e get-key-code))
                (cond
                  [(char? x) (string x)]
                  [(symbol? x) (symbol->string x)]
                  [else (error 'on-key (format "Unknown event: ~a" x))])))))
      
      ;; EditorCanvas% -> EditorCanvas% possibly with on-event 
      (define/private (deal-with-mouse %)
        (if (not on-mouse) 
            %
            (class %
              (super-new)
              
              ;; (instance-of Mouse-event%) -> State 
              ;; compute new state in reaction to mouse event 
              (define/override (on-event e)
                (define state (send visible get))
                (define-values (x y me) (mouse-event->parts e))
                (when (good-mouse? x y me)
                  (send visible update! (on-mouse state x y me))))
              
              (define/private (good-mouse? x y me) 
                (or (and (<= 0 x width) (<= 0 y height))
                    (member me '("leave" "enter"))))
              
              ;; (instance-of Mouse-event%) -> Natural Natural MouseEvent
              ;; turn a mouse event into its pieces 
              (define/private (mouse-event->parts e)
                (define x (- (send e get-x) INSET))
                (define y (- (send e get-y) INSET))
                (define me 
                  (cond
                    [(send e button-down?) "button-down"]
                    [(send e button-up?)   "button-up"]
                    [(send e dragging?)    "drag"]
                    [(send e moving?)      "move"]
                    [(send e entering?)    "enter"]
                    [(send e leaving?)     "leave"]
                    [else ; (send e get-event-type)
                     (define m (send e get-event-type))
                     (error 'on-mouse (format "Unknown event: ~e" m))]))
                (values x y me)))))
      
      ;; (instance-of World-editor-canvas%)
      (define editor-canvas
        (new (deal-with-mouse (deal-with-key  editor-canvas% #;world-editor-canvas%))
             (parent frame)
             (editor visible)
             (stretchable-width #f)
             (stretchable-height #f)
             (style '(no-hscroll no-vscroll))
             (horizontal-inset INSET)
             (vertical-inset INSET)))
      
      (super-new)))
  
  (define world-pasteboard%
    (class pasteboard%
      (init-field to-draw state0)
      
      ;; State -> Void
      ;; update the current state to s and display the state in visible
      ;; effect: mutate state, modify pasteboard 
      (define/public (update! s) 
        (set! state s)
        (show (to-draw s)))
      
      ;; -> State 
      ;; retrieve current-state
      (define/public (get)
        state)
      
      ;; ---------------------------------
      ;; the private part of the class 
      
      (inherit find-first-snip delete insert lock)
      (inherit begin-edit-sequence end-edit-sequence)
      
      ;; State 
      ;; current state of the world 
      (define state state0)
      
      ;; -> Void 
      ;; initialiaze state and show its image in visible 
      ;; effect: mutate state, modify pasteboard 
      (define/private (reset!)
        (set! state state0)
        (show (to-draw state)))
      
      ;; Image -> Void
      ;; show the image in the visible world canvas 
      ;; effect: modify pasteboard 
      (define/private (show pict)
        (begin-edit-sequence)
        (lock #f)
        (define s (find-first-snip))
        (when s (delete s))
        (insert (send pict copy) 0 0)
        (lock #t)
        (end-edit-sequence))
      
      (super-new)
      (reset!))))

;; -----------------------------------------------------------------------------
;; a sample client 

(module client racket 
  (provide main)
  
  (require 2htdp/image (submod ".." mini-world))
  
  (define (main)
    (send (new world% 
               [state0 10]
               [to-draw render]
               [width 220]
               [height 220]
               [on-mouse less1]
               [on-key less1])
          start))
  
  ;; Nat Any* -> Nat 
  ;; subtract 1 from the current state, 
  ;; regardless of the event 
  (define (less1 cd . other)
    (- cd 1))
  
  ;; Nat -> Image 
  ;; render cd as a red circle 
  (define (render cd)
    (define r (if (>= cd 0) cd 0))
    (circle (+ 10 (* 10 r)) 'solid 'red)))

;; -----------------------------------------------------------------------------
;; run program run 

(require 'client)
(main)
