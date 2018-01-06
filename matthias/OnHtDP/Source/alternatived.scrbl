#lang scribble/manual

@(require "shared.ss")
@(require 
  (for-label teachpack/2htdp/universe teachpack/2htdp/batch-io (except-in 2htdp/image image?)))

@title*{Alternative Data Designs}

@date{12 June 2011}

Early this year, Stephen Bloch posted the following problem on the mailing
list: 

 @nested[#:style 'inset]{The game presents the player with a collection of
 randomly located dots on a canvas. Every second the collection changes and
 one point is added. The player uses the mouse to ``chase'' the points.
 The game ends when the player clicks on one of the dots, at which point
 the game software should display the text ``Congratulations!'' in the
 center of the canvas.}

He noted that a solution to this problem based on the ``world'' library
 looks complex and thus seems to expose a gap in the library's
 interface. Specifically, a student who designs a world program may
 naturally come up with the following data representation for this game
 world:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @deftech{DotGameWorld} = [Listof Posn]
;; Posn = (make-posn Nat Nat)
;; interpretation: the centers of the dots 
))
@;%
 Since the problem statement basically dictates the use of an
 @scheme[on-tick] and an @margin-note*{See
 @hyperlink["http://www.ccs.neu.edu/home/matthias/HtDP2e/htdp2e-part1.html#(part._.D.K._design-world)"]{Designing
 World Programs} for designing world programs.}
 @scheme[on-mouse] handler, this choice of data representation induces the
 following wish list and possibly more: 
@itemlist[

@item{a tick handler:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld} -> @tech{DotGameWorld} 
;; create a random world that is one posn longer than this one 
))
@;%
}

@item{a rendering function:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld} -> Image 
;; render this world as a scene of dots 
))
@;%
}

@item{a mouse handler:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld} Nat Nat MouseEvent -> @tech{DotGameWorld} 
;; is the player's mouse click on a dot in this world? 
))
@;%
}

@item{a function that checks whether the game is over: 
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld} -> Boolean 
;; is the game over? 
))
@;%
}
]
@;
 Furthermore the design recipe for world programs demands a @scheme[main]
 function that looks roughly like this: 
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; Nat -> @tech{DotGameWorld}
;; start the world with n+1 dots 
(define (main n)
  (big-bang (random-world (add1 n))
            (on-tick add-one @code:hilite[1])
            (to-draw draw-dots)
            (on-mouse catch-one)
            (stop-when over?)))
))
@;%
 As the problem statement says, it makes the clock tick once per second. 

With a bit of further reflection, it becomes clear that the mouse event
 handler plays two distinct roles. The API dictates that it processes a
 mouse click, meaning it consumes an element of @tech{DotGameWorld} and
 some extra arguments and that it produces an element of
 @tech{DotGameWorld}. The game specification demands that, in case the
 mouse click is on a dot, the world it returns signals that the game is
 over. Similarly, the @scheme[stop-when] handler wants to know which worlds
 signal that the game is over. Nothing in the data definition indicates,
 however, which lists represent a world in which the player has caught a
 dot. In short, it is unclear when the game should end. 

The purpose of this note is to show how different data representations for
 one and the same ``world'' work differently with the constraints of a
 library's interface. In this case, one ``obvious'' fix is to add a
 distinct set of ``final'' worlds to the data representation; another one
 is to designate one kind of world as special. Each choice comes with
 advantages and disadvantages, and your students need to learn to
 appreciate that choices of data representation have implications for the
 design of functions. 

@; -----------------------------------------------------------------------------
@section{Strings are Final}

Stephen Bloch's students suggest that the mouse handler should return a
 string when the player hits a dot on the canvas: 
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
(define (catch-one w x y me)
  (cond
    [(mouse=? "button-down" me)
     (if (is-on-a-dot? w x y) "CONGRATULATIONS!" w)]
    [else w]))
))
@;%
 Technically, a string is illegal as a return value given our definition of
 @tech{DotGameWorld} above. But that's easy to fix. All we have to do is
 add strings to the world definition: 
@(begin
#reader scribble/comment-reader
(schemeblock
;; @deftech{DotGameWorld.v2} is one of
;; -- String 
;; -- [Listof Posn]
;; interpretation: a string represents a final world 
;;   and a list represents the centers of the dots 
))
@;%
 But this is where the trouble starts.

Now every single handler function consumes and produces elements of
 @tech{DotGameWorld.v2}. If we follow the design recipe, every handler
 function starts with a conditional that differentiates strings from lists
 of Posns. For example, the function that deals with clock ticks must have
 this shape: 
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld.v2} -> @tech{DotGameWorld.v2}
(define (add-one w)
  (cond
    [(string? w) ...]
    [(list? w) ...]))
))
@;%
 And that, even though @scheme[tick-handler] is never applied to a
 string. Only one of our functions will ever see a string in the course of
 a normal game, and that is the function that stops whether the game is
 over: 
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld.v2} -> Boolean 
;; is the game over?
(define (over? w)
  (string? w))
))
@;%

What this exercise teaches us is that this kind of data representation is
 bad. It forces the designer of the functions to account for pieces of data
 that never show up. Even for a small program like this one, the extra
 overhead reduces the readability of the program. The situation calls for
 going beyond the first, obvious design. 

@; -----------------------------------------------------------------------------
@section{Worlds and Final Worlds}

At this point it is important to recall that a data definition describes a
 set of data. More precisely, it describes a subset of all possible values
 in our programming language, and even better, it provides instructions for
 how to construct all the elements. The question is how this understanding
 helps with our problem. 

