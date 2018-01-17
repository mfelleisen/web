#lang scribble/manual

@;  "information.rkt" "../info-syllabus.rkt" 
@(require "shared.rkt")
@;(require (except-in "7480-s17-bib.rkt" bibliography cite))

@margin-note*{@image["Images/penguin-cymbal.png" #:scale .5]{time to wake up}}

@title[#:tag ""]{History of Programming Languages}

In this seminar course, we will study themes in the history of programming
 languages. The primary goal is to understand (some of) the discipline as
 it exists today and how some of its major themes evolved. Initially, the
 seminar will focus on themes that NUPRL faculty members have developed
 over the many decades of their careers. The choice of other themes will
 depend on students' interests and preferences.

The secondary goal is to develop basic skills for understanding and
 describing research themes. Every student will learn to study a theme via
 a series of papers, prepare an annotated bibliography, and present the key
 steps in the evaluation of the theme. 

The intended audience consists of PhD students who will write a
 dissertation in the area and MS students who wish to obtain a degree
 ``with thesis.'' Students at all stages of writing will benefit. Someone
 close to the writing stage will have a chance to develop the bibliography
 for the chapter on background work; students at an early stage can use
 this opportunity to find, or to refine, an idea for a dissertation area. 

@; -----------------------------------------------------------------------------
@section[#:tag "org"]{General}

@subsection{Day, Time & Place}

@tabular[ #:sep @hspace[5]
 @list[ 
  @list[ @list{Days}  @list{Tuesday, Friday}    ]
  @list[ @list{Time}  @list{9:50 am - 11:30 am} ]
  @list[ @list{Place} @list{Snell Library 017}  ] ]]

@subsection{Expectations} 

Every student will present two themes. 

The development of a theme proceeds in three stages. First, you must
articulate an interest in several well-defined themes. Usually, interest in
three to four themes suffices for the course. For sample topics
see the topic column in the professor portion of the @secref{lectures}
section. You may want to focus yours a bit more. 

You will jointly decide with the instructor what to present. 

Second, you will develop a summary (three to five paragraphs) and a
bibliography for each theme. Based on these materials, you will then
formulate an outline for a 90-minute lecture (2x 45 mins) and get it
"blessed" by the instructor.

Third, you will deliver the lecture. Your peers will write structured
reviews on both the content and the delivery. 

@subsection{Due Dates}

@tabular[ 
  #:sep @hspace[5]
  #:row-properties '(bottom-border top)
@list[
 @; -------------------------------------------------------
 @list[ @list{Step}                       @list{Due Date} @list{Mechanics} ]

 @list[ @list{express interest in themes} @list{Jan 13}   @list{email} ]
 @list[ @list{choice of themes/order} 	  @list{Jan 17}   @list{meeting}]
 @list[ @list{chosen articles for topic 1}@list{Jan 20}   @list{email links}]
 @list[ @list{outline, summary of topic 1
 	@newline[] annotated bibliography}@list{Jan 31}   @list{email, meeting}]

 @list[ @list{chosen articles for topic 2}@list{Mar 14}   @list{email links}]
 @list[ @list{outline, summary of topic 2
 	@newline[] annotated bibliography}@list{Mar 21}   @list{email, meeting}]
]]

@subsection{Communication}

I will arrange for massive office hours on the relevant due dates. If you
need to communicate with me on other days, just stop by my office. Even if
I don't have time then, we will agree on some slot. 

My email is @tt{matthias@tt["@"]ccs.neu.edu}. Email to @tt{northeastern.edu} often 
goes into my Junk Mail folder, and I won't see it. 

@; -----------------------------------------------------------------------------
@section[#:tag "lectures"]{Lectures}

@tt["@"] @bold{Students} If you would like to grab dates already, let me know. I
realize that some of you wish to get it over with and some of you want to
delay "it" as much as possible. Now is your chance. 

@(define dates 
  '("Jan 10"
    "Jan 13"
    "Jan 17"
    "Jan 20"
    "Jan 24"
    "Jan 27"
    "Jan 31"
    "Feb 03"
    "Feb 07"
    "Feb 10"
    "Feb 14"
    "Feb 17"
    "Feb 21"
    "Feb 24"
    "Feb 28"
    "Mar 02"
    "Mar 14"
    "Mar 17"
    "Mar 21"
    "Mar 24"
    "Mar 28"
    "Mar 31"
    "Apr 04"
    "Apr 07"
    "Apr 11"
    "Apr 14"
    "Apr 18"
    "Apr 21"))

@(define topics 
   @list[
    @list{Andrew Cobb}	     @list{Automatic Differentiation}
   ])

@(define speaker-topics
@; ---------------------------------------------------------------------------------------------------------------
 @list[
   @list[ "Jan 10" @list{---}                @list{Organization Session}                    @list{org}]
   @list[ "Jan 13" @list{Matthias Felleisen} @list{Full Abstraction: From PCF to SPCF}	    @list{fa}]
   @list[ "Jan 17" @list{Jan Vitek}          @list{From Encapsulation to Ownership} 	    @list{own}]
   @list[ "Jan 20" @list{Will Clinger}       @list{Garbage Collection vs Manual Allocation} @list{gc}]
   @list[ "Jan 24" @list{Olin Shivers}       @list{Higher-order Flow Analysis}              @list{olin}]
   @list[ "Jan 27" @list{Amal Ahmed}         @list{Logical Relations:
   	       	   	      		     		     Stepping Beyond Toy Languages} @list{lr}]
   @list[ "Jan 31" @list{Tony Garnock-Jones} @list{Conversational Context & Concurrency}    @list{conc}]
   @list[ "Feb 02" @list{Matthias Felleisen} @list{Programming Languages and Calculi}       @list{redex}]
   @list[ "Feb 07" @list{Ben Greenman}       @list{Datalog for Static Analysis}             @list{datal}]
   @list[ "Feb 10" @list{Jan-W. Van De Meent}@list{Probably Something}                      @list{probpl}]
   @list[ "Feb 14" @list{Daniel Patterson}   @list{Linear Types for Low-level Languages}    @list{linear} ]
   @list[ "Feb 17" @list{Ming-Ho Yee}        @list{Tracing JITs for Dynamic Languages}      @list{mhy1}]
   @list[ "Feb 21" @list{Mitch Wand}         @list{Analysis-Based Program Transformation}   @list{transf}]
   @list[ "Feb 24" @list{Rob Kleffner}       @list{Type Inference in Stack-based @newline[] 
   	       	   	     		     		       Programming Languages}       @list{stackpl}]
   @list[ "Feb 28" @list{Frank Tip}          @list{Refactoring}                             @list{conc-bug}]
   @list[ "Mar 02" @list{no class} @list{  } ]
   @list[ "Mar 14" @list{nobody}             @list{snow day}]
   @list[ "Mar 17" @list{Oli Flückiger}      @list{From PE to a JITs}                       @list{olif1}]
   @list[ "Mar 21" @list{Max New}            @list{Categorical Semantics of @newline[] Untyped Languages} @list{max}] 
   @list[ "Mar 23" @list{Leif Andersen}      @list{Typed Directed Compilation}		    @list{tdc}]
   @list[ "Mar 28" @list{William Bowman}     @list{Type-directed Compilation @newline[]
   	       	   		 	     		with Dependent Types}               @list{tdc-dep}]
   @list[ "Mar 30" @list{Kevin Clancy}       @list{Refinement Types}                        @list{refinement}]
   @list[ "Apr 04" @list{Sam Caldwell}       @list{Functional Reactive Programming}         @list{frp}]
   @list[ "Apr 06" @list{all}                @list{Type Soundness for Real-world Developers} ]
   @list[ "Apr 11" @list{F. Zappa Nardelli}  @list{No good answers (2): Shared Memory @newline[] Concurrency and Language Designs} @list{conc2}]
   @list[ "Apr 13" @list{Ben Greenman}       @list{Soft Typing}  @list{soft} ]
   @list[ "Apr 18" @list{Ben Chung}          @list{No good answers: 
   	       	   	     		         Gradually typed @newline[]
						 object-oriented languages} @list{gt}]
   @list[ "Apr 20" @list{profs}              @list{For better or worse} ]
  ]
)

@(define (summary speaker #:second (take-second #f))
  (define (speaker-topics-title speaker)
    (define (in? x)
      (define it? (regexp-match speaker (car x)))
      (cond 
	[(and it? take-second-one) (set! take-second-one #f) #f]
	[it? it?]
	[else #f]))
    (cadr (assf in? (map cdr speaker-topics))))

  (define (speaker-topics-tag speaker)
       (define (in? x)
	 (define it? (regexp-match speaker (car x)))
	 (cond 
	   [(and it? take-second-one) (set! take-second-one #f) #f]
	   [it? it?]
	   [else #f]))
       (define tag (cddr (assf in? (map cdr speaker-topics))))
       (if (null? tag) #f (car tag)))

  (define take-second-one take-second)
  (define t @speaker-topics-tag[speaker])

  (set! take-second-one take-second)
  (define s @speaker-topics-title[speaker])

  @subsection[#:tag t]{@s})

@(define *err (current-error-port))
@(define (tee x)
   (displayln x *err)
   x)

@tabular[ 
  #:sep @hspace[5]
  #:row-properties '(bottom-border top)
@cons[
 @list[ @list{Date}   @list{Speaker} @list{Topic} ]
 @; -----------------------------------------------
 @(for/list ([y dates][z speaker-topics])
    (if (null? (cdddr z))
        @list[y (cadr z) (caddr z)]
        @list[y (cadr z) @secref{@(caaddr (cdr z))}]))
]]

@; -----------------------------------------------------------------------------
@section{Summary & Materials}

This page will list students' summaries and (links to) reading materials. 

@; -----------------------------------------------------------------------------
@summary{Matthias}

Robin Milner. Fully abstract models of typed lambda calculi.
@link["http://www.sciencedirect.com/science/article/pii/0304397577900536"]{Theoretical
Computer Science, 4(1), February 1977, pages 1-22.}

Gordon Plotkin. LCF considered a programming language. 
@link["http://www.sciencedirect.com/science/article/pii/0304397577900445"]{Theoretical
Computer Science, 5(3), December 1977, pages 223-256.}

Gerard Berry and Pierre-Louis Curien. Sequential algorithms on concrete data structures. 
@link["http://www.sciencedirect.com/science/article/pii/S0304397582800029"]{Theoretical 
Computer Science, 20(3), July 1982, pages 265-321.}

Robert Cartwright, Pierre-Louis Curien, Matthias Felleisen. 
@link["http://www.sciencedirect.com/science/article/pii/S0890540184710479"]{Information
and Computation, 111(2), June 1994, pages 297-401.}

@summary[#:second #t]{Matthias}

Gordon Plotkin. 
Call-by-name, call-by-value, and the lambda calculus.
@link["http://www.sciencedirect.com/science/article/pii/0304397575900171"]{Theoretical
Computer Science, 1975, pages 125-159.} 

Matthias Felleisen, Daniel Friedman, Eugene Kohlbecker, and Bruce Duba. 
Reasoning with continuations. 
Logic in Computer Science, 1986, pages 314-325. (I cannot find an on-line
link.) 

Matthias Felleisen, Daniel Friedman.
Control operators, the SECD machine and the lambda calculus. 
@link["https://www.cs.indiana.edu/ftp/techreports/TR197.pdf"]{Formal
Description of Programming Concepts, 1986, pages 193-217.} 

Matthias Felleisen, Daniel Friedman.
A calculus of assignments in higher-order languages. 
@link["http://dl.acm.org/citation.cfm?doid=41625.41654"]{Principles of
Programming Languages, 1986, pages 314-325}  

Matthias Felleisen, Robert Hieb. 
A calculus of assignments in higher-order languages. 
@link["http://www.sciencedirect.com/science/article/pii/0304397592900147"]{Theoretical
Computer Science, 1992, pages 235-271}  

@; -----------------------------------------------------------------------------
@summary{Jan}

John C. Reynolds. Syntactic control of interference. 
@link["http://dl.acm.org/ft_gateway.cfm?id=512766&ftid=71348&dwn=1&CFID=887254127&CFTOKEN=27281994"]{Principles
of Programming Languages, 1978, pages 39-46.}

John Hogg. Islands: aliasing protection in object-oriented languages. 
@link["http://dl.acm.org/ft_gateway.cfm?id=117975&ftid=29239&dwn=1&CFID=887254127&CFTOKEN=27281994"]{Object-oriented 
Programming Systems Languages and Applications, 1991, pages 271-285.}

David G. Clarke, John M. Potter, and James Noble. 
Ownership types for flexible alias protection. 
@link["http://dl.acm.org/citation.cfm?id=286947"]{Object-oriented 
Programming Systems Languages and Applications, 1998, pages 48-64.}

Christian Grothoff, Jens Palsberg, and Jan Vitek. 
Encapsulating objects with confined types. 
@link["http://dl.acm.org/ft_gateway.cfm?id=1286823&ftid=475808&dwn=1&CFID=887254127&CFTOKEN=27281994"]{Transactions
on Programming Languages and Systems, 29(6), October 2007.}

@; -----------------------------------------------------------------------------
@summary{Will}

Henry Lieberman and Carl Hewitt.
A real-time garbage collector based on the lifetimes of objects.
@link["http://web.media.mit.edu/~lieber/Lieberary/GC/Realtime/Realtime.html"]{MIT
version} @link["http://dl.acm.org/citation.cfm?id=358147"]{Communications of the
ACM, Volume 26 Issue 6, June 1983, pages 419-429.} 

Benjamin Zorn.
The measured cost of conservative garbage collection.
University of Colorado at Boulder Technical Report CU-CS-573-92.
April, 1992.
@link["ttp://www.cs.colorado.edu/department/publications/reports/docs/CU-CS-573-92.pdf"]{TR}
@link["http://dl.acm.org/citation.cfm?id=160993"]{Software---Practice &
Experience, Volume 23 Issue 7, July 1993, pages 733-756.}

William D Clinger and Lars Hansen.  Generational garbage collection and the
radioactive decay model.  In the
@link["http://www.cesura17.net/~will/Professional/Research/Papers/radioactive.pdf"]{Proceedings
of the 1997 ACM Conference on Programming Language Design and
Implementation, June 1997, pages 97-108.}

William D Clinger and Fabio V Rojas.
Linear combinations of radioactive decay models for generational
garbage collection.
In @link["http://dx.doi.org/10.1016/j.scico.2006.02.005"]{Science of
Computer Programming, Volume 62, Issue 2, 1 October 2006, pages 184-203.}

Felix S Klock II and William D Clinger.
Bounded-latency regional garbage collection.
@link["http://www.cesura17.net/~will/Professional/Research/Papers/boundedLatencyGC.pdf"]{Proceedings
of the 2011 Dynamic Languages Symposium (DLS 2011), 24 October 2011, pages 73-83.}

@; -----------------------------------------------------------------------------
@summary{Olin}

@summary{Amal}

Andrew Pitts and Ian Stark.
Operational reasoning for functions with local state.
@link["http://homepages.inf.ed.ac.uk/stark/operfl.pdf"]{Higher-Order
Operational Techniques in Semantics (HOOTS ’98), 1998, pages 227-274.} 

Andrew Appel and David McAllester. 
An indexed model of recursive types for foundational proof-carrying code. 
@link["http://delivery.acm.org/10.1145/510000/504712/p657-appel.pdf?ip=72.92.233.181&id=504712&acc=AUTHOR%2DIZED&key=4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E55350B711228B17F&CFID=722404099&CFTOKEN=79199995&__acm__=1485755598_2a4b4d38248fc00b8e5bcbea2ba578a7"]{ACM
Transactions on Programming Languages and Systems 23 (5), September 2001,
pages 657-683.} 

Amal Ahmed.
Semantics of Types for Mutable State.  Ch. 2, 3, 4.
@link["http://www.ccs.neu.edu/home/amal/ahmedsthesis.pdf"]{Ph.D. thesis,
Princeton University, Princeton NJ, Nov. 2004. Tech Report TR-713-04.}

Amal Ahmed.
Step-indexed syntactic logical relations for recursive and quantified types.
@link["http://www.ccs.neu.edu/home/amal/papers/lr-recquant.pdf"]{European
Symposium on Programming (ESOP '06), March 2006, pages 69-83.} 

Amal Ahmed, Derek Dreyer, and Andreas Rossberg.
State-Dependent Representation Independence.
@link["http://www.ccs.neu.edu/home/amal/papers/sdri.pdf"]{Principles of
Programming Languages (POPL '09), January 2009, pages 340-353.}

@; -----------------------------------------------------------------------------
@summary{Mitch}


Olin Shivers. The Semantics of Scheme Control-Flow Analysis.
@link["http://dl.acm.org/citation.cfm?doid=115865.115884"]{Conference on Programming Language Design and
Implementation, June, 1991, pages 190-198.}

Mitch Wand and Paul Steckler. Selective and Lightweight Closure Conversion.
@link["http://dl.acm.org/citation.cfm?doid=174675.178044"]{Conference on Principles of Programming Languages,
January, 1994, pages 435-445.} 

Mitch Wand and Igor Siveroni. Constraint Systems for Useless Variable Elimination. 
@link["http://doi.acm.org/10.1145/292540.292567"]{Conference on Principles of Programming Languages,
January, 1999, pages 291-302.} 

Mitch Wand and Will Clinger. Set Constraints for Destructive Array Update Optimization. 
@link["http://ieeexplore.ieee.org/document/674169/"]{International Conference on Computer Languages, 1998, pages
184--195.} 

Christos Dimoulas and Mitch Wand. The Higher-order Aggregate Update
Problem. @link["http://dx.doi.org/10.1007/978-3-540-93900-9_8"]{Verification, Model Checking, and Abstract
Interpretation, 2009, pages 44-58.}

@; -----------------------------------------------------------------------------
@summary{Kevin}

Noam Zeilberger.
Principles of type refinement.
@link["http://noamz.org/oplss16/refinements-notes.pdf"]{Lectures
Notes. Oregon Programming Language Summer School, 2016.}

Freeman, Tim, and Frank Pfenning.
Refinement types for ML.
@link["https://www.cs.cmu.edu/~fp/papers/pldi91.pdf"]{Programming Language
Design and Implementation, 1991, pages 268-277.}

Xi, Hongwei, and Frank Pfenning. 
Dependent types in practical programming. 
@link["https://www.cs.cmu.edu/~fp/papers/popl99.pdf"]{Principles of
Programming Languages, 1999, pages 214-227.} 

Flanagan, Cormac. 
Hybrid type checking.
@link["http://dl.acm.org/citation.cfm?id=1667051"]{Transactions on 
Programming Languages, 2010, 32(6), pages 1-34.}

Xi, Hongwei.
Dependent ML: an approach to practical programming with dependent types.
@link["http://www.cs.bu.edu/~hwxi/academic/papers/JFPdml.pdf"]{Journal of
Functional Programming. 17(2): 215-286, 2007.}

Rondon, Patrick M., Ming Kawaguci, and Ranjit Jhala.
Liquid Types.
@link["http://goto.ucsd.edu/~rjhala/liquid/liquid_types.pdf"]{Programming Language
Design and Implementation, 2008, pages 158-169.}

@; -----------------------------------------------------------------------------
@summary{Leif}

Xavier Leroy. Unboxed objects and polymorphic typing.
@link["http://gallium.inria.fr/~xleroy/publi/unboxed-polymorphism.pdf"]{Principles of Programming Languages,
1992, pages 177-188.}

Greg Morrisett. Compiling with types. 

Xavier Leroy. An overview of Types in Compilation. 
@link["x"]{Workshop Types in Compilation, Lecture Notes in Computer Science, 1998, pages ??.}

Greg Morrisett and Robert Harper. Typed Closure Conversion for Recursively-Defined Functions.
@link["http://www.sciencedirect.com/science/article/pii/S1571066105807029"]{Electronic Notes in Theoretical
Computer Science, 1998, 10, pages 230-241.}

David Tarditi, Greg Morrisett, Perry Cheng,. Chris Stone, Bob Harper. and Peter Lee.
TIL: A Type-Directed Optimizing Compiler for ML.
@link["http://doi.acm.org/10.1145/231379.231414"]{Programming Language Design and Implementation, 1996, pages
181-192.}

@; -----------------------------------------------------------------------------
@summary{William}

George Necula and Peter Lee. The design and implementation of a certifying compiler.
@link["y"]{Programming Languages and Implementation, 1998, pages 333--344.}

Gilles Barthe, John Hatcliff, and  Morten Heine B Sorensen. CPS translations and applications: the cube and
 beyond. 
@link["z"]{Higher-Order and Symbolic Computation, 1999, 12(2), pages 125--170.}

Hongwei Xi and Robert Harper. A Dependently Typed Assembly Language.
@link["http://doi.acm.org/10.1145/507635.507657"]{International Conference on Functional Programming, 2001, pages
169--180.} 

Hugo Herbelin. On the degeneracy of $\Sigma$-types in presence of computational classical logic. 
@link["w"]{International Conference on Typed Lambda Calculi and Applications, 2005, pages 209--220.}

Juan, Chen, Ravi Chugh, and Nikhil Swamy.
Type-preserving Compilation of End-to-end Verification of Security Enforcement.
@link["http://doi.acm.org/10.1145/1806596.1806643"]{Programming Language Design and Implementation, 2010, 
 pages 412--423.}

@; -----------------------------------------------------------------------------
@summary{Frank}

Frank Tip, Adam Kiezun, Dirk Bäumer.
Refactoring for generalization using type constraints. 
@link["http://dl.acm.org/citation.cfm?id=949308"]{OOPSLA 2003, pages 13-26.}
 
Robert M. Fuhrer, Frank Tip, Adam Kiezun, Julian Dolby, Markus Keller.
Efficiently refactoring java applications to use generic libraries. 
@link["http://dl.acm.org/citation.cfm?id=2144898"]{ECOOP 2005, pages 71-96.}
 
Max Schäfer, Torbjörn Ekman, Oege de Moor.
Sound and extensible renaming for Java.
@link["http://dl.acm.org/citation.cfm?id=1449787"]{ OOPSLA 2008, pages 277-294.}
 
Friedrich Steimann, Andreas Thies.
From public to private to absent: Refactoring Java programs under
constrained accessibility.
@link["http://link.springer.com/chapter/10.1007/978-3-642-03013-0_19"]{ECOOP
2009, pages 419-443.} 
 
Max Schäfer, Andreas Thies, Friedrich Steimann, Frank Tip.
A comprehensive approach to naming and accessibility in refactoring Java programs.
@link["http://ieeexplore.ieee.org/document/6152131/"]{IEEE Trans. Software
Eng. 38(6), 2012, pages 1233-1257.}  

@; -----------------------------------------------------------------------------
@summary{Tony}

P. Brinch Hansen. Monitors and Concurrent Pascal: a personal history. 
@link["http://dl.acm.org/citation.cfm?id=155361"]{History of Programming Languages II. SIGPLAN Notices, 1993, 28(3), pages 1--35.} 
@link["http://thecorememory.com/MonConPas.pdf"]{(also available here)}

C. Hewitt, P. Bishop, and R. Steiger. A universal modular ACTOR formalism for artificial intelligence.
@link["https://eighty-twenty.org/files/Hewitt,%20Bishop,%20Steiger%20-%201973%20-%20A%20universal%20modular%20ACTOR%20formalism%20for%20artificial%20intelligence.pdf"]{International Joint Conference on Artificial Intelligence, 1973, pages 235–245.}
@link["http://ijcai.org/Proceedings/73/Papers/027B.pdf"]{(also available here)}

G. A. Agha.  Actors: a model of concurrent computation in distributed systems.
@link["https://dspace.mit.edu/bitstream/handle/1721.1/6952/AITR-844.pdf"]{Technical Report 844. MIT Artificial Intelligence Laboratory, June 1985.}

@; http://www.cypherpunks.to/erights/history/actors/AITR-844.pdf

C. Fournet and G. Gonthier. The join calculus: a language for distributed mobile programming.
@link["http://research.microsoft.com/en-us/um/people/fournet/papers/join-tutorial.pdf"]{Applied Semantics Summer
School, September 2000, Caminha, Portugal.} 

N. J. Carriero, D. Gelernter, T. G. Mattson, and A. H. Sherman. The
Linda alternative to message-passing systems. 
@link["http://heather.miller.am/teaching/cs7680/pdfs/Linda-Alternative-to-Message-Passing.pdf"]{ Parallel Comput., 20(4) pages 633--655, 1994.}

@; -----------------------------------------------------------------------------
@summary{Rob}

J. Poial. Algebraic specification of stack effects. 
@link["https://www.academia.edu/22579532/Algebraic_Specification_of_Stack_Effects._Forth_Dimensions_Vol_XVI_18_20"]{Forth
Dimensions, XVI(18_20).}

J. Poial. Multiple stack effects for Forth programs. 
@link["https://www.kodu.ee/~jpoial/teadus/EuroForth91_Multiple.pdf"]{Euro Forth 1991}

B. Stoddart & P.J. Knaggs. Type inference in stack based languages. 
@link["http://www.rigwit.co.uk/papers/fac-type.pdf"]{Formal Aspects of Computing, 1992, pages 1-11.}

C. Okasaki. Techniques for embedding post-fix languages in Haskell. 
@link["https://github.ccs.neu.edu/robkleffner/research/blob/master/literature/Technique%20for%20Embedding%20Postfix%20Languages%20in%20Haskell.pdf"]{cite
4}

C. Diggins. Typing functional stack based languages. 
@link["https://www.researchgate.net/publication/228985001_Typing_Functional_Stack-Based_Languages"]{Unpublished
manuscrtip, 2007.}

A. Saabas & T. Uustalu. Type systems for optimizing stack-based code. 
@link["http://set.ee/publications/bytecode07.pdf"]{Byte Code, 2007, pages 1-16.} (See Electronic Notes in
Theoretical Computer Science.)

@; -----------------------------------------------------------------------------

@; -----------------------------------------------------------------------------
@summary{Ming-Ho}

Vasanth Bala, Evelyn Duesterwald, and Sanjeev Banerjia.
Dynamo: a transparent dynamic optimization system.
@link["https://doi.org/10.1145/349299.349303"]{Programming Language Design
 and Implementation, 2000, pages 1-12.}

Andreas Gal and Michael Franz
Incremental dynamic code generation with trace trees.
@link["https://www.cs.montana.edu/ross/classes/fall2009/cs550/resources/Tracemonkey-01.pdf"]{ Technical Report
ICS-TR-06-16, University of California, Irvine, 2006.}

Andreas Gal, Brendan Eich, Mike Shaver, David Anderson, David Mandelin, Mohammad R. Haghighat, Blake Kaplan,
Graydon Hoare, Boris Zbarsky, Jason Orendorff, Jesse Ruderman, Edwin Smith, Rick Reitmaier, Michael Bebenita,
Mason Chang, and Michael Franz.
Trace-based just-in-time type specialization for dynamic languages.
@link["https://doi.org/10.1145/1542476.1542528"]{Programming Language Design
 and Implementation, 2009, pages 465-478.}

Carl Friedrich Bolz, Antonio Cuni, Maciej Fijałkowski, and Armin Rigo.
Tracing the meta-level: PyPy's tracing JIT compiler.
@link["https://doi.org/10.1145/1565824.1565827"]{Implementation, Compilation, Optimization of Object-Oriented
Languages and Programming Systems, 2009, pages 18-25.}

Michael Bebenita, Florian Brandner, Manuel Fahndrich, Francesco Logozzo, Wolfram Schulte, Nikolai Tillmann, and
Herman Venter.
SPUR: a trace-based JIT compiler for CIL.
@link["https://doi.org/10.1145/1869459.1869517"]{Object-Oriented Programming, Systems, Languages and Applications
 2010, pages 708-725.}

Håkan Ardö, Carl Friedrich Bolz, and Maciej Fijałkowski
Loop-aware optimizations in PyPy's tracing JIT.
@link["https://doi.org/10.1145/2384577.2384586"]{Dynamic Languages Symposium (DLS), 2012, 
pages 63-72.}

@; -----------------------------------------------------------------------------
@summary{Oli F}

Gregory T. Sullivan.
Dynamic partial evaluation. 
@link["http://dl.acm.org/citation.cfm?id=668117"]{Programs as Data
Objects. Springer Berlin Heidelberg, 2001. 238-256.} 

Carl Friedrich Bolz, Antonio Cuni, Maciej Fijałkowski, and Armin Rigo.
Tracing the meta-level: PyPy's tracing JIT compiler.
@link["https://doi.org/10.1145/1565824.1565827"]{Implementation, Compilation, Optimization of Object-Oriented
Languages and Programming Systems, 2009, pages 18-25.}

Thomas Würthinger, Christian Wimmer, Andreas Wöß, Lukas Stadler,
Gilles Duboscq, Christian Humer, Gregor Richards, Doug Simon, Mario Wolczko.
One VM to rule them all.
@link["http://dl.acm.org/citation.cfm?doid=2509578.2509581"]{Onward! New
Ideas, New Paradigms, and Reflections on Programming & Software, 2013, pages
187-204.}

@;{
Umeshwar Dayal and  Philip A. Bernstein. 
On the correct translation of update operations on relational views.
@link["https://dl.acm.org/citation.cfm?id=319740"]{Transactions on Database Systems, 1982.} 

P. Wadler.
Views: a way for pattern matching to cohabit with data abstraction
@link["http://www.cs.tufts.edu/~nr/cs257/archive/views/wadler.pdf"]{Principles of Programming Languages, 1987.} 

Atsushi Ohori and Tajima, Keishi.
A polymorphic calculus for views and object sharing.
@link["http://www.pllab.riec.tohoku.ac.jp/~ohori/research/pods94.pdf"]{Principles of Database Systems (PODS),
1994.} 

Michael B. Greenwald, Jonathan T. Moore, Benjamin C. Pierce, Alan Schmitt, and Nate Foster.
A language for bi-directional tree transformations.
@link["https://pdfs.semanticscholar.org/1138/0438de98f4625a491da253315466d5c34218.pdf"]{Technical Report
MS-CIS-03-08, 2003.} 

J. Nathan Foster, Michael B. Greenwald, Jonathan T. Moore,  Benjamin C. Pierce, and Alan Schmitt.
Combinators for bi-directional tree transformations---A linguistic approach to the view update problem. 
@link["https://www.cis.upenn.edu/~bcpierce/papers/newlenses-popl.pdf"]{Principles of Programming Languages, 2005.}  

Davi M. J. Barbosa, Julien Cretin, Nate Foster, Michael Greenberg, Benjamin C. Pierce.
Matching Lenses: Alignment and View Update
@link["https://www.cs.cornell.edu/~jnfoster/papers/matching-lenses.pdf"]{International Conference on Programming
Languages,  2010.} 

}

@;{
@summary[#:second #t]{Oli F}

Yoshihiko Futamura.
Partial computation of programs.
@link["http://repository.kulib.kyoto-u.ac.jp/dspace/bitstream/2433/103401/1/0482-14.pdf"]{Mathematical Methods in
Software Science and Engineering, 3, 1983, 255-295.}

Neil Jones, Peter Sestoft, and Harald Søndergaard.
Mix: a self-applicable partial evaluator for experiments in compiler generation.
@link["http://www.cs.tufts.edu/~nr/cs257/archive/neil-jones/mix-partial-evaluator.pdf"]{Lisp and Symbolic
Computation 2(1), (1989), pages 9-50.} 

Peter Lee and Mark Leone.
Optimizing ML with run-time code generation.
@link["https://pdfs.semanticscholar.org/4587/7b0d6999dd9b6d3a92d96571b61b503730c5.pdf"]{Programming Languages
Design and Implementation, 1996, pages 137-148.}

Carl Friedrich Bolz, Antonio Cuni, Maciej Fijalkowski, Armin Rigo.
Tracing the meta-level: PyPy's tracing JIT compiler.
@link["http://stups.hhu.de/mediawiki/images/1/18/Pub-BoCuFiRi09_246.pdf"]{Implementation, Compilation,
Optimization of Object-Oriented Languages and Programming Systems, 2009, pages 18-25.} }

@; -----------------------------------------------------------------------------
@summary{Green}

Stefano Ceri, Georg Gottlob, and Letizia Tanca. 
What you always wanted to know about datalog (and never dared to ask).
@link["http://www.csd.uoc.gr/~hy562/1112_spring/instr_material/WhatYouAlwaysWantedtoKnowAboutDatalog_AndNeverDaredtoAsk.pdf"]{IEEE
Transactions on Knowledge and Data Engineering, 1989.}

Aβman, Uwe.
On edge addition rewrite systems and their relevance to program analysis.
@link["http://dl.acm.org/citation.cfm?id=668694"]{International
Workshop on Graph Gramars and Their Application to Computer Science, 1994, 
pages 321-335}

Thomas Reps
Demand interprocedural program analysis using logic databases.
@link["http://link.springer.com/chapter/10.1007%2F978-1-4615-2207-2_8"]{Application
of Logic Databases, 1995, pages 163-196.} 

Monica Lam, John Whaley, V. Benjamin Livshits, Michael C. Martin, Dzintars Avots, Michael Carbin, Christopher Unkel.
Context-sensitive program analysis as database queries.
@link["http://dl.acm.org/citation.cfm?id=1065169"]{Principles of Database
Systems, 2005,pages 1-12.}

Martin Bravenboer and Yannis Smaragdakis
Strictly declarative specifications of sophisticated points-to analyses.
@link["http://dl.acm.org/citation.cfm?id=1640108&dl=ACM&coll=DL&CFID=889273679&CFTOKEN=74570083"]{
Object Oriented Programming Systems Languages and Applications, 2009, pages 243-262.}

@; -----------------------------------------------------------------------------
@summary{Max}

Dana Scott. Relating theories of the lambda calculus. 
@link["https://www.cs.washington.edu/node/7272"]{
To H.B. Curry. Essays on Combinatory Logic, Lambda Calculus and Formalism.
1980, pages 403-450.}

C.P.J. Koymans. Models of the lambda calculus.
@link["http://www.sciencedirect.com/science/article/pii/S0019995882907963"]{
Information and Control, 52(3), 1982, pages 306-332.}

Susumu Hayashi. Adjunctions of semi-functors.
@link["http://dl.acm.org/citation.cfm?id=6587"]{Theoretical Computer Science, 
41(1), 1985, pages 95-104.} 

J. Lambek & P. Scott. Introduction to Higher Categorical Logic.
@link["http://dl.acm.org/citation.cfm?id=7517"]{Cambridge University 
Press, 1986.} 

R. Hoofman & I. Moerdijk. A remark on the theory of semi-functors. 
@link["http://repository.ubn.ru.nl/handle/2066/129066"]{Mathematical 
Structures in Computer Science, 5(1), 1995, pages 1-8.}

@; -----------------------------------------------------------------------------
@summary{Daniel}

Yves Lafont. 
The linear abstract machine. 
@link["http://www.sciencedirect.com/science/article/pii/0304397588901004"]{Theoretical
Computer Science, 59(1–2), 1988, pages 157–180.} 

Henry Baker.
Lively linear Lisp -- “look ma, no garbage!” 
@link[" http://dl.acm.org/citation.cfm?id=142162"]{SIGPLAN Notices, 27(8), 1992,
pages 89 - 98.}

Jawahar Chirimar, Carl A. Gunter, Jon G. Riecke.
Reference counting as a computational interpretation of linear logic. 
@link["https://pdfs.semanticscholar.org/7497/fe6b73326c62c73e403f7b8dc8bd97df9e89.pdf"]{Journal
of Functional Programming, 6(2), 1996, pages 195-244.}

Martin Hofmann. 
A type system for bounded space and functional in-place update–extended abstract. 
@link["https://www.tcs.ifi.lmu.de/mitarbeiter/martin-hofmann/publikationen-pdfs/c17-typesystemforboundedspace.pdf"]{European
Symposium on Programming, 2000, pages 165-179.}

@;{Amal Ahmed, Matthew Fluet, and Greg Morrisett.
A step-indexed model of substructural state. 
@link["http://www.ccs.neu.edu/home/amal/papers/substruct.pdf"]{ICFP, 2005,
pages 78-91.}}

@; -----------------------------------------------------------------------------
@summary{Jan-W.}

D Wingate, A Stuhlmueller, ND Goodman.
Lightweight implementations of probabilistic programming languages via
transformational compilation. 
@link["http://www.jmlr.org/proceedings/papers/v15/wingate11a/wingate11a.pdf"]{International
Conference on Artificial Intelligence and Statistics, 2011, pages 770-778.} 

Vikash Mansinghka, Daniel Selsam, Yura Perov.
Venture: a higher-order probabilistic programming platform with
programmable inference. 
@link["https://arxiv.org/pdf/1404.0099v1"]{arXiv.}

L Yang, P Hanrahan, ND Goodman.
Generating efficient mcmc kernels from probabilistic programs. 
@link["http://www.jmlr.org/proceedings/papers/v33/yang14d.pdf"]{International
Conference on Artificial Intelligence and Statistics, 2014, pages 1068-1076.}

JW van de Meent, H Yang, V Mansinghka, F Wood.
Particle gibbs with ancestor sampling for probabilistic programs.
@link["http://www.jmlr.org/proceedings/papers/v38/vandemeent15.pdf"]{International
Conference on Artificial Intelligence and Statistics, 2015, pages 986-994.}

D Ritchie, A Stuhlmüller, ND Goodman.
C3: lightweight incrementalized MCMC for probabilistic programs using
continuations and callsite caching. 
@link["http://www.jmlr.org/proceedings/papers/v51/ritchie16.pdf"]{International
Conference on Artificial Intelligence and Statistics, 2016, pages 28-37.}

@; -----------------------------------------------------------------------------
@summary{Sam}

Conal Elliott and Paul Hudak.
Functional reactive animation.
@link["http://dl.acm.org/citation.cfm?id=258973"]{International Conference
on Functional Programming, 1997, pages 263 - 273.}

Zhanyong Wan and Paul Hudak.
Functional reactive programming from first principles.
@link["http://haskell.cs.yale.edu/wp-content/uploads/2011/02/frp-1st.pdf"]{Programming
Language Design And Implementation, 2000, pages 242-252.}

Conal Elliott.
Functional implementations of continuous modeled animation.
@link["http://link.springer.com/chapter/10.1007/BFb0056621"]{International
Symposium on Principles of Declarative Programming, 2006, pages 284-299.}

Gregory H. Cooper and Shriram Krishnamurthi.
Embedding dynamic dataflow in a call-by-value language.
@link["http://cs.brown.edu/people/sk/Publications/Papers/Published/ck-frtime/paper.pdf"]{European
Symposium on Programming Languages and Systems, 2006, pages 294-308.}

@;{
Leo A. Meyerovich, Arjun Guha, Jacob Baskin, Gregory H. Cooper, Michael Greenberg, Aleks Bromfield, and Shriram Krishnamurthi
Flapjax: A Programming Language for Ajax Applications
http://cs.brown.edu/~sk/Publications/Papers/Published/mgbcgbk-flapjax/paper.pdf
OOPSLA '09 Proceedings of the 24th ACM SIGPLAN conference on Object oriented programming systems languages and applications, Pages 1-20
}

@summary[#:second #t]{Green}

@; -----------------------------------------------------------------------------
@summary{Chung}

G. Bierman, E. Meijer, and M. Torgersen.
Adding dynamic types to C#. 
@link["http://link.springer.com/chapter/10.1007/978-3-642-14107-2_5"]{European
Conference on Object-Oriented Programming, 2010, pages 76-100.}

Bard Bloom, John Field, Nathaniel Nystrom, Johan Östlund, Gregor Richards, Rok Strnisa, Jan Vitek, and Tobias Wrigstad. 
Thorn: robust, concurrent, extensible scripting on the JVM.
@link["http://dl.acm.org/citation.cfm?id=1640098"]{Object-oriented
Programming Systems Languages and Applications, 2009, Pages 117-136.}

Esteban Allende, Oscar Callaú, Johan Fabry, Éric Tanter, Marcus Denker.
Gradual typing for Smalltalk. 
@link["http://www.sciencedirect.com/science/article/pii/S0167642313001445"]{In
Science of Computer Programming, 2014, 96(1), pages 52–69.}

Michael M. Vitousek, Andrew M. Kent, Jeremy G. Siek, and Jim Baker. 
Design and evaluation of gradual typing for python. 
@link["http://dl.acm.org/citation.cfm?id=2661101"]{Dynamic Languages
Symposium, 2014, pages 45-56.}

Asumu Takikawa, Daniel Feltey, Ben Greenman, Max S. New, Jan Vitek, and Matthias Felleisen.
Is sound gradual typing dead?.
@link["http://dl.acm.org/citation.cfm?id=2837630"]{Principles of
Programming Languages, 2016, pages 456-468.}

@summary{Zappa}

Leslie Lamport.
How to make a multiprocessor computer that correctly executes multiprocess programs. 
@link["http://dl.acm.org/citation.cfm?id=1311750"]{IEEE Trans. Computers 1979,
28(9): 690-691.}

Hans-Juergen Boehm.
Threads cannot be implemented as a library. 
@link["http://www.hpl.hp.com/techreports/2004/HPL-2004-209.pdf"]{PLDI 2005, 261-268.}

Peter Sewell, Susmit Sarkar, Scott Owens, Francesco Zappa Nardelli, Magnus O. Myreen.
X86-TSO: a rigorous and usable programmer's model for x86 multiprocessors. 
@link["http://dl.acm.org/citation.cfm?id=1785443"]{Commun. ACM  2010, 53(7): 89-97.}

Jaroslav Sevcík.
Safe optimisations for shared-memory concurrent programs. 
@link["http://www.di.ens.fr/~zappa/teaching/mpri/2012/transsafety.pdf"]{PLDI 2011, 306-316.}

Hans-Juergen Boehm, Sarita V. Adve.
Foundations of the C++ concurrency memory model. 
@link["http://www.hpl.hp.com/techreports/2008/HPL-2008-56.html"]{PLDI 2008, 68-78.}

Viktor Vafeiadis, Thibaut Balabonski, Soham Chakraborty, Robin Morisset, Francesco Zappa Nardelli.
Common compiler optimisations are invalid in the C11 memory model and what we can do about it. 
@link["http://dl.acm.org/citation.cfm?id=2676995"]{POPL 2015, 209-220.}
