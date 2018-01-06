#lang scribble/manual

@(require "shared.ss" scriblib/figure)

@title*[#:tag "turing is useless"]{Turing is Useless}

@date{Sep 14, 2014}

@(define (part1) (link "http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html" "Part I"))
@(define (part3) (link "http://www.ccs.neu.edu/home/matthias/HtDP2e/part_three.html" "Part III"))
@(define (part5) (link "http://www.ccs.neu.edu/home/matthias/HtDP2e/part_five.html" "Part V"))
@(define htdp-local-power "http://www.ccs.neu.edu/home/matthias/HtDP2e/part_three.html#%28part._sec~3alocal-is-power%29")
@(define htdp-functions-as-values "http://www.ccs.neu.edu/home/matthias/HtDP2e/part_three.html#%28part._sec~3aprog-similarities%29")
@(define htdp-world "http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._.D.K._sec~3adesign-world%29")

@; -----------------------------------------------------------------------------

@htdp[] aims for a paradigm shift in the teaching of programming. While
traditional texts introduce the expressive power of the chosen programming
language, @htdp[] presents systematic design strategies. Its exercises do not
ask students to practice the use of some linguistic features but to apply design
strategies. Put differently, @htdp[] ignores the expressive power of programming
languages in favor of the constructive power of its design strategies. This idea
deserves a close look, from instructors as well as students.

The Church-Turing thesis proclaims that all programming language have the same
expressive power. Mathematically speaking, Church and Turing say that
programming languages can express the partial recursive functions (on natural
numbers) and nothing else. A related theorem says that every partial recursion
function is expressible in an infinite number of ways in every programming
language. Pragmatically speaking, the thesis is completely useless at
best---because it provides no guideline whatsoever as to how to construct
programs---and misleading at worst---because it suggests any program is a good
program.@margin-note*{Also see my @italic{Science of Computation} paper
@link["http://www.ccs.neu.edu/home/matthias/papers.html#scp91-felleisen"]{on the
expressive power of programming languages}, but note that this essay makes a
different (though related) point.} Working software engineers must design their
products in a systematic way, and @htdp[] aims to discourage students from their
"tinker until it works" habits and imbue them with a "design attitude" from the
very beginning.

@; -----------------------------------------------------------------------------
@section{Traditional Texts}

Traditional programming texts tend to follow a uniform strategy. Each part
introduces another some linguistic mechanisms of a language, explaining their
syntax and semantics. It then presents some sample problems that are best solved
with these new mechanisms. The exercises ask students to solve a range of
similar problems. For the early parts of a book, students can solve such
exercises with a copy-and-edit approach. In later parts, exercises may ask
students to show some creative spark. When such books propose projects, the
evaluation is often concerned with the visible creativity of the software
product, occasionally with the creativeness of coding, but barely---and
sometimes not at all---with the design strategies used to construct the
software. 

Instructors know, and students often sense, that after some point, the
programming language can express the same functions a Turing machine can
compute. At that point, instructors of introductory programming courses can
assign any problem they want. If it accidentally falls outside of the range
of problems that the book has used and students have seen, they call those
students who solve it "creative," and they tell the others that they will
get it too, sooner or later.

@; -----------------------------------------------------------------------------
@section{@htdp[]}

Unlike traditional texts, @htdp[] focuses on design strategies. For the
first conceptual half, the design strategies are data-oriented. Starting
from atomic data, e.g. booleans, chars, numbers, and strings, this half
deals with intervals, enumerations, structures, and arbitrary unions until
it reaches mutually referential nests of descriptions of data. For the
conceptual second half, it deals with design strategies for abstraction,
generative recursion, and the addition of design attributes, e.g.,
accumulators and state (edition 1). 

@htdp[] introduces a new linguistic construct only in support of a design
strategy or when the available language lacks expressive power. For
example, the language of first-order recursive functions, enriched with
structure definitions, completely suffices to deal with the data-oriented
design strategies. To deal with abstraction properly, however, the chosen
programming language needs @link[htdp-functions-as-values]{functions as
values.} Similarly, if programmers wish to distinguish constants from
variables, @link[htdp-local-power]{the programming language needs to
support local definitions.}

At first glance @htdp[] suffers from the same problem as the traditional
approach.@margin-note*{With an expressive type system for its teaching
languages, @htdp[] could avoid this problem to some extent, but adding such
rich types would also take the fun out of programming.} Indeed, the
language of first-order functions on numbers is introduced on the very
first pages and an inspired student or instructor can easily find out that
this language admits recursive functions. The fundamental difference is
that @htdp[] @bold{explicitly} offers an alternative to the usual way of
writing "exercises that students ought to be able to solve with this
language."
 
@; -----------------------------------------------------------------------------
@section{Instructors New To @htdp[]} 

Instructors transitioning from the traditional way must become keenly aware
of the goal of @htdp[], namely, 
@;
@nested[#:style 'inset]{to teach systematic design}
@;
and of its means to achieve this goal: 
@;
@nested[#:style 'inset]{the series of design recipes and the various design
guidelines.}
@;
Every exercise in @htdp[] is solvable with the design recipes introduced so
far. Hence, when an instructor wishes to craft a new exercise, he must
first check whether the problem is solvable within @bold{the convex hull of
the design recipes}; he must ignore the expressive power of the available language. 

Using @htdp[] thus requires a different kind of effort from the instructors
than traditional texts. In a traditional setting, an instructor switches
from a text from a passé language to one that uses the latest
teeange-heartbreak toy with total ease; he just uses the new syntax for the
old problems. @htdp[] not only introduces book-specific teaching languages,
it also wishes instructors to know how to solve each homework and exam
problem with the design recipes available up to a certain section. Without
writing solutions first, it is almost impossible to achieve this goal. As
with everything else, this process eventually turns the design-first idea
into an acquired trait, that is, the idea becomes second nature and
instructors can "cruise" again.

The remaining sections illustrate this paradigm shift with some examples. 

@; -----------------------------------------------------------------------------
@section{Part I: Why No Recursion}

Imagine an instructor who has just started Part I of
@htdp[].@margin-note*{Adrian German inspired this section.} It is easy to see
why he may assign the following problem:
@; 
@nested[#:style 'inset]{Design the function @racket[double-at-rate], which
computes how many months it takes to double a given amount of money when a
savings account pay a certain monthly interest rate.}
@;
The instructor may expect a solution such as this one: 
@;%
@(begin
#reader scribble/comment-reader
(racketblock
;; Number -> Number
;; computes the number of months it takes to double 
;; a dollar at given @racket[interest-rate]

(check-expect (double-at-rate 1.0) 1)

(define (double-at-rate interest-rate)
  (double (+ 1.0 interest-rate) 1.0))

;; Number Number -> Number 
;; computes the number of months it takes to double 
;; a dollar at given compounding factor @racket[c]
;; @bold{assume} the initial value of @racket[current] is @racket[1.0]

(check-expect (double 2.0 1.0) 1)

(define (double c current)
  (cond
    [(>= current 2.0) 0]
    [else (add1 (double c (* c current)))]))
))
@;%
A particularly inquisitive student may also avoid recursion with a clever use of
@racket[big-bang]'s implicit looping ability, but let's ignore this possibility
here. 

A close look at the problem statement and the solution provides a number of insights: 
@itemlist[
@item{The function is to consume a plain number and produce one. Also, the
problem statement does not mention anything concerning a partitioning of the
number line.} 

@item{The solution consists of two functions, even though the problem statement
calls for one. 

A moment's reflection explains why it is difficult to create a one-function
solution in BSL if the function is to implement the specified signature.}

@item{The functions produce a number, but we actually know that it is a
"counting number," that is, a natural number.}

@item{The second function is expected to be supplied @racket[1.0] as the second
argument. If we know that, why is @racket[current] an argument at all?}

@item{The second function refers to itself, something that does not come up at
all in @part1[].}
]
These insights, especially the ones about the second function, suggest that
something's wrong here. 

@part1[] says that if numbers are considered atomic, the design knowledge comes
from the problem domain---and it is typically expressed as a
formula. Alternatively, if the problem statement organizes numbers into
intervals or enumerations, the function's body consists of @racket[cond]
expression that matches this organization. The first function simply calls the
second one, however, and this second function is recursive. While this form of
recursion could originate from the domain, it would then have to be explained to
the student within the problem statement, because @htdp[] teaches design as
understood in computing and @part1[] does not mention it. Something is really
wrong here. 

@bold{Plainly put, this problem falls completely out of scope for @part1[].}

A student who solves this problem should not receive (much) credit because at that
point the solution uses "garage programming." @margin-note*{The term is due to
Fred Brooks.} Conversely, the student does not understand why this design is
appropriate and what the design misses. All of this becomes clear only once the
course has covered the rest of the book.

Now assume the instructor finishes studying the entire text book. At that point,
he would understand two points. First, the second function ought to be defined
using the @racket[local] expressions from @part3[]; doing so guarantees that the
second argument is always @racket[1.0].  Second, the second function employs
generative recursion, as found in @part5[], and it should therefore come with a
"termination argument."

Here is a properly designed solution: 
@;%
@(begin
#reader scribble/comment-reader
(racketblock
;; Number -> NaturalNumber
;; computes the number of months it takes to double 
;; a dollar at the given @racket[interest-rate]

;; @bold{generative} add the interest paid for the next period 
;; @bold{terminates} if @racket[(> interest+principal 1.0)] holds

(check-expect (calculate (/ 0.06 12)) 139)

(define (double-at-rate interest-rate)
  (local ((define c (+ 1.0 interest-rate))
          ;; Number -> Nat
          (define (double current)
            (cond
              [(>= current 2.0) 0]
              [else (add1 (double (* current c)))])))
    (double 1.0)))
))
@;%
The function header comes with two additional lines in header: one that explains
 the function uses generative recursion and a second one that warns potential
 users that the function may not converge.@margin-note*{An alternative design
 would signal an error for such inputs.} The @racket[local] expression defines two
 names: the compounding rate @racket[c] and @racket[double], the function that
 performs the actual computation. The body of @racket[local] applies
 @racket[double] to the desired initial value; conversely, because the function is
 defined locally, it becomes impossible to use it with the wrong kind of
 arguments.@margin-note*{A Racket solution would use the @racket[for/fold] loop
 because a function whose arguments are always known is really a fixed use of a
 looping construct.}

@figure["fig:compound-via-world" "A world program to compute compound interest"]{
@;%
@(begin
#reader scribble/comment-reader
(racketblock
(require 2htdp/universe)
(require 2htdp/image)

(define-struct interest (rate current months))
;; Interest is (make-interest Number Number Number)
;; INTERPRETATION (make-interest c r m) says that after m months 
;; one dollar has grown to c dollars when the compound rate is r

;; Use clock ticks to simulate the passage of a month. 
;; Stop when the amount in the world structure has doubled. 

;; Number -> Number 
;; computes the number of months it takes to double 
;; a dollar at the given @racket[interest-rate]

(check-expect (double-at-rate-world (/ 0.06 12)) 139)

(define (double-at-rate-world interest-rate)
  (interest-months
   (big-bang (make-interest (+ 1.0 interest-rate) #i1.0 0)
             (on-tick compound)
             (to-draw show)
             (stop-when doubled?))))

;; Interest -> Interest 
;; pay one monthe worth of interest 

(check-expect (compound (make-interest 1.06 1.0 0)) 
              (make-interest 1.06 1.06 1))
(check-expect (compound (make-interest 1.06 1.06 0))
              (make-interest 1.06 (* 1.06 1.06) 1))

(define (compound i)
  (make-interest (interest-rate i) 
                 (* (interest-current i) (interest-rate i)) 
                 (add1 (interest-months i))))

;; Interest -> Boolean 
;; is current greater or equal to 2.0

(check-expect (doubled? (make-interest 1.06 1.0 0)) #false)
(check-expect (doubled? (make-interest 1.06 2.0 10)) #true)

(define (doubled? i)
  (>= (interest-current i) 2.0))

;; Interest -> Image
;; show the current value of i as a text image 
(define (show i)
  (overlay
   (text (number->string (interest-current i)) 22 "blue")
   (square 500 'solid 'white)))
))
@;%
}

An imaginative student may design a world program to solve this
problem. @Figure-ref{fig:compound-via-world} shows such a solution.  If the
student follows the program design recipe for worlds and the function design
recipe for the clock tick handler, the solution deserves nearly full credit. The
instructor should still challenge the student to justify the inclusion of (1) the
number of months in the data representation of the world and (2) the inclusion of
the compound rate. The former is justified because @link[htdp-world]{the number of
months change as the world program runs}.@margin-note*{It is also an instance of
the "accumulator in the data structure" idea discussed in
@link["http://www.ccs.neu.edu/home/matthias/HtDP2e/part_six.html"]{Part VI} but it
is always justified by the world design recipe.} The latter is necessary because
the interest rate is an argument of @racket[double-at-rate-world] and only then
becomes a world-wide constant; see @link[htdp-local-power]{the introduction of
@racket[local]} for an explanation.
