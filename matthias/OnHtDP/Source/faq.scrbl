#lang scribble/manual

@(require "shared.ss")

@title*[#:tag "what is ts"]{What is @ts}

@date{Aug 15, 2010}

Every few months I encounter people who harbor deep misunderstandings about
the @ts curriculum. I cannot eliminate these misunderstandings in a single
conversation, but I can at least spell them out and address them here. I
did so with a @italic{Little LISPer} style dialog, though it can also be
read as a FAQ list.

(Note: My dialog supplements and does not compete or conflict with 
@hyperlink["http://www.teach-scheme.org/Notes/"]{the section on frequently
asked questions} at our @ts site.)

@q-a[
[@q{Is @ts about Scheme?}
 @a{No, @ts is about the systematic design of programs from the very
 beginning, regardless of programming language.}]

[@q{So why do you use Scheme?}  @a{We don't. The "!" signals @emph{not},
 because we @emph{really} do @emph{not} use Scheme. We also don't use
 Racket, our own language, which is a flavor of LISP and Scheme.}]

[@q{What do you use?}
 @a{We use a series of teaching languages, with each successor a bit more
 expressive than its predecessor. These teaching languages borrow elements
 from Racket, a member of the LISP family of languages. That's why our
 programs use all these parentheses.}]

[@q{Is the @ts idea of design really useful in all kinds of programming
 languages?}

 @a{Yes, it is. Over the years, I have had students who applied the design
 recipe and the design guidelines in all kinds of languages: assembly,
 Python, Perl, Ruby, and Java. Indeed, I know instructors for each of these
 languages who adopted the design recipe for their languages---after
 starting their students on plain @hyperlink["http://www.htdp.org"]{HtDP}.}]

[@q{Okay, so @ts isn't about Scheme. Is it about functional
 programming?}

 @a{No, @ts is about the systematic design of @emph{all} kinds of
 programs. That includes object-oriented and imperative programs.}]

[@q{Why are most of the early programs in a functional style?}  

 @a{We consider the functional style of programming the best starting point
 for two reasons. To start with, our decision is based on many years of
 experience with designing large systems in assembly, Pascal, C, and with
 teaching in similar languages. Functional programming is easier than
 anything else. Most importantly, functional programming focuses
 programmers on values, the fact that every function should produce a
 value, and that this value can be tested for correctness. }]

[@q{And the second reason?}

 @a{We really do consider the functional style of programming the proper
 starting point in middle school and high school. When you teach
 programming there, a functional approach has numerous, beneficial side
 effects. In middle school, it reinforces algebra and clarifies that
 you can create animations, games, and all kinds of fun and relevant
 products with algebra, not just calculate when trains leaving Pittsburgh
 and Philadelphia meet and crash. In high school, functional programming is
 in a symbiosis with trigonometry and geometry; with (pre)calculus and
 logic; and even with sciences that use mathematical models (physics,
 economics).}]

[@q{Should everyone use functional programming for all projects?}

 @a{No way! We are not functional ideologues; Racket---our language of
 choice---supports assignable variables, mutable structures and objects,
 iterative constructs, etc. Every programmer should think functionally and
 start functionally, but it is critical to know when assignment and
 mutation are needed. That ensures that they are used properly.}]

[@q{But the imperative-iterative style is so common. Why shouldn't we show
  novices the most common style?} 

 @a{Our experience shows that a prior understanding of functional style
 produces significantly stronger programmers than an immediate immersion
 into the OOP monoculture.}]

[@q{Couldn't this just mean that a good programmer must have studied
 several different languages?}

 @a{That's precisely what it means. Some universities, e.g., CMU and
 Harvard, swap the order. They teach conventional programming first and use
 an HtDP-like approach for the second course. The key is, however, that the
 students produce more than a dozen or two dozen lines of code in either
 style; they produce large programs in both.}
]

[@q{Aren't your students at a disadvantage when it comes to internships?} 

 @a{Yes and no. Yes, because we consider it a @emph{bad thing} to send
 students into the real world with one course in programming under their
 belt. What would you say if your pharmacist hired a student after a single
 semester of chemistry?}]

[@q{And no?}

 @a{No, because my experience at Northeastern---even more than at Rice,
 which attracts top-tier students like MIT and CalTech---suggests the exact
 opposite. After the introduction of the @ts curriculum, our students found
 @emph{more} programming co-op positions @margin-note*{A co-op position is
 an actual paid employment and our co-op employers systematically report
 back on the work and the quality of the work that our co-ops perform.}
 and our co-op employers expressed extreme satisfaction. Indeed, they
 complained that our MS students were worse program designers than our
 junior undergraduate co-ops. I can't think of a better confirmation than
 that.}]

]

@margin-note*{See @secref{coop} for a summary of Northeastern's experience
with introducing the @ts curriculum and its coop program.}

To really understand why these prejudices---and it is difficult to call
them anything else---are wrong, people will need to teach a course that
covers the entire HtDP curriculum and ideally a bridge to a regular OOP
course. I personally see the pay-off of our curriculum in a junior course
on software construction. In that course students construct programs of
10,000--15,000 lines of code and maintain them over the course of a
semester. 