Here is how. We describe handlers as functions that consume elements of
 @tech{DotGameWorld} and allow the mouse event handler to produce elements
 of @tech{DotGameWorld.v2}, which is a @emph{superset} of
 @tech{DotGameWorld}.  Fortunately, the API tells us that the
 @scheme[stop-when] function will process the result of a handler before it
 flows back to other handlers---assuming it is supplied. Put differently,
 the only function that really needs to know about strings as inputs is
 @scheme[over?] and if it sees a string, it must stop the game. So let's
 look at the wish list again: 

@itemlist[

@item{a tick handler:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld} -> @tech{DotGameWorld} 
;; create a random world that is one posn longer than this one 
))
@;%
}

@item{a rendering function:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld} -> Image 
;; render this world (list of posns) as a scene of dots 
))
@;%
}

@item{a mouse handler:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld} Nat Nat MouseEvent -> @tech{DotGameWorld.v2}
;; is the player's mouse click on a dot in this world? 
;; @emph{if so produce a string!}
))
@;%
}

@item{a function that checks whether the game is over, and that is only the
case when the input is possibly a string: 
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld.v2} -> Boolean 
;; is the game over? 
))
@;%
}
]
@;
 The one remaining problem is that the rendering function doesn't deal with
 strings. This is easily fixed by supplying a function that draws final
 worlds: 
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; String -> Image 
;; draw the final world state, which is just a string 
(define (draw-final w) 
  (overlay (text w 22 'red) BGRD))
))
@;%

For completeness, here is the revised @scheme[main] function:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; Nat -> World.v1
;; start the world with n+1 dots 
(define (main.v2 n)
  (big-bang (random-world (add1 n))
            (on-tick add-one 1)
            (to-draw draw-dots)
            (on-mouse catch-one)
            (stop-when over? draw-final)))
))
@;%
 It differs from the first one in the last line, where it specifies
 @scheme[draw-final] as the function that renders the world when the game
 is over. 

And that is all there is to dealing with strings a bit more naturally. This
 treatment would also work in a language such as Java where subtyping is
 similar to the subset reasoning we use here, but it would fail in a
 strictly hierarchical language such as ML. In the latter world, we have to
 reason about the data representation of the game world in a third way. 

@; -----------------------------------------------------------------------------
@section{Empty is Useless}

This third way exploits a different insight, namely, that the game---as
 discussed so far---can never create an empty list. Our @scheme[main]
 function always starts the game with at least one dot. By specification,
 the clock ticks every second, and the tick handlers creates a world with
 one more dot. In short, it is acceptable to think of the @scheme[empty]
 list as a special element in @tech{DotGameWorld}.

We can exploit this special nature of @scheme[empty] via a change in the
 interpretation of the data definition: 
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld} = [Listof Posn]
;; Posn = (make-posn Nat Nat)
;; interpretation: empty represents the final world, 
;;   a non-empty list represents the centers of the dots 
))
@;%
 This small change, in turns, suggests a third variant of the main
 function: 
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; Nat -> World.v1
;; start the world with n+1 dots 
(define (main.v3 n)
  (big-bang (random-world (add1 n))
            (on-tick add-one 1)
            (to-draw draw-dots)
            (on-mouse catch-one.v3)
            (stop-when empty? draw-final.v3)))
))
@;%
 Naturally, this change expects that @scheme[catch-one.v3] produces
 @scheme[empty] when a mouse click hit a visible dot. 

Furthermore, as the change in name for @scheme[draw-final] indicates, we
 need to be careful with drawing the final world. If we were to use
 @scheme[draw-final] from above, it would signal an error because it
 assumes the input is a string. Now the input is just a regular world,
 though from the @scheme[stop-when] test we know it's the @scheme[empty]
 list. We do know, however, that the final scene should just say
 ``congratulations'' and that is easy to accomplish:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
;; @tech{DotGameWorld} -> Image 
;; draw the final scene, which is always the empty list 
(define (draw-final.v3 w) 
  (overlay (text "CONGRATULATIONS!" 22 'red) BGRD))
))
@;%
 
The best point is that with this change, the ``naive'' design from the
 beginning of the essay works out perfectly.  The rest of the program
 consists of some 10 lines of additional code.

@; -----------------------------------------------------------------------------
@section{Conclusion}

The three sections show how the choice of a data representation and the
 existing APIs of a language are intertwined. In this particular example,
 the world teachpack allows a separation of rendering for intermediate
 state from the rendering for final states; because of this twist, we can
 use @scheme[empty] as the final world. In general, it is important to
 explore data representations for real programs and not to stick to the
 first one that comes to mind. 

Another point to observe is that different representations come with
 different advantages. Consider a small change to the problem statement: 

 @nested[#:style 'inset]{... at which point the software should display the
 text ``Congratulations: <nm>'' in the center of the canvas, where <nm> is
 the number of dots on the screen. Players can now measure and compare
 their performance.} 

 Clearly, the last solution cannot possible accommodate this change. Since
 the @scheme[catch-one.v3] function produces @scheme[empty] when the mouse
 click hit a dot, the length information is lost. In contrast, we can
 easily modify the @scheme[catch-one.v2] function from the string based
 solutions so that it returns an appropriate string when the game is over:
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
(string-append "Congratulations: your game world contains "
	       (number->string (length w))
	       " dots. Can you do better next time?")
))
@;%

When you teach a course that allows sufficiently interesting trade-offs
 like the ones discussed here, formulate exercises that tease out these
 problems. Your students will greatly benefit from exploring and comparing
 alternative data representation ideas. That's how real life works, and
 with DrRacket it is easy to explore trade-offs in a technically meaningful
 way. 
