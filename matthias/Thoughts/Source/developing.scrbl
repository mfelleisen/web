#lang scribble/manual

@; TODO: 
@; algebra -> programming connection emphasize in TL 
@; conclusion about "try your own, but remember the trinity"


@(require "shared.ss" "growing-a-programmer.rkt")

@(define turing "http://www.ccs.neu.edu/home/matthias/OnHtDP/turing_is_useless.html")
@(define sicc "http://www.ccs.neu.edu/racket/pubs/#jfp2004-fffk")
@(define 2e "http://www.ccs.neu.edu/home/matthias/HtDP2e/index.html")
@(define c++ "http://www.ccs.neu.edu/home/matthias/Tmp/Cplusplus/")
@(define sam-david "http://arxiv.org/abs/1306.4713v2")
@(define kenichi "http://www.is.ocha.ac.jp/~asai/papers/tfpie2015.pdf")

@(define (htdp) @link[2e]{How to Design Programs})
@(define (fI) @italic{Fundamentals I})
@(define (fII) @italic{Fundamentals II})
@(define (logic) @italic{Logic in Computer Science})
@(define (ood) @italic{OOD})
@(define (swd) @italic{Software Dev})

@title*{Developing Developers}
@author{Matthias Felleisen}

@date{8 Sep 2015}

@section*{Abstract}

Northeastern offers a unique @margin-note*{But see @secref{unique}.} curriculum on programming.  Instead of the
currently fashionable programming language, it focuses on @emph{explicit
and systematic approaches to program design}.  To bring this idea across to
the full range of Northeastern freshmen, the first course uses a simple
teaching language that is tailored to our goals.  Follow-up courses explain
how to apply the design principles to industrial programming languages, how
they enable logical reasoning about code, and why they matter when
programmers deal with large and complex software. 

In parallel, these core courses on programming insist on presenting
programming as a people discipline. Students find out that people write
programs to inform other people of ideas. Working with compilers and
interpreters also teaches them that these tools provide only shallow
feedback. For true insight, they must turn to other people. Hence, students
work in pairs from the very first day in class. Pair programming forces
them to articulate their thoughts so that they can converse about
programs. Downstream courses also teach students how to present their ideas
to large groups and how to listen and evaluate such presentations.

@bold{Acknowledgments} Corky Cartwright, Bruce Duba, Robby Findler, Kathi
Fisler, Matthew Flatt, Dan Friedman, Gregor Kiczales, Shriram
Krishnamurthi, and Mitch Wand helped me hone this vision over 25
years. Many Northeastern colleagues have taught these core courses and
their feedback improved my initial vision: Amal Ahmed, Will Clinger, Pete
Manolios, Viera Proulx, Olin Shivers, Sam Tobin-Hochstadt, Jesse Tov, David Van Horn,
and Thomas Wahl. Dale Vaillancourt and Carl Eastlund, former PhD students,
were critical to my first attempt at @logic[].  Larry Finkelstein and
Richard Rasala put in place a playground where I could easily influence the
shape of the core courses.

@; -----------------------------------------------------------------------------

