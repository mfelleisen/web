#lang scribble/manual

@; TODO: 
@; algebra -> programming connection emphasize in TL 
@; conclusion about "try your own, but remember the trinity"

@(require "shared.ss")

@(define (htdp) @link[2e]{How to Design Programs})
@(define (fI) @italic{Fundamentals I})
@(define (fII) @italic{Fundamentals II})
@(define (logic) @italic{Logic in Computer Science})
@(define (ood) @italic{OOD})
@(define (swd) @italic{Software Dev})

@title*{Design Matters}
@author{Matthias Felleisen}

@date{---}

@section*{Abstract}

@; -----------------------------------------------------------------------------

@(define nl @element['newline]{ })
@(define hs @element['hspace]{---})

@history[
 #:changed "1.0" @list{Wed Sep 16 15:07:49 EDT 2015: initial release @nl}
]

@;{
 #:changed "1.6" @list{Thu Nov  5 21:27:20 EST 2015 feedback, typos from
 @nl @hs Thomas Wahl
 @nl}
 #:changed "1.5" @list{Sun Sep 20 15:24:08 EDT 2015 added @secref{trinity},
 @nl
 @hs fixed the description of Waterloo's curriculum
 @nl}

 #:changed "1.4" @list{Fri Sep 18 10:28:42 EDT 2015: note on
 	    @link[sam-david]{OO teaching languages} @nl}

 #:changed "1.3" @list{Thu Sep 17 18:59:11 EDT 2015: added @figure-ref{fig:steps} @nl}

 #:changed "1.2" @list{Wed Sep 16 23:14:00 EDT 2015: added @secref{unique} @nl}

 #:changed "1.1" @list{Wed Sep 16 21:59:11 EDT 2015:
typos and feedback from 
@nl @hs Tony Garnock-Jones,
@nl @hs Therapon Skotiniotis, 
@nl @hs Shriram Krishnamurthi,
@nl @hs Matthew Flatt, 
@nl @hs Vincent St-Amour,
@nl @hs Karl Lieberherr
@nl @hs Nick Shelley 
@nl
}
}

@; -----------------------------------------------------------------------------
@section{Workmanship of Risk}

Homeowners and interior architects dream of perfect interiors. They design
the ideal kitchen, give the best-of-all plans to the workman, and then wake
up to a nightmare of mistakes. The carpenter messed up all angles with the
hexagonal butcher block. The mason managed to break the granite. The
cabinet makers forgot to use the beveled glass. The plumber switched the
hot and cold water pipes. What now? 

Software engineers and developers know exactly how this happens. 
