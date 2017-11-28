#lang scribble/base

@(require "shared.ss")

@title*[#:tag "why-pl2"]{Why teach PhD core courses, with programming languages}

@date{17 Jan 2012}

In early 2010, a @seclink["what-is-pl"]{senior colleague challenged the
idea of teaching a required course on programming languages in the PhD core
curriculum}. Now said senior colleague is beginning to challenge the very
idea of a core curriculum. 

This raises the question whether 
@;
@nested[#:style 'inset]{intellectual disciplines, such as CS, have a core
and, if so, how to define it.} 
@;
I will rephrase this question as follows to make the answer obvious: 
@nested[#:style 'inset]{Is there fundamental knowledge in CS that, in
principle, is needed in every other field.}
Conversely, such collections of knowledge make up the core of the
discipline. Once we ask the question this way, we have a simple test for
core knowledge. We point at another field within CS, say graphics or
security, and question how some candidate for 'core'ness may
contribute. 

For programming languages, in particular, this procedure shows how deeply
it is connected to almost everything we do. Take security and
languages. For decades, many programmers and researchers have failed to
understand type safety and memory safety, and, as a result, we have
suffered exploits due to out-of-bounds errors and @tt{null} pointer
accesses. @margin-note*{Safety follows from the main theorem of PL, also
called the type soundness theorem. Any self-respecting PL course should
introduce the theorem and sketch a proof.} How about graphics and
languages?  Years ago I sat through a colloquium talk at Rice where
@hyperlink["http://www.maa.org/news/101509deroseint.html"]{Tony DeRose}
explained the design of a small language for describing geometric
surfaces. From what I understand DeRose went to Hollywood and turned his
research into award-winning animations at Pixar. Program verification? If
you don't understand the semantics of languages, how are you going to
verify the behavior of programs in this language? Hardware anyone? A wide
spectrum of programming languages ideas, especially ideas from the
functional world, have been turned into hardware description languages and
some became the basis for successful companies. Go on, pick your field and
you will see that knowledge from programming languages can help.

For algorithms, systems, and theory, we can obviously make similar
arguments. No need to waste space on these.

For other fields, say graphics, it is impossible to show such universal
usefulness to other areas in CS. On occasion, however, researchers in
graphics encounter problems that challenge people in core areas. It would
be foolish of programming language researchers to ignore such application
problems.  They re-prove how important a core area is and how many
contributions it can make. Quite the opposite, the day application areas no
longer pose problems for a core area, the latter is doomed to the dustbin
of history.

Now that we can distinguish core areas from others, we may raise the more
important question of 
@;
@nested[#:style 'inset]{whether the common PhD curriculum should focus on
core areas.} 
@;
In @bold{theory}, the answer is obviously affirmative. A discipline that
doesn't expect its PhD students to know the basics of the common core is
intellectually bankrupt. How else can a graduate of a PhD program defend
the integrity of CS itself? Good core courses will enable our PhD students
to articulate the scientific nature of our discipline. The opposite is to
short-sell CS as a random collection of hacks and tricks that make nice
little entertaining machines work smoothly and securely. This is a goal
worth working for, and a core is what is needed.

Even in theory, teaching the basics of the core also has practical
value. Given that (almost) every other field can benefit from knowledge of
a core area, it is likely that, over the course of a career, a researcher
will encounter a situation where this core knowledge helps solve a
domain-specific problem. While it is unlikely that a core course teaches
exactly the needed knowledge, a well-trained researcher knows where to
start the search from a shred of a cross connection.

In @bold{practice}, the answer is a function of many different variables
and depends on the individual department.---If the department has capable
and inspiring researchers in the agreed-upon core areas, the theoretical
answer is the practical answer. I'd rather not address the problem for a
context where the antecedent isn't true.---If the department is
particularly strong in an application area, say robotics, the question
should not become whether students should see robotics @emph{in lieu} of a
core area but whether there should be room for a required course in a
specific application area. As I have argued above, application areas keep
core areas honest by challenging them with fundamental problems, and I
consider it obvious that PhD students should therefore be exposed to
application areas. When the department has strong application areas,
students should probably give a choice of application area courses. 

An alternative practical answer is that PhD students should always come
from sufficiently strong undergraduate programs. In other words, whatever
undergraduate programs teach in a core area is good enough, and when
students arrive at their new program, we might as well get on with the
business of training them in our favorite fields. This answer overlooks a
major problem, however. Many undergraduate programs cannot teach core areas
at the research level, because they lack suitable faculty. Let's make this
concrete. @margin-note*{No, this situation is not ideal. It places
under-prepared PhD students along side well-prepared students and thus
creates tension within a class of PhD students. But life isn't fair. We can
only try to give people a chance.}  A typical ACM-style undergraduate
course teaches a "survey of programming language" course. In such a course,
students get to see a smattering of programming languages and write a few
hundred lines of code in languages that are not taught in the introductory
course. Sadly this kind of course is completely inadequate to convey the
underlying principles of PL; it's as if we were to teach
engineering-calculus to math majors and say that's good enough for an
understanding of topology.  In short, if we do not wish to reject the
graduates of such programs out of hand, we must offer them courses on the
core of CS once they arrive in our PhD programs.
