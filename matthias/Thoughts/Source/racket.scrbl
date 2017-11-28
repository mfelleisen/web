#lang scribble/base

@(require "shared.ss"
   (only-in (for-label typed/racket)
     define:
     for/fold:
     require/typed
     String
     Any
     Listof
     Natural))

@title*{@emph{Racket} is ...}

@date{4 June 2011}

Racket is a programming language. That's what it says at
 @url{http://racket-lang.org}. But what does this mean?

@emph{To a programmer, Racket is a programming language}, a wide-spectrum
 language, and a family of programming languages. As a programming
 language, Racket inherits many traits from Lisp, Scheme, and the
 functional programming culture but it also mixes in elements of
 object-oriented programming. A Racket programmer can design code in a
 variety of styles and dialects: the untyped core
 (@racketmodname[racket/base]) is reminiscent of plain Scheme and Lisp; the
 ``full'' version (@racketmodname[racket]) supplies conventional
 classes plus mixins and traits, among other things; the typed variant
 (@racketmodname[typed/racket]) is as type-safe as ML yet accommodates many
 of the untyped programming patterns that Lispers and Schemers know and
 love; the dataflow version of Racket (@racketmodname[frtime]) brings
 on-demand programming to our world; the web server language
 (@racketmodname[web-server]) adds capabilities for writing web
 servlets; and the lazy version (@racketmodname[lazy]) empowers programmers
 to act as if they were writing stream-based programs in Haskell. Best of
 all, Racket comes with a module system that allows programmers to write
 modules in distinct members of the Racket family and to safely link these
 modules together. In short, a Racket programmer chooses the most
 appropriate language and programming style for the task at hand, creates a
 module, and eventually links the various modules into a coherent whole.

@emph{To a language designer, Racket is a programming language laboratory}.
 @margin-note*{This @emph{does not mean} that the language is unstable. The
 designers do not change the language in a whimsical manner.}  That is,
 Racket comes with a unique collection of linguistic mechanisms that enable
 the quick construction of reliable languages, language fragments, and
 their composition. These tools are so easy to use that plain programmers
 can design a language after a little bit of instruction. So when a
 well-trained programmer decides that none of the available dialects is
 well-suited for a task, he designs a new dialect and writes his program in
 it. As Paul Hudak said, ``the ultimate abstraction is a domain specific
 language.''

For a programmer who grew up in a conventional language, say C or Java,
 creating his very own language may not mean anything. Or it may mean an
 overwhelming amount of work: a lexer, a parser, a type checker, a code
 generator, and possibly more. None of this is necessarily needed in
 Racket. With Racket a programmer hooks additions into the desirable point
 of the language processing tool chain, and voila there is a new
 language. The most common entry points are the additions of new language
 constructs---via macros---and the creation of complete language
 dialects---via much more than macros.

@; -----------------------------------------------------------------------------
@section{Creating a Language}

Here is a simple Racket module:
@;
@racketmod[#:file
@tt{simple}
racket 

(define (count l)
  (cond
    [(empty? l) 0]
    [else (+ (count (rest l)) 1)]))

(define result (count '(a b c)))

(displayln `(the result is ,result))
]
@;
 The first line of the module specifies the language of the module, in this
 case @racketmodname[racket]. The body of the module intermingles
 definitions and expressions. When run, the module prints
 @racketoutput{`(the result is 3)}.

The language of a module is simply a path to a Racket module that exports
 some essential pieces of functionality. In principle, all that is needed
 is a definition for @scheme[#%module-begin], a form that processes the
 body of the module. So here is an extremely small language: 
@;
@racketmod[#:file 
@tt{silly-lang}
racket

(define-syntax-rule
  (count-forms mexpr ...)
  (#%module-begin
    `(the module contains ,(length '(mexpr ...)) forms)))

(provide (rename-out (count-forms #%module-begin)))
]
 This plain Racket module defines one syntactic rewriting rule. Its purpose
 is to rewrite shapes of the form @scheme[(count-forms _expr1 ... _exprN)]
 into the shape
@;%
@(begin
#reader scribble/comment-reader
(schemeblock
 (#%module-begin
   `(the module contains ,(length '(@#,racket[_expr1] ... @#,racket[_exprN])) forms))
))
@;%
 Since Racket is a lexically scoped language, @scheme[#%module-begin]
 in this rewritten form is the one from Racket. Finally the module exports
 this syntactic rewriting rule under the new name @scheme[#%module-begin]. 

When Racket---the language family---encounters a module, it packages up the
 rest of the module into a sequence and wraps it with @scheme[(#%module-begin ...)].
 @margin-note*{Racket needs a little bit more than a module to create a
 language. A module per se is a language mixin and the
 @racketmodname[s-exp] turns the mixin into a language. Roughly speaking, 
 it turns the module into an S-expression by wrapping the series of
 expressions and definitions with @scheme[(module simple-in-silly "silly-lang.rkt" ...)].}
 Hence if we change the language of our @tt{simple} module to
 @tt{silly} like this: 
@;
@racketmod[#:file
@tt{simple-in-silly}
s-exp "silly-lang.rkt"

(define (count l)
  (cond
    [(empty? l) 0]
    [else (+ (count (rest l)) 1)]))

(define result (count '(a b c)))

(displayln `(the result is ,result))
]
 Racket applies the rewriting rule originally defined as
 @scheme[count-forms] and renamed on export to @scheme[#%module-begin]. It
 thus obtains a new module body and evaluates it, which prints
@racketresultblock[(the module contains 3 forms)]
 In short, creating a language is as easy as writing a module. 

Take a look at this slightly more interesting programming language: 
@racketmod[#:file
@tt{pseudo-lazy}
racket 

(provide #%module-begin #%datum #%top-interaction 
         define lambda 
         [rename-out (application #%app) ... (div /)])

(define-syntax-rule
  (application function-position argument ...)
  (function-position (lambda () argument) ...))
_ _ _ 
(define (strictify f)
  (lambda args (apply f (map force* args))))
_ _ _ 
(define div (strictify /))
_ _ _ 
]
@;
 It re-exports several pieces of functionality from plain Racket:
 @scheme[#%module-begin]; @scheme[#%datum], which allows us to write down
 literals; @scheme[#%top-interaction], which enables interactive expression
 evaluations; plus the @scheme[define] and @scheme[lambda] forms. These
 re-exports demonstrate how a language designer can reuse constructs from
 the core language and implicitly exclude others. This form of
 @emph{linguistic reuse} is unique to Racket, and it is what makes language
 creators highly productive.

Finally the @tt{pseudo-lazy} module exports the locally defined
 @scheme[application] rewriting rule with the name @scheme[#%app]. The
 latter is the syntax that the parser assigns to function
 applications. What this export means then is that @emph{every function
 application is rewritten} with the arguments turned into functions of no
 arguments (aka, thunks).

As the name of the module suggests, it provides some amount of
 laziness. The following example illustrates the idea:
@;
@racketmod[#:file 
@tt{lazy-test}
s-exp "pseudo-lazy.rkt"

(define (hänsel x) 42)
(define (gretel x) @code:hilite[(x)])

(hänsel (/ 1 0))
(gretel (/ 1 0))
]
@;
 This module defines two functions: @scheme[hänsel] and @scheme[gretel]. The
 former returns @scheme[42], the latter invokes its argument as a thunk. The two
 definitions are followed by applications of the functions. When run, the
 first function application returns @scheme[42] even though the argument
 divides @scheme[1] by @scheme[0]; in other words, we have successfully
 modified the call-by-value behavior of plain Racket's function
 applications. The second function application, however, raises the
 exception once the thunk is applied to no arguments. 

For good measure let's experiment in the read-eval-print-loop of DrRacket,
 the Racket IDE: 
@interaction[
 #:eval (sexp-eval (define x 1))
((lambda (x) 42) 
 ((lambda (x) (x x)) 
  (lambda (x) (x x))))
]
 Once the module is loaded, DrRacket treats expressions as if they belong
 to the module. In particular, they are executed in the specified language,
 not in Racket. Hence, applying a constant function to the most famous
 diverging (looping) lambda calculus expression works the way every lazy
 programmer expects it to work. 

No, the @tt{pseudo-lazy} language isn't a lazy variant of Racket
 (yet). But it took only a few minutes to create the language and to test
 it. Even the Racket IDE understands the language, and all that takes is a
 re-export of @scheme[#%top-interaction] from the
 language module. And with another couple of hours of work, a Racket
 programmer can create a full-fledged lazy variant and use it for his work.

@; -----------------------------------------------------------------------------
@section{Mixing up Languages}

So Racket is a language for creating and mixing up languages. Let's see how
 a production programmer may exploit this idea.

Everyone who has constructed a large software system knows that different
 aspects of a project call for different languages. For example, many
 projects need small domain-specific languages for system configuration
 tasks, for the formulation of business rules, and so on. With Racket a
 programmer can easily create such special-purpose languages. As the first
 section shows, it is easy to reuse existing constructs---e.g.,
 @scheme[define] or @scheme[lambda]---and it is equally easy to modify
 others---e.g., function application. The Racket code base comes with 40
 such special-purpose languages. A financial company may create languages
 for formulating financial contracts @margin-note*{See Peyton Jones, Eber,
 Seward. @emph{Composing contracts: an adventure in financial engineering.}
 Intern. Conf. Funct. Progr. 2000.} and a language for creating such
 contracts from a GUI; the overall system may then use Racket or Typed
 Racket to dynamically link and process modules in these languages. 

Here is another example, taking a temporal point of view on system
 development.  During the early stage of a project, programmers benefits
 from prototyping, and that calls for a dynamic, untyped language. As
 everyone knows, such prototypes quickly turn into full-fledged, useful
 applications, and managers call for deployment and maintenance of what was
 once thought of as throw-away code. At this stage, maintainers may wish to
 equip the prototype with additional information in order to reduce
 maintenance cost. Type information is one of the first things that comes
 to mind. But migrating a large project from an untyped language to a typed
 language isn't a simple undertaking. Ideally this should happen on a
 module by module basis and in such a way that each intermediate product
 passes the test suite. In Racket, a programmer conducts such a migration
 in a straightforward manner. He picks a @racketmodname[racket] module and
 changes the language to @racketmodname[typed/racket]. To get this module
 to run, the programmer will have to equip imports from untyped modules
 with types, annotate all function and struct definitions with types, and
 perhaps modify some small pieces of code.

Racket is built for this kind of system building. As mentioned, Racket's
 module system can link modules written in distinct languages into a
 working system. This linking step may introduce problems, however, if
 language creators aren't careful. Every (high level) language---whether it
 is implemented in Racket or some other language---establishes and assumes
 invariants. If these invariants are violated, all hell may break loose.
 Put differently, a language implementor must ensure that the invariants of
 his language remain intact even when a module in this language is linked
 into a multi-lingual system.

@; -----------------------------------------------------------------------------
@section{Safety for Multiple Languages}

@plt[] has solved a number of instances of the multi-language problem. From a
 programmer's perspective, it is best to explain the problem and its
 solution for the linking of Racket and Typed Racket modules.  Most
 programmers will initially use these two languages, and most programmers
 may have encountered a variant of the problem, say, linking Java and C.

The chosen sample system consists of two base modules: one that implements
 a dictionary and a second one that uses the dictionary's functionality to
 count words. Here is the dictionary, implemented in the plain Racket
 language: 
@;
@racketmod[#:file
@tt{dictionary}
racket

(provide in-dictionary?)

(define *dictionary '("cat" "dog" "frog" "zebra"))

(define (in-dictionary? w)
  (member w *dictionary))
]
@;
 During maintenance the second module has been migrated to Typed Racket: 
@;
@racketmod[#:file
@tt{count}
typed/racket

(require/typed "dictionary.rkt" 
               (in-dictionary? (String -> Any)))

(provide count-words)

(: count-words : ((Listof String) -> Natural))
(define (count-words lw)
  (for/fold: ({c  : Natural 0}) ({w lw} #:when (in-dictionary? w))
             (+ c 1)))
]
@;
 Although the details don't matter too much, note that the module's
 @scheme[require] specification assigns a type to the dictionary's 
 lookup function and that the @scheme[for/fold] loop demands type
 specification for the result but not the iteration variable; the latter
 type is inferred from the context.  

Imagine that these two modules must be linked somewhere in the rest of the
 system. Here are two basic scenarios: 
@;
@compare[
@racketmod[#:file
@tt{good}
racket
(require "count.rkt")
(count-words 
  '("tiger" "=" "cat"))]
@; ------------------------------------
@racketmod[#:file
@tt{bad}
racket
(require "count.rkt")
(count-words 
  "tiger = cat")]
@;
]
@;

 Both modules require the @tt{count} module. But, while the module on
 the left uses the @scheme[count-words] function with a list, the one on
 the right applies it to a single string. That is, the module on the right
 violates the type signature of @scheme[count-words], which has been used
 to compile the function. Unless Typed Racket protects all of its exports
 appropriately, such a violation may trigger seg faults, core dumps, bus
 errors, or other painful experiences---all of which shouldn't happen in a
 soundly typed, safe language.

In the case of Typed Racket, we implement this protection with a mechanism
 that generalizes Eiffel's contracts. @margin-note*{Racket comes with the
 most expressive contract notation in the world of programming
 languages. Programmers may impose invariants on first-class functions,
 first-class classes, and other constructs that don't even exist in many
 conventional languages.} When an exported value flows from a Typed Racket
 module to a plain Racket module, its types are translated into contracts
 and these contracts are wrapped around the value. The contracts check at
 run-time that every use of the value in an untyped module proceeds
 according to the original type signature; if not, the contract raises an
 exception, analogous to a run-time exception in Java. Naturally, an
 imported value that flows from plain Racket modules into Typed Racket
 modules calls for the same kind of protection. Typed Racket therefore
 requires type specifications for such imports, and of course, these type
 specifications also become contract wrappers at run-time.  As a result, a
 system that consists of Racket and Typed Racket modules is completely
 safe, and the linking is extremely smooth.

To summarize, the creation of a safe language demands a lot of attention
 from the language designer. First, it demands a thorough understanding of
 the invariants that a language should come with. Second, it calls for a
 prediction as to where modules in this language will be used so that the
 language can be equipped with mechanism that enforces the invariants in
 all contexts.  Providing support for the creation of such enforcement
 mechanisms is one of the research themes of @plt[].

@; -----------------------------------------------------------------------------
@section{Languages and Research}

Racket is a stable programming language that has found many uses in
 commercial contexts, open source projects, and educational settings. Typed
 Racket is a carefully crafted complement to Racket. It is as type-safe as
 any modern language, and it protects its modules from all potential abuses
 by untyped clients.  The Racket download package comes with several other
 languages that provide the same level of integrity guarantees as Typed
 Racket. The most prominent examples are 
@;
 the Insta language for web servlets;
@;
 Redex, a modeling language;
@;
 SlideShow, a presentation language; 
@;
 Scribble, a type setting language;@margin-note*{This document is
 programmed in Scribble. When the program is run, it produces this web
 page. To ensure that Racket lives up to its promises, the program
 evaluates the interactions and examples in the preceding sections. In
 other words, the displayed results in a Scribble program always match what
 the program produces.}
@;
 and FrTime, a dataflow language.  
@;
 All of these languages interact safely with Racket programs and vice
 versa. 

At the same time, Racket is also a research platform for @plt[]. Some of the
 research projects are conventional and could be carried out in the context
 of any modern language. For example, we have conducted research on garbage
 collection and type systems for recursively linked, first-class modules;
 we have created automated support for modeling mathematical reduction
 systems; and we have conducted research on web programming and data-flow
 programming. Currently, we are extending our contract system to cope with
 first-class classes; equipping Racket with mechanisms for performing
 computations in parallel; expanding Typed Racket's implementation to take
 advantage of types during compilation.  While the Racket code base greatly
 facilitates these projects, it isn't essential to them. Assuming
 sufficiently strong outside forces, we could conduct this kind of work on
 top of several other platforms and @emph{our results apply to these other
 platforms}.

Two of our efforts are unconventional in that they concern Racket as a
 programming language for programming languages. Both efforts aim to
 increase the potential of linguistic reuse.  The first line of research is
 about linguistic constructs for the creation of languages. For example, a
 recently completed Northeastern dissertation proposes and explores novel
 constructs for formulating syntactic rewriting rules and tools for tracing
 their execution. One current projects concerns tools for equipping
 special-purpose languages with optimizing compilers when needed. The
 second line of research concerns language interoperability. One of @plt[]'s
 theoretical dissertations---completed at the University of Chicago---lays
 the foundations of language interoperability. The dissertation on Typed
 Racket turned some of these ideas into one practical instance. In the near
 future we expect to execute a similar program for the integration of
 Racket with Lazy Racket. The goal is to learn enough so that we can
 formulate guidelines for making languages safe; extend Racket with
 constructs that help doing so; and to create tools that help working
 programmers apply these ideas to their own creations.

@bold{Acknowledgment} Thanks to Shriram Krishnamurthi for the idea of
 illustrating the creation of languages with @tt{pseudo-lazy}, and thanks
 to him, Matthew Flatt, and Robby Findler for discussions of the initial
 draft. Thanks to Vincent St-Amour, Sam Tobin-Hochstadt, and Neil Van Dyke
 for additional comments. 

@bold{Additional Readings}

Danny Yoo, @hyperlink["http://hashcollision.org/brainfudge/"]{Brainfudge, or
How to Produce a Language Without Parentheses in Racket}

Ryan Culpepper,
@hyperlink["http://www.ccs.neu.edu/scheme/pubs/#dissertation-culpepper"]{Refining
Syntactic Sugar: Tools for Supporting Macro Development }

Sam Tobin-Hochstadt,
@hyperlink["http://www.ccs.neu.edu/scheme/pubs/#dissertation-tobin-hochstadt"]{Typed
Racket: From Scripts to Programs}

Jacob Matthews,
@hyperlink["http://plt.eecs.northwestern.edu/diss.html"]{The Meaning of
Multi-language Programs} 

Greg Cooper,
@hyperlink["http://www.cs.brown.edu/~greg/thesis.pdf"]{Integrating Dataflow
Evaluation into a Practical Higher-Order Call-by-Value Language} 