@(define nl @element['newline]{ })
@(define hs @element['hspace]{---})

@history[
 #:changed "1.9" @list{Wed Nov 15 17:11:18 EST 2017 changed title to what
 it should have been all along 
 @nl}
 #:changed "1.8" @list{Tue Mar 21 12:12:50 EDT 2017 garbled sentence from Ron Garcia
 @nl}
 #:changed "1.7" @list{Thu Feb 11 10:21:44 EST 2016 typos from Marc Kaufmann
 @nl}
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

 #:changed "1.0" @list{Wed Sep 16 15:07:49 EDT 2015: initial release @nl}
]

@; -----------------------------------------------------------------------------
@section{Explicit and Systematic Program Design}

Ninety-percent or more of the College's graduates will end up engineering
software for the first few years out of college. The College---which is us,
all the professors and instructors---owe them a solid preparation for this
task. Well-prepared students will stand out in industry and thus strengthen
our reputation. Bit by bit, they may also improve the currently sad state
of affairs of engineering software systems.

@margin-note{I first spelled out the ``explicit design'' idea in
@link[sicc]{Structure and Interpretation of the Computer Science
Curriculum} [@italic{JFP} 2004].}
@;
In response to this challenge, our College has developed a unique approach
to teaching over the past 12 years. The core curriculum radically differs
from traditional approaches in how it trains students as programmers and
problem solvers. The purpose of this essay is to sketch the ideas behind
the approach (this section) and its organization into courses (the next
one).

When these courses are taught properly, they not only improve the
preparation of our students for their first job as creators of software.
They also lay the foundation for the students' careers as project leaders,
managers of software teams, CTOs, CEOs, entrepreneurs, medical doctors, and
wherever else systematic problem solving matters.

@; ------------------------------------------------------------------

@subsection{Traditional Programming Courses} The vast majority of courses
on programming employ a ``tinker until it works'' approach. Instructors
tend to pick a currently fashionable programming language and then proceed
in a rather old-fashioned manner, dating back to the days of Fortran IV.
At the beginning, instructors show some version of a ``hello world''
program (console or GUI based), followed by simplistic input modes (again
console or GUI based), variable declarations and assignments, arrays and
loops.  Still further down the road, these courses may also introduce
functions, methods, and classes.

@margin-note{@;
  @bold{Q} What's the biggest lie in computing?
  @bold{A} ``It works.''}
@;
What students learn in such courses, is to mimic their instructors. In
classes and labs, they see code snippets that introduce new syntactic
constructs and spell out their pragmatics. Homework assignments ask them to
solve similar problems. A typical student will copy the snippets of code
from class and modify them until the program seems to work. Over the course
of a semester, the distance between the code snippets from class and those
needed to solve homework problems grows to test students' ability to
generalize. 

In sum, traditional programming courses teach programming
@emph{implicitly}, with students picking it up via mimicking and
experimenting. This approach may appeal to students who love to tinker with
gadgets and video games, but it also turns off many others who might be
equally talented for engineering actual software or benefit to the same
extent from a properly taught course on programming and problem solving.

@; ------------------------------------------------------------------
@figure["fig:dr" @list{Courses on program design}]{@recipe[.85]}
@; ------------------------------------------------------------------

@; ------------------------------------------------------------------
@subsection{Explicit Design Rules} @link[2e]@italic{How to Design Programs}
 is the first text book on programming that explicitly spells out how to
 construct programs in a systematic manner. One half focuses on
 @emph{structural design}, the other on @emph{design and use of
 abstractions}, @emph{generative recursion} (``divide and conquer''), and
 @emph{accumulators} (``loop variables'').

@Figure-ref{fig:dr} displays the @emph{design recipe} used for structural
 design. It consists of two dimensions: the @italic{y} axis specifies a
 six-step problem-solving process, the @italic{x} axis enumerates (some of)
 the forms of data with which programmers represent information, in
 increasing complexity.

The @emph{vertical direction} presents a six-step process that prompts students to 
@itemlist[#:style 'ordered

@item{read the problem statement, figure out the data that is needed to
represent the information of interest, and illustrate their insight with
concrete examples;}

@item{articulate a purpose statement that concisely describes what the
function or program is supposed to compute, including a signature;}

@item{work through functional examples, that is, explain what the function
or program is supposed to produce when given certain inputs, based on steps
1 and 2;}

@item{create an outline of the program, based on steps 1 and 2;}

@item{fill in the outline from step 4, using steps 2 and 3; and}

@item{turn the examples from step 2 into a test suite for the program from step 5.}
]
 Every step of the design process generates a well-defined outcome. When
 students ask for help, instructors can inspect these outcomes and thus
 diagnose the students' problems. To get students unstuck, every step also
 comes with a question-and-answer ``game'' that somewhat depends on the
 column of the design recipe but is ``parametric'' with respect to the
 actual problem. Instructors can use this ``game'' to help students along
 @emph{without} giving one-off hints for the specific problem at hand.
 Eventually students realize that this process exists so that they can
 learn to help themselves.

The @emph{horizontal direction} of the structural design recipe expands
 students' understanding of data. Roughly speaking, every language comes
 with a sub-language for data, and programmers choose certain forms of data
 to represent information from the domain of interest (``the
 world''). Atomic data is drawn from this domain, and processing atomic
 data demands domain knowledge. Because traditional programming courses
 often focus on processing atomic data (especially numbers), they rely on
 domain knowledge and thus fail to show how much computing and programming
 can contribute to systematic problem solving and design.  Every step along
 the horizontal axis increases students' knowledge of the world of data,
 taking them all the way to trees, forests, graphs, and so on. Also at each
 step, they must re-interpret the six steps from the design
 process. @margin-note*{@link[turing]{Turing is Useless} spells out this
 idea in more detail.}  Conversely, this organization implies that
 @emph{instructors may assign only homework problems that are within the
 @bold{convex hull} of students' @bold{design knowledge}} for a specific
 stage in their design development. 

A design-process approach guides students all the way through the
 composition of well-designed functions into complete programs, the
 creation of programming abstractions; the coding of ``divide-and-conquer''
 recursive algorithms; and the creation of algorithms that maintain
 invariants across iterations (``accumulators'').

Once students understand each of these design recipes, they also learn to
 choose among alternatives that produce equivalent functionality. For
 example, structural design naturally yields insertion sort algorithms,
 while generative recursion yields quick sort or merge sort algorithms.
 To make an informed choice, students need to learn about designing under
 constraints and, in computing, about big-O. 

@; ------------------------------------------------------------------
@subsection{The Design Process is General} 

Teaching explicit and systematic design introduces students to a general
 problem-solving approach that applies to many more domains than
 programming. A journalist can use it to plan a story. The first step calls
 for developing the background. Next comes the articulation of the thesis,
 the collection of illustrative examples, the creation of an outline based
 on facts, the writing, and the final fact-checking step. It is equally
 obvious that
 businessmen can tackle logistical problems in this manner, 
 engineers must follow a similar approach, 
 lawyers may analyze a case with it,
 scientists perform lab work in this way,
and
 surgeons are able to conduct operations with a systematic process. 

@; ------------------------------------------------------------------
@margin-note{Unsafe languages, such as C, C++, and Objective C, increase
 the number of dependencies and thus put an extra burden on the programmer
 when it comes to the inevitable search for, and elimination of,
 mistakes. A safe language is therefore a superior introductory language.}
@;

@; ------------------------------------------------------------------
@subsection{Programming is a People Discipline} The design-oriented approach
 gradually introduces students to the idea that programming is about coping
 with @emph{complexity} in software---which roughly corresponds to the
 number of dependencies among modules, classes, functions, methods,
 expressions, and statements. Without logical reasoning about designs,
 programmers quickly get lost in the thicket of dependencies.

Compilers, interpreters, and other IDE tools provide almost no help with
 controlling complexity; ACL2 and its relatives are too expensive for
 general programming problems.  Hence, programmers who need help (normally)
 turn to other programmers because they are people who can think.  It is
 therefore imperative that students develop the skill to converse about
 program designs, meaning they must learn to articulate their thoughts in
 all kinds of ways. The best way to do so, is to present programming as a
 discipline that is not about nerds sitting in a cubicle but people helping
 other people creating beautiful and well-designed artifacts.

@; -----------------------------------------------------------------------------
@section{Organizing the Idea into Courses}

@Figure-ref{fig:pc} presents a concise summary of the College's core
 programming courses in the form of a dependence graph.  Students majoring
 in computer science ought to have covered these courses by the time they start
 their second co-op. Students who just want a taste of programming and
 systematic problem solving take @fI[]. The following subsections spell out
 how these courses line up with the idea of teaching ``explicit, systematic
 design'' and the ``people skills'' that go with them.

@; ------------------------------------------------------------------
@figure["fig:pc" @list{Courses on program design}]{@diagram[.85]}
@; ------------------------------------------------------------------

@; ------------------------------------------------------------------
@subsection{Fundamentals I: Designing with Teaching Languages} The goals of the
first course are to
@itemlist[
@item{introduce novice programmers to the systematic and explicit design of programs}
@item{expose students with prior programming experience to design.}
]
All students---including those who never take another course on
programming---ought to appreciate (1) the idea of systematic problem
solving and (2) the complexities of creating well-engineered software.

When it comes to choosing a language for the first course, we must take
into account the above goals and two relevant theorems:
@;
@nested[#:style 'inset]{
 @bold{Theorem 1} Novice programmers make mistakes.}

@nested[#:style 'inset]{ 
 @bold{Theorem 2} A compiler and the run-time system articulate error
 messages under the assumption that the programmer knows the entire language.}
@;
These theorems have three immediate consequences relevant to @fI[]:
@;
@nested[#:style 'inset]{ 
 @bold{Corollary 1} An introductory course cannot serve a wide spectrum of
 complete novices if it uses an off-the-shelf (industrial) language.

 Examples of ill-suited languages include C++, Java, JavaScript, Python,
 Racket, and Scheme---even though they are, or were, used for
 first courses. Pascal is also too large, even though Wirth explicitly
 motivated Pascal as a ``small teaching language.''}

@nested[#:style 'inset]{ 
 @bold{Corollary 2} Reducing the size of the language improves its error messages.}

@nested[#:style 'inset]{ 
 @bold{Corollary 3} An introductory course needs @emph{a series of small
 languages} that suffice to illustrate the design recipes.}

@Figure-ref{fig:steps} summarizes this little excursion into the land of
social theorems with two simple graphs. The graph on the left shows how an
``off-the-shelf'' language may have a gentle curve for a short period, but
then poses a steep (learning) curve for every novice. The blue line in the
graph suggests how smooth the curve ought to be instead. The graph on the
right shows how to approximate the blue line with a step function---a
necessity because language technology is discrete.

@; ------------------------------------------------------------------
@figure["fig:steps" @list{Languages: steep walls vs continuous growth}]{
 @centerline{@wall[200 200] @hspace[10] @stepwise[200 200]}
}
@; ------------------------------------------------------------------


@fI[] uses four (out of five) steps, aka, teaching languages, collectively
known as @italic{*SL}. The first one (@italic{Beginning Student Language}
or @italic{BSL}) codifies students' notation from pre-algebra courses in
high school: function definitions, conditional function definitions, and
function applications. It extends this small set with conventional
(numbers, booleans) and unconventional (images) atomic data plus structure
definitions.  The downstream languages expand the expressive power of this
first language with compact notations for lists, local definitions, and
higher-order functions.

As for @bold{people skills}, @fI[] introduces students to the idea of
@emph{pair programming}. Students work in pairs for all homework
assignments. A pair consists of a ``pilot'' and a ``co-pilot.'' The former
is in control of the keyboard and the design process. To inform the latter,
the pilot explains the design aloud; the co-pilot checks the evolving
design against the question-and-answer game from the design recipe and
questions any deviations from the recipe. It is the task of the co-pilot to
engage the pilot in conversation. Partners switch roles on a regular basis.

Pair programming also helps students who are paired with partners of
unequal knowledge and skills. In the context of @fI[], these roles are
often non-obvious. Students who ``have always programmed'' tend to find
themselves in the role of misguided hack, who must be pushed back to the
ways of explicit design by the seemingly less knowledgeable partner.  
@;
@margin-note*{Teaching greatly enhances learning.}
@;
Even if experience with programming helps one of the partners, both
benefit: one by becoming a teacher, the other by having someone to talk to
even when no teaching assistants are around.

The course switches partnerships on a regular basis so that students get to
know other people and different ways of interacting with distinct
personalities. 

@; ------------------------------------------------------------------
@subsection[#:tag "trinity"]{A Note on the Trinity}

The trinity of design, teaching languages, and pedagogic IDE---in our case
DrRacket---smoothly takes students from plain pre-algebra courses to
full-fledged programming. Explicit design overcomes their fear of word
problems in algebra and eases them into the world of complex programs, all
the way to distributed communicating programs. The teaching language
presents a familiar language and gently move students up the slope. @fI[]
uses the DrRacket IDE for the teaching languages, which eliminates all
clutter that Eclipse, IntelliJ, and similar products come with. In essence,
DrRacket relates to the latter the way a single-engine teaching airplane
relates to a JumboJet; pilots always fly the former before they get into
the cockpit of the latter. 

Time and again people react to my presentations of this trinity.  One
common objection is that explicit design must work in all languages and
therefore we might as well indulge students, parents, chairmen, deans, and
egos by teaching the currently hot ``thing.'' On one hand, they are
correct. Explicit design works for all languages; if it didn't, we would be
wasting our students' time in @fI[] and fail them at a massive
scale. Indeed, it would not enable @fII[]. On the other hand, objectors
fail to see that the introduction of explicit design calls for a careful
composition of all the pieces that make for a novice-friendly environment:
accessible error messages from the chosen language and a pedagogic IDE
without clutter. Anyone who wishes to replace one element of this trinity
must consider the other two, too. 

@; ------------------------------------------------------------------
@subsection{Fundamentals II: Designing with Java} 

The goals of @fII{} are to show students how to
@itemlist[

@item{systematically design programs in the context of a real-world language}

@item{incorporate existing libraries into design.}
]
The course must therefore use a language that is currently used in industry
and comes with significant libraries.

With regard to @bold{design}, the course has three concrete goals: 
@;
@itemlist[

@item{add type checking}

@item{cover object-oriented programming, and}

@item{incorporate the idea of ``programming via composition of existing
building blocks.''}  
]

While the design concepts from @fI[] heavily rely on types in several
different ways, they do not assume type checking. The rationale behind this
choice is twofold. On one hand, in this day and age, many (if not most) of
our students will use a dynamically typed language like *SL for their first
co-op. They need a systematic process even more than those who end up with
a statically checked language. On the other hand, type checking just adds
another formal layer to the practice of programming, that is, adding error
messages to those from the reader, parse, and run-time system just adds to
the confusion about layers that affects novice programmers. Most mainstream
programming languages come with an explicit static type system, however,
and our students deserve to see how type checking jives with design.

@margin-note{The same people eventually recognized that C++ is @emph{not} a
proper object-oriented language because it does not allow programmers to focus
on objects as run-time values. A better terminology would have been
``value-oriented programming'' but this choice would conflict with the
narrow-minded use of ``value'' in the object-oriented community.}
@;
Similarly industrial programmers have known for a while that
``object-oriented programming won.'' What they mean with this statement, is
that languages introduced as object-oriented with classes and/or objects
dominate the world of engineering software. Examples are C#, Java,
JavaScript, Python, and Ruby [on Rails]. Fortunately, as Gregor Kiczales
said after adopting our approach at UBC, ``@htdp[] [meaning @fI[]] is the
best introduction to proper object-oriented programming.''  We cannot
expect our students to make this transition on their own,
however. Therefore @fII[] spends about 60% of the second semester on
explaining how the design concepts from @fI[] apply to Java-based
programming and on adapting the design concepts for abstractions---both
their creation and their use---to an object-oriented context.

The latter is also crucial for constructing programs from libraries and
frameworks. While real programmers spend some time creating components from
scratch, a lot of their work is to find frameworks or libraries that
provide part of the functionality and to plug those together. Our explicit
design approach covers this idea as the use of existing abstractions, but
@emph{additional research is needed to formulate useful design recipes}.

@bold{Notes} (1) Real-world languages such as Java obstruct proper design. For
example, both our approach to program design as well as the gang of four's
well-known design patterns lead to identical code for processing sequential
or tree-shaped data structures. Unfortunately, Java's failure to properly
implement tail-calls then forces programmers to reformulate the properly
designed pieces of code with @tt{while} and @tt{for} loops. 

(2) Sam Tobin-Hochstadt and David Van Horn implemented @link[sam-david]{
teaching languages for @fII[]} to bridge the gap between @fI[] and @fII[]
and used them to teach honors sections of the latter. The teaching
languages gradually introduced the concepts from object-oriented languages,
starting from a functional approach and matching the design concepts. If a
computer science unit has the luxury to spend an additional semester on
preparing their students for real-world programming, this approach is
highly commendable. @bold{End of Notes}

@margin-note{Viera Proulx proposed and implemented code reviews for @fII[].}
@;
With regard to @bold{people skills}, @fII[] is like @fI[] and adds a first
taste of code reviews. That is, @fII[] continues to have students program in
pairs. In addition, @fII[] provides the proper context to request a first code
review from students. One possibility is to assign a small project toward the
end of the course and to have students present an overview to the
instructor. An alternative is to have students present pieces from their
homework portfolio.

@; ------------------------------------------------------------------         
@subsection{Logic: Reasoning about Well-designed Code}

@margin-note{People often use the term ``type-safe'' languages. The term is
vague because untyped languages also come with sound prediction systems, and
``safety'' has no universal definition.}

Logic is to programming what analysis is to engineering. Engineers use
 analytic mathematics to make predictions about the robustness and behavior
 of their blueprints. Programmers continuously predict the behavior of the
 phrases they write down and compose. As programming language researchers
 have shown over the past 50 years, logic provides the proper foundation
 for programmers' predictions and logical meta-theory explains the validity
 of making predictions. More precisely, predictions correspond to theorems,
 validations for predictions are proofs, and program executions map to
 models. It is thus proper to call a validation system @italic{sound} if
 its predictions are always true statements about executions; an
 @italic{unsound} system makes correct and @emph{incorrect} predictions.

@margin-note{If a programmer is lucky, the bad array reference in C/C++
causes a seg fault.}

Consider arrays in a typed language. Roughly speaking, an array @tt{a} of
 type @tt{T} is a function that maps an index in some prefix of the natural
 numbers to instances of @tt{T}. Programmers can thus predict that applying
 @tt{a} to @tt{i}---often written as @tt{a[i]}---yields (bits that
 represent) some @tt{T} if the control flow reaches the point beyond the
 array reference. In a sound language such as Java or ML, this claim
 always holds; it roughly corresponds to the @italic{modus ponens} rule of
 classical logic. In C or C++, this claim is wrong. If @tt{i} is out of
 bounds, the array reference produces whatever random bits it finds and
 interprets them as elements of @tt{T}---even if doing so makes no sense.

When programmers create code, they continuously make, and rely on,
 predictions---consciously or subconsciously. This is simply how programming
 works, even if programmers do not design code but ``tinker until it works.''
 The logical term for making predictions is ``reasoning about programs.'' The
 predictions correspond to @italic{theorems} and the arguments in their
 support are @italic{proofs}.  In typed languages, for example, function types
 are theorems, the function definition is a proof, and the type checker
 ensures that the proof supports the theorem. If a function has a well-chosen
 name, other programmers can use the function based on its type and name.

Given this background, the goals of @logic[] are to
@itemlist[

@item{make reasoning about programs explicit}

@item{introduce students to tools that assist programmers with this task.}
]
 Students thus get a first taste of how it works, and they experience how much
 easier it is to reason about well-designed programs. 

@logic[] realizes the first goal with an introduction of classical
(propositional and first-order) logic, heavily emphasizing structural
induction as a proof method for establishing theorems about functions and
programs. Structural induction is dual to the design recipe of @fI[]---by
design---and therefore works particularly well.

The course motivates the second goal by applying logic to sizable
programs. Logical reasoning applied to such programs requires the
management of large number of details. Software is well-suited for managing
numerous details, so students @logic[] uses a proof assistant for the task
of scaling proofs to complete programs. 

ACL2, the chosen proof assistant, encapsulates a logic that closely
corresponds to the design recipe of @fI[]. If students properly design the
desired functions in @fI[], ACL2 can often prove the desired theorems
easily. If students tinker their way to a complete function, the proof
assistant tends to fail. In short, ACL2 naturally reinforces the explicit
design rules of @fI[].

@; ------------------------------------------------------------------
@subsection{OOD: Scaling It Up}

The primary goal of @ood[] is to deepen students' practical programming
 skills by scaling up the complexity of the projects, without changing the
 programming language from @fII[]. Instead of complete, but relatively
 small programs, students are expected to design program components and
 glue components together. Designing components also introduces the
 challenge of creating interfaces and protocols and, conversely, of using
 existing interfaces and protocols.

Interfaces and protocols often come with logical assertions that partly
 explain the implementations' behavior. A classical assertion may restrict the
 kinds of arguments a method can cope with, e.g., only positive integers or
 only an array of integers that add up to 100. A temporal assertion in an
 interface may require that an @tt{open} method is called before a
 @tt{read} method. 

While @logic[] shows how logical reasoning formally works on small
 functions and programs, @ood[] focuses on stating and exploiting such
 assertions during the informal prediction process that takes place when
 programmers design interfaces and code. Until formal methods researchers
 make formal reasoning affordable, this informal mode of thinking will
 inform the best designers in the field.

As feasible, @ood[] also scales up students' communication skills. Instead
 of presenting their designs and code to an instructor, students may present
 their work to the entire class. Instructors should encourage the class to
 comment on the content of the presentation.

@; ------------------------------------------------------------------
@subsection{Software Development: Putting it All Together}

@swd[] is basically a capstone of our core courses.  The ideal @swd[]
student has taken @ood[], completed the first co-op, and explored the
landscape of programming languages. What this student needs, is a chance to
get involved in the maintenance of code. More than any other task in the
realm of software, maintaining code shows why design matters, why logical
reasoning matters, and why people skills matter.

To emphasize these points, @swd[] instructors ought to allow students to
choose their favorite programming language for the course project(s). The
students should not perceive the chosen language as a constraint, though
they will necessarily find out that it is one. If they don't, instructors
have chosen the wrong project.

Since the ideal @swd[] student is @emph{not} able to manage a large project,
instructors ought to introduce students to this aspect of engineering
software @emph{explicitly}---that is, not via ``mimic and modify.'' One way
to accomplish this goal is to have students design parts of the projects
each week, to expose the weaknesses of their designs during code review, and
to then provide good versions of these designs later in the semester. 

The key to @swd[] is that students must revisit code that they or their
peers created weeks ago and that the overall project is complex and large
(say more than 5,000 lines of code in any language) that this maintenance
task becomes non-trivial.  This step may take the form of fixing bugs,
adding features, replacing features, and even subtracting them. To complete
such tasks, students must reconstruct the thoughts that the creators of the
code had---and often did not write down as assertions or other validated
statements. Hence, if code repositories are rotated among the students,
this task drives home most clearly why (1) such additional assertions and
comments matter and (2) pair programming leaves behind residue of design
knowledge.

@swd[] also expands the @bold{people skills} that go with engineering
software. Students continue to program in pairs to hone their interpersonal
communication skills. In addition students must get a chance to present
several times to their peers in class to improve their presentation
skills. Finally, @swd[] is also the ideal point for introducing students to
the act of reviewing their peers' code.  One way to achieve this goal is to
follow the IBM ``white room'' practice of code reviews, which over years of
experimentation suggests that 	       
@;
@itemlist[

@item{code reviews benefit from a general familiarity with the task;}

@item{the result of code reviews does @emph{not} depend on prior attempts
to read designs or code;}

@item{the ideal code review panel consists of three panelists: (1) a head
reader who guides the panel's interaction with the presenters, (2) a
secondary reader, and (3) a secretary who primarily focuses on writing down
the issues revealed during the review and suggestions made.}

]
Instructors can inform panelists of their performance and can judge the
secretary's work by editing the review memo before it goes from the panel
to the presenters. 

@bold{Note} Instructors get a lot of respect in this course if @emph{they
implement} the project and are willing to present @emph{their own code} at
any point in time. @bold{End of Note}

@; -----------------------------------------------------------------------------
@section{What's Missing?}

The College's core curriculum has stood the test of time. Our co-op
employers recruit our students in good and bad times, and many are put to
work on actual programming projects. It has also become clear that our
students are still missing out on some skills that they need to become
well-rounded engineers of software.

@bold{Independent Exploration} Programming is like playing an instrument.
The more we practice, the better we get at it. Programming is also like
science. Constantly pushing the boundaries of our knowledge is key. What I
often find, however, is that our students do not seem to understand that
programming @emph{beyond the classroom} is essential to their growth. Why
do our students lack incentives to explore on their own? What can we do to
provide incentives? 

@margin-note{Companies are clearly recognizing that tricky coding questions
about algorithms knowledge do not identify the best developers.}
@;
@bold{Performance Debugging} Students also have a hard time connecting
 knowledge from algorithms to program design. While regurgitable knowledge
 from our algorithms course might currently help with job interviews,
 developing software needs a specific skill set from algorithms that
 colleges in general fail to teach:
@;
@itemlist[
@item{use a performance debugger to identify hot spots in programs,}

@item{analyze hotspots and their surroundings,}

@item{create alternative solutions, and}

@item{set up relevant performance test suites to easily compare different solutions.}
]
 A course based on the above cycle would motivate the dry material of a
 standard algorithms course and turn homework problems into hands-on
 assignments, which might make the course more accessible than a pure
 theory course. Creating such a course on performance debugging would
 further set apart our curriculum as novel and innovative. 

@margin-note{See @link[c++]{the course charter} that Peter D., Alan M.,
Magy S., Abutalib A., and myself worked out.}

@bold{Unsafe Programming} For better or worse, the world now has a software
infrastructure built in unsound (unsafe) languages, such as C, C++, or
Objective C. Over the past decade or so, people have recognized this
problem and have smothered the infrastructure software with layers created
in safe languages. One approach is to use (reasonably) safe scripting
languages that allow easy access to the unsafe layer as needed. Python
scripting is a prime example for this mode of work. 

When programmers work in a mixed context they encounter entirely new
problems: seg faults, core dumps, or programs that output implausible 
results. Our students must learn to write code in this world, pinpoint
bugs, and debugging techniques that take into account lack of soundness. 
The College has finally created a course along these lines; time will tell
whether it accomplishes its mission. 

@bold{Software Engineering} Once students know how to develop programs
systematically, they may wish to explore some of the software engineering
topics in depth. Three topics stand out in my mind: 
@;
@itemlist[

@item{@bold{testing}---While all five core courses heavily emphasize unit
testing, our students would greatly benefit from a course that exposes them
to the wider topic---regression testing, black-box and white-box testing,
etc.---as well as the currently most widely used testing methods---random
testing and mutation testing.}

@item{@bold{programming in a team}---None of the five core courses are
suitable for true team programming, which is quite different from pair
programming. Most of our graduates will end up working in teams and
preparing them for this style of work seems critical.}

@item{@bold{software modeling} -- Software engineers benefit from
``executable'' models of their plans as much as architects like to simulate
3D walk-throughs of blueprints. Mapping such a model to constraint solvers
may reveal oversights, conflicts, hidden constraints and other issues that
become expensive to fix if they are not discovered in time. Researchers
like Daniel Jackson and Emina Torlak have clearly demonstrated the value of
modeling software blueprints and have made some effort to turn their
insights into courses. Perhaps it is time for Northeastern to catch up.}

]

In addition to these topics, the College must also pay attention to
emerging domains where software will play a critical role. No matter what
courses are offered though, the instruction should emphasize explicit ideas
over ``mimic and learn implicitly.''

@; -----------------------------------------------------------------------------
@section[#:tag "unique"]{P.S. Uniqueness}

Our College is no longer the only computer science unit that teaches an
explicit and systematic approach to programming. A number of colleagues
have adapted our approach to their special needs and contexts:  
@itemlist[

@item{@bold{Brown} teaches two versions of a like-minded first-year
curriculum. One covers explicit and systematic design in untyped and typed
functional (teaching) language as well as Java. Krishnamurthi's alternative
introduction synthesizes our freshman course with an algorithmic course
based on
@link["http://www.amazon.com/Introduction-Algorithms-A-Creative-Approach/dp/0201120372"]{Udi
Manber's excellent book}.}

@item{Kathi Fisler mapped out an adaptation of our first-year curriculum at
@bold{WPI}. Her adaptation improved on several aspects of @fII[]; her
``honors'' variant of @fI[] actually deserves the name.}

@item{Prabhakar Ragde at @bold{Waterloo} has created three flavors of
courses similar to our @fI[]: ``regular,'' ``non-major,'' and ``advanced.''
All second-semester versions move into the design of imperative programs
inspired by the remaining material of HtDP/1e. Logic is covered in the
``advanced'' track using Haskell.}

@item{Gregor Kiczales at @bold{British Columbia} offers several different
tracks for the last few weeks of the first course. Each shows students how
to apply explicit design in a range of scripting languages, tailored to
certain majors. He also created a Coursera version of the course, dubbed
@italic{Systematic Programming}; this on-line version has attracted several
brilliant young high school students to the Racket community.}

@item{At the @bold{University of Chile}, Éric Tanter uses Python to teach
HtDP.}

@item{Mike Sperber merged @fI[] and @logic[] into a single course at
@bold{Tuebingen}, developed appropriate variations of our teaching
languages, and published a popular text book in German on the course.}

@item{Kenichi Asai from @bold{Ochanomizu University} has
@link[kenichi]{ported the GUI framework} for teaching @fI[] to OCaml and
experimented with a functionally typed course in the third semester. His
department also offers a regular version of @fI[].}

]
A fair number of other universities (e.g. Chicago, Delaware, Northwestern,
Utah) and colleges (e.g., Boston College, Vassar) teach other variations on the
first and second course, but I am not familiar with all of their
improvements and variations.
