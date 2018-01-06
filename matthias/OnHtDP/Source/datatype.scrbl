#lang scribble/manual

@(require "shared.ss" scribble/eval racket/sandbox)

@(define-syntax-rule (mk-plai defs ...)
  ;; ==> 
  (let ([me (make-base-eval #:lang 'plai)])
    (call-in-sandbox-context me (lambda () (error-print-source-location #f)))
    (interaction-eval #:eval me defs) 
    ...
    me))

@(require
   scriblib/figure
   (for-label
     (only-in plai define-type type-case)
     teachpack/2htdp/universe
     teachpack/2htdp/batch-io
     (except-in 2htdp/image image?)))

@; =============================================================================
@title*{*SL, Not Racket}

@date{08 June 2014}

I often get emails from instructors that report on their experience with
@htdp[] and its teaching languages, called *SL (short for the collection
BSL, BSL+, ISL, ISL+, and ASL), and request their favorite ways of
strengthening the latter. And indeed, Racket and its cousins come with all
the conveniences of modern programming languages. For example, Racket
programmers can use pattern-@racket[match]ing in function definitions,
define algebraic data types with @racket[define-type], de-structure
instances of the latter with @racket[type-case] in a checked manner,
iterate over compound data with comprehensions using conventional
@racket[for] syntax, and so on.

@nested[#:style 'inset]{Why do @htdp[] and *SL shun these conveniences?}

@nested[#:style 'inset]{Don't they come with all kinds of advantages that would benefit students?}

This note is a full answer to this question. The first two sections make a
strong argument how @htdp[] and its *SLs might benefit from algebraic data
types and pattern matching. The remaining sections explain why *SL
nevertheless does not includes such features right now.

@; -----------------------------------------------------------------------------
@section{Concision from Racket}

Let's start with a concrete example. The left side of
@figure-ref{fig:htdp-vs-dt} displays a simple program from @htdp[] part 1. It
starts with two structure type definitions, followed by a data definition
that introduces the collection of @tech{Shape}s and specifies what kind of
values the structures may consume. Further following the design recipe, the
program comes with two data examples. The remainder defines a function,
including a signature, a purpose statement, two function examples, and the
definition proper. A student in Northeastern's introductory course is
expected to design this kind of program in the third week. 

@figure["fig:htdp-vs-dt" "A BSL program vs its Racket version"]{
@tabular[ 
@list[
@list[
@; -----------------------------------------------------------------------------
@;%
@(begin
#reader scribble/comment-reader
(racketmod #:file "in HtDP" 
htdp/bsl
;;
;; structure type defs. 
(define-struct circle (r))
(define-struct square (s))

;; data definition
;; A @deftech{Shape} is one of: 
;; -- @racket[(make-circle #, @italic{Positive})]
;; -- @racket[(make-square #, @italic{Positive})]

;; data examples 
(define c (make-circle 1))
(define s (make-square 1))

;; @tech{Shape} -> @italic{Number} 
;; the area of a shape @racket[s]
(check-within (area c) pi 0)
(check-expect (area s) 1)

(define (area s)
  (cond
    [(circle? s) 
     (* pi (circle-r s)
           (circle-r s))]
    [(square? s) 
     (* (square-s s)
        (square-s s))]))
))
@;%
@; -----------------------------------------------------------------------------
@;%
@(begin
#reader scribble/comment-reader
(racketmod #:file "in Racket" 
plai 
(require test-engine/racket-tests)
;; structure type & data def.
(define-type Shape 
  (Circle (r positive?))
  (Square (s positive?)))





;; data examples 
(define c (Circle 1))
(define s (Square 1))

;; @tech{Shape} -> @italic{Number} 
;; the area of a shape @racket[s]
(check-within (area c) pi 0)
(check-expect (area s) 1)

(define (area s)
  (type-case Shape s
   [Circle (r) (* pi r r)]
   [Square (s) (* s s)]))



(test)
))
@;%

@; -----------------------------------------------------------------------------
]]]
}

The right side of @figure-ref{fig:htdp-vs-dt} shows how to express the same
program in Racket's @racketmodname[plai] flavor. A first glance shows that
the program has two blank spaces. The first one results from Racket's
ability to combine the structure type definition and the data definition
into one @racket[define-type] definition, often called an
@defterm{algebraic datatype} in the programming language literature. The
second white space, near the bottom of the program, is due to the
@racket[type-case] construct used in the definition of
@racket[area]. Roughly, @racket[type-case] is a specialized pattern
matching form; it classifies and then deconstructs an instance of a
datatype. @defterm{Deconstructing} means that in each clause
@racket[type-case] binds variable names to the field values of an
instance. As a result, such clauses tend to be much more concise than 
the corresponding clauses in the corresponding @racket[cond] clauses. 

@; -----------------------------------------------------------------------------

@(define bsl 
  (bsl-eval
    (define-struct circle (r))
    (define-struct square (s))
    (define c (make-circle 1))
    (define s (make-square 1))
    (define (area s)
      (cond
        [(circle? s) (* pi (circle-r s) (circle-r s))]
        [(square? s) (* (square-s s) (square-s s))]
 ;; this is a fake error message
        [else (displayln "cond: all question results were false")]))))


@(define plai (mk-plai
(define-type Shape 
  (Circle (r positive?))
  (Square (s positive?)))

(define c (Circle 1))
(define s (Square 1))

(define (area s)
  (type-case Shape s
   [Circle (r) (* pi r r)]
   [Square (s) (* s s)]))
))

@section{Protection from Racket}

Racket programs are not only more concise than *SL programs, they also come
with protection mechanisms that benefit novice students. Consider the
creation of structure instances:  
@interaction[#:eval bsl
(make-circle -1)
(make-square 'a)]
In *SL programs, a constructor consumes @emph{any kinds of values} and
creates a structure instance. But this instance may or may not belong to a
class of values introduced via a data definition. Here neither of the two
examples is a @tech{Shape} in the sense of the data definition in
@figure-ref{fig:htdp-vs-dt}. If students accidentally create such an
instance, they get no warning until it is used in a context that assumes
the instance belongs to @tech{Shape}. 

Contrast this with the behavior of constructors defined in the
@racketmodname[plai] flavor: 
@interaction[#:eval plai
(Circle -1)
(Square 'a)
]
Here the constructors themselves immediately signal an error if a student
supplies the wrong kind of argument. It is simply impossible to construct a
circle whose radius is @racket["hello world"] or some such nonsensical
value. 

Wouldn't your students benefit from such errors and error messages? 

Similarly, the use of @racket[type-case] also improves how functions
themselves inform students when they are applied to the wrong kind of
value. In *SL, a @racket[cond] runs out of options and reports this as an
error: 
@interaction[#:eval bsl
(area "hello")
]
Now take a look at the error message issued by the @racketmodname[plai]
version: 
@interaction[#:eval plai
(area "hello")
]
The error message not only tells students that none of the clauses works
for the given value. It also explains why they don't match. With a bit of
interpolation, the student may infer that the @racket[area] function
received the string @racket["hello"] instead of an instance of the
@tech{Shape} type. 

So why not include @racket[define-type] in *SL? 

@; -----------------------------------------------------------------------------
@section{HtDP and its *SLs}

For the past two decades, instructors have praised @htdp[] as ``the best
introduction to {object-oriented | functional} programming around.'' The
preceding sentence uses Kleene notation because the sentence usually says
one or the other. It also brings across that these sentiments come from
people steeped in programming language theory, for whom this notation is a
natural. 
 
Yes, @htdp[] and its supporting teaching languages assume that students
either know algebra or get to know algebra via the study of program
design. BSL is therefore an ``algebraic'' language; and @htdp[] takes its
inspiration from functional program design because it is the best fit for
such novices. Still, 

@nested[#:style 'inset]{ 

 @bold{@htdp[] aims to teach principles of program design for @emph{all
 kinds} settings.}}

In support of this goal, @htdp[] cannot @margin-note*{This claim applies to
other programming languages, too. Languages with C-style syntax, for
example, suffer from a superficial similarity with algebraic notation.} and
does not rely on an existing, off-the-rack programming language.  On one
hand,

@nested[#:style 'inset @bold{*SLs eliminate the key problems of Scheme's
 syntax and improve some run-time checks and their feedback.}  ]

As documented in the
@link["http://www.ccs.neu.edu/racket/pubs/#jfp01-fcffksf"]{the
@italic{DrScheme} papers}, students struggle with Scheme's liberal syntax,
which makes too many programs grammatically correct and assigns odd meaning
to them.

On the other hand, 

@nested[#:style 'inset]{
 @bold{*SLs provide @emph{minimal} support for the principle of program
 design in @htdp[].}} 

Each teaching language corresponds to a stage in @htdp[]. BSL comes with
(conditional) function definitions, which students may know from K-12
algebra courses. To this mix, it adds structure type definition, which
introduces the idea of programmer-defined forms of data; structure type
definitions are available in a wide spectrum of existing programming
languages. BSL+ makes it easy to use lists for non-trivial data. ISL and
ISL+ expand these two languages with the goal of managing abstraction.

The 

@nested[#:style 'inset]{
  @bold{*SL support for design is minimal to eliminate any doubt that the 
  design principles apply in any setting.}} 

As much as we, the authors of @htdp[], embrace functional program design,
we also wish to use @htdp[] as a framework for gradually introducing these
novice programmers into full-fledged computing and software
engineering---neither of which is purely functional.

@; -----------------------------------------------------------------------------
@section{Balance for Students}

Shortly after students finish an introductory course sequence, they tend to
go to an internship or a co-op. According to Northeastern's Co-op
Department in the College of Computer Science, these students typically
encounter scripting languages (about half), mainstream object-oriented
languages such as C# and Java (about one third), and unsafe versions of C
such as C, C++ and Objective C (the rest). While this distribution isn't
fixed and while it is likely to differ from university to university, I
consider it indicative of students' needs. 

@; In addition to program design, the introductory sequence must give students
@; of types, classes, some basic ``industrial'' idioms, and programming to
@; libraries.

If @htdp[] were to exploit advanced constructs from functional programming
languages to teach design, it would do students a disfavor. While the world
is slowly waking up to the advantages of functional programming, students
will not use functional languages for most internships, co-ops, and
introductory jobs. The first course must prepare them for the whole
spectrum of ideas they will encounter. The *SLs therefore cannot borrow too
many elements from the functional world, and @htdp[] must teach principles
of program design without full-fledged support that functional programmers
have on a daily basis.

Hence, @htdp[] and its teaching languages strike a balance between the
inspirational background (functional programming) and the goal of preparing
students for the real world of programming. Their co-design is subtle but
purposeful. 

@nested[#:style 'inset]{ @bold{introductory courses are to use the teaching 
 languages (*SLs).}}

Over many years, I have learned to present this choice and the idea of
balance to my students and my colleagues who teach downstream courses. And
I think people have come to accept it. 

@; -----------------------------------------------------------------------------
@section{I Want It All, I Want It Now}

Having said that, I know that while most instructors use @htdp[] for
introductory courses, some assign it as a text for courses on functional
programming and others uses it as a quick immersion in design principles in
upper-level courses. That's great. It is never too late to expose
programmers to systematic design. 

So, if you are one of those instructors who wish to use @htdp[] in an
upper-level course, especially in a course on functional programming,
@emph{please} extend the teaching languages with those features from Racket
that you find appropriate. See @figure-ref{fig:bsl+plai} for how to inject
@racket[define-type] into *SL programs.

@figure["fig:bsl+plai" "Using PLAI's define-type in BSL"]{
@;%
@(begin
#reader scribble/comment-reader
(racketblock
(require plai)

; structure type with data def.
(define-type Shape 
  (Circle (radius positive?))
  (Square (side positive?)))

;; data examples 
(define c (Circle 1))
(define s (Square 1))

;; @tech{Shape} -> @italic{Number} 
;; the area of a shape @racket[s]
(check-within (area c) pi 0)
(check-expect (area s) 1)

(define (area s)
  (type-case Shape s
   [Circle (r) (* pi r r)]
   [Square (s) (* s s)]))
))
@;%
}

In general, you should prepare a teachpack that imports your favorite
Racket features, specializes them for novice programmers, and exports these
revised features for use in your class. 
