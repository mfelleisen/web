#lang scribble/base

@(require "shared.ss")

@title*{The Future of Programming Languages at CCIS}

@date{11 Nov 2010}

@; -----------------------------------------------------------------------------
Historically programming language research has pursued two independent, somewhat
conflicting goals. On the one hand, programming languages enabled programmers to
produce software applications effectively. Without a programming language, the
computer is a useless piece of hardware.  On the other hand, the existence of
programming languages has insulated the programmer from the rapid developments
in hardware. Computer engineers could ruthlessly improve the performance of the
raw hardware while programmers didn't have to change much in their programs to
benefit from these developments.

After more than 50 years, the programming languages field is as vibrant as
ever. Indeed, for the past decade, the field has experienced a veritable
renaissance.  Three relatively recent major developments have affected the
research in the field---and will continue to do so in the foreseeable future.

First, the ever increasing interconnectedness of software systems has taught
programmers over the past 15 years that safety and security properties of
programming languages are as important as performance.  A safe programming
language ensures that every program delivers a fundamental level of safety,
independent of its programmers' care and expertise. Safety plays a critical
element for building systems efficiently and for building secure systems. For
the construction of systems, safety enables programmers to find and fix errors
early and quickly, thus reducing the expense of system construction. For the
security of systems, safety closes important holes in software applications
through which hostile parties have gained access to protected information in the
past.

Language designers ensure safety with a mix of type systems, run-time checks,
and memory management. In addition, they develop novel language constructs to
strengthen the safety guarantees of programs, with a special focus on concurrent
and parallel programs. To establish safety properties, researchers prove
theorems about language designs and language-processing tools (type checkers,
static analysis, optimizers, debuggers, etc). While researchers used manual
proofs in the past, automatic theorem provers and model checkers have matured to
the point where they are applicable to problems in programming languages.

Over the past 25 years, NEU's CCIS researchers have established themselves as
leaders of this area with a large amount of work on a diverse set of
topics. Clinger and Wand were some of the first researchers to prove entire
compilers correct---by hand. Felleisen's technique for proving the soundness of
a type system is by far the most widely used format. With his dissertation,
Shivers set the tone for dealing with advanced program analysis tools. All of
them will continue to work in this area, though none of them has sufficient
experience with theorem provers or model checkers. The College expects to fill
this gap by hiring a person between formal methods and programming languages.

Second, the emergence of the world-wide web has sharply accelerated the use of
so-called scripting languages. While scripting languages for program development
environments have been in use since the 1970s, the "plug in" nature of web
servers and web browsers created two new platforms for delivering software. On
the server side, programmers turned to scripting languages such as Python, PHP,
and Ruby in order to turn the static web into an interactive web. By now,
JavaScript, ActionScript, and similar browser extensions are the only (target)
language that programmers use to deliver content on the browser side. Recent
estimates suggest that already more than half of all new software produced is
written in scripting languages.

None of the widely used scripting languages emerged from academic labs. Hence
many exhibit fundamental design flaws. In particular, they come without safety
analysis and proofs, though the designers typically intend to produce safe
languages. The success of these new languages demonstrate a need that most
academic researchers have ignored. Sooner or later, however, scripting will need
serious attention from programming language researchers.

Two CCIS researchers took scripting seriously from the beginning. Shivers in
1991 produced one of the first shell scripting languages for Unix, the
Scheme-based "scsh" system. Felleisen and his team have worked on recovering
design and type information from scripts since the mid 1990s. Furthermore, the
entire crew of CCIS researchers has extensive experience with dynamic languages
and intends to work on principles and frameworks for improving their design. 

Third, almost all programmers will continue to demand compilers that run
fast. This statement is true for traditional domains, e.g., science and
engineering, as well as new domains, e.g., web scripting.

As mentioned, in the past programming languages almost transparently translated
improved hardware performance into improved performance for existing
programs. Due to physical limitations, this transparent delivery is no longer
possible. In order to circumvent the physical limitations, computer engineers
have started creating parallel computers (so-called multi-core machines) and
programming language researchers must adapt to this new situation with the
development of new compiler technology and new programming languages.

While CCIS researchers do not conduct scientific and/or engineering compiler
research, they are actively working on the performance challenge of scripting
languages. Roughly speaking, contemporary scripting languages suffer from the
same problems as early implementations of dynamic languages (Lisp, Scheme,
Smalltalk, Prolog). Indeed, some of them introduce additional dynamic mechanisms
that pose novel challenges to compiler writers. The CCIS researcher will draw on
their extensive experience in implementing compilers, static analyses,
optimizers, and run-time systems to improve the state of scripting language
implementations. The College is thus well positioned to play a leading role in
this arena.
